import os
import subprocess
import sys
import hashlib
from multiprocessing import Pool
import multiprocessing as mp
from functools import partial

shexml_first_part = r"""
IMPORT <ShExMLTemplates/partial/HoldingsHeader.shexml>
SOURCE holdings <holdings\holdings_"""

shexml_second_part = r""".json>
IMPORT <ShExMLTemplates/partial/HoldingsIterators.shexml>
IMPORT <ShExMLTemplates/partial/MatcherLanguages.shexml>
IMPORT <ShExMLTemplates/partial/MatcherLanguagesCodes.shexml>
IMPORT <ShExMLTemplates/partial/MatcherLanguageCode2Digit.shexml>
IMPORT <ShExMLTemplates/partial/HoldingsShapes.shexml>
"""

created_files = []

def call_shexml(i, output_filename, hash_filename, content_filename):
    subprocess.call(["java", "-Dfile.encoding=UTF-8", "-jar", "shexml.jar", "-m", i, "-o", output_filename, "-id", "-nu"])
    md5 = hashlib.md5()
    with open(content_filename, "r", encoding="utf-8") as content_file:
        with open(hash_filename, "w") as hash_file:
            md5.update(''.join(content_file.readlines()).encode())
            hash_file.write(md5.hexdigest())

def convert_to_rdf(i, created_files, folder):
    index = created_files.index(i)
    total = str(len(created_files))
    output_filename = "./shexmlOutputHoldings/holding_" + str(index + 1) + ".ttl"
    content_filename = "./" + folder + "/holdings_" + str(index + 1) + ".json"
    hash_filename = "./" + folder + "_hash/holdings_" + str(index + 1) + ".md5"
    print("Mapping file " + str(index + 1) + " of " + total + " in " + output_filename)
    if os.path.isfile(output_filename) and os.path.isfile(hash_filename):
        md5 = hashlib.md5()
        with open(hash_filename) as hash_file:
            with open(content_filename, "r", encoding="utf-8") as content_file:
                md5.update(''.join(content_file.readlines()).encode())
            if md5.hexdigest() == ''.join(hash_file.readlines()):
                print("Output file "  + output_filename + " is already up to date")
            else:
                call_shexml(i, output_filename, hash_filename, content_filename)
    else:
        call_shexml(i, output_filename, hash_filename, content_filename)

if __name__ == '__main__':

    folder = sys.argv[1]
    parallel = sys.argv[2] if len(sys.argv) > 2 else None

    print("Creating ShExML files for holdings in folder: " + folder)

    index = 0
    for i in os.scandir(folder):
        filename = "holdings_" + str(index + 1) + ".shexml"
        f = open("./shexmlRulesHoldings/" + filename, "w", encoding="utf-8")
        f.write(shexml_first_part + str(index + 1) + shexml_second_part)
        f.close()
        created_files.append("./shexmlRulesHoldings/" + filename)
        print("Created file " + filename)
        index += 1

    print("Calling ShExML files...")
    number_of_cpus = mp.cpu_count() // 2

    if parallel is not None and parallel == "--parallel":
        with Pool(number_of_cpus) as p:
            p.map(partial(convert_to_rdf, created_files=created_files, folder=folder), created_files)
    else:
        for i in created_files:
            convert_to_rdf(i, created_files, folder)
    
        
           

