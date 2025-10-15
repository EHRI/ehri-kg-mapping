import os
import subprocess
import sys
import hashlib
from multiprocessing import Pool
import multiprocessing as mp
from functools import partial

shexml_first_part = r"""
IMPORT <ShExMLTemplates/partial/CBHeader.shexml>
IMPORT <ShExMLTemplates/partial/MatcherLanguageCode2Digit.shexml>
SOURCE cb <cb/cb_"""

shexml_second_part = r""".json>
IMPORT <ShExMLTemplates/partial/CBIteratorsAndShapes.shexml>
"""

created_files = []

def call_shexml(i, output_filename):
    subprocess.call(["java", "-Dfile.encoding=UTF-8", "-jar", "shexml.jar", "-m", i, "-o", output_filename, "-id", "-nu"])

def convert_to_rdf(i, created_files, folder):
    index = created_files.index(i)
    total = str(len(created_files))
    output_filename = "./shexmlOutputCb/cb_" + str(index + 1) + ".ttl"
    content_filename = "./" + folder + "/cb_" + str(index + 1) + ".json"
    print("Mapping file " + str(index + 1) + " of " + total + " in " + output_filename)
    if os.path.isfile(output_filename):
        print("Output file "  + output_filename + " not created as it already exists")
    else:
        call_shexml(i, output_filename)



if __name__ == '__main__':

    folder = sys.argv[1]
    parallel = sys.argv[2] if len(sys.argv) > 2 else None

    print("Creating ShExML files for terms in folder: " + folder)

    index = 0
    for i in os.scandir(folder):
        filename = "cb_" + str(index + 1) + ".shexml"
        f = open("./shexmlRulesCb/" + filename, "w")
        f.write(shexml_first_part + str(index + 1) + shexml_second_part)
        f.close()
        created_files.append("./shexmlRulesCb/" + filename)
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
    
        
           

