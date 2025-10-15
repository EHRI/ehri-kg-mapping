#!/bin/bash

echo "" > validationReport.txt # Clears the validation report file
echo "" > shexCommandOutput.txt # Clears the ShEx command output file
echo "" > shaclCommandOutput.txt # Clears the SHACL command output file

if [ ! -d apache-jena ]; then
    echo "Downloading Apache Jena..."
    curl -L https://dlcdn.apache.org/jena/binaries/apache-jena-5.5.0.zip -o apache-jena.zip
    unzip -q apache-jena.zip -d apache-jena
fi

#export _JAVA_OPTIONS="-Xmx12g"

shex="apache-jena/apache-jena-5.5.0/bin/shex"
shacl="apache-jena/apache-jena-5.5.0/bin/shacl"

iterative_execution() {
    conformant=0
    non_conformant=0
    type_name=$1
    schema=$2
    shape_map=$3
    shift 3
    for filename in $@; do
        validation_result=$($shex validate --schema $schema --data $filename -m $shape_map 2>> shexCommandOutput.txt)
        conformant_partial=$(echo "$validation_result" | grep "Status = conformant" | wc -l)
        non_conformant_partial=$(echo "$validation_result" | grep "Status = nonconformant" | wc -l)
        conformant=$(($conformant + conformant_partial))
        non_conformant=$(($non_conformant + non_conformant_partial))
        { echo "$validation_result" | grep "Status = nonconformant" || true; } >> validationReport.txt
        echo "Validating $filename: $conformant_partial conformant, $non_conformant_partial non-conformant"
    done
    echo "$type_name: $conformant conformant, $non_conformant non-conformant"
}

iterative_execution_shacl() {
    valid_files=0
    non_conformant=0
    type_name=$1
    schema=$2
    shift 2
    for filename in $@; do
        validation_result=$($shacl validate --shapes $schema --data $filename 2>> shaclCommandOutput.txt)
        non_conformant_partial=$(echo "$validation_result" | grep "sh:Violation;" | wc -l)
        if [ $non_conformant_partial -eq 0 ]; then
            valid_files=$(($valid_files + 1))
        fi
        non_conformant=$(($non_conformant + non_conformant_partial))
        echo "$validation_result" >> validationReport.txt
        echo "Validating $filename: $non_conformant_partial errors"
    done
    echo "$type_name: $valid_files valid files, $non_conformant errors"
}

countries=$($shex validate --schema shapes/1.0.2/countries.shex --data countries.ttl -m shapes/1.0.2/countries.smap 2>> shexCommandOutput.txt)
conformant=$(echo "$countries" | grep "Status = conformant" | wc -l)
non_conformant=$(echo "$countries" | grep "Status = nonconformant" | wc -l )
{ echo "$countries" | grep "Status = nonconformant" || true; } >> validationReport.txt
echo "Countries: $conformant conformant, $non_conformant non-conformant"

iterative_execution Institutions shapes/1.0.2/repositories.shex shapes/1.0.2/repositories.smap shexmlOutputInstitutions/institutions_*.ttl
iterative_execution Holdings shapes/1.0.2/holdings.shex shapes/1.0.2/holdings.smap shexmlOutputHoldings/holding_*.ttl
iterative_execution Terms shapes/1.0.2/terms.shex shapes/1.0.2/terms.smap shexmlOutputTerms/term_*.ttl
iterative_execution Camps shapes/1.0.2/camps.shex shapes/1.0.2/camps.smap shexmlOutputCamps/camp_*.ttl
iterative_execution Ghettos shapes/1.0.2/ghettos.shex shapes/1.0.2/ghettos.smap shexmlOutputGhettos/ghettos_*.ttl
iterative_execution People shapes/1.0.2/people.shex shapes/1.0.2/people.smap shexmlOutputPeople/people_*.ttl
iterative_execution CB shapes/1.0.2/cb.shex shapes/1.0.2/cb.smap shexmlOutputCb/cb_*.ttl

countries=$($shex validate --shapes shapes/1.0.2/countries.shex --data countries.ttl 2>> shaclCommandOutput.txt)
non_conformant=$(echo "$validation_result" | grep "sh:Violation;" | wc -l)
echo "Countries: $non_conformant errors"

iterative_execution_shacl Institutions shapes/1.0.2/repositories.shacl.ttl shexmlOutputInstitutions/institutions_*.ttl
iterative_execution_shacl Holdings shapes/1.0.2/holdings.shacl.ttl shexmlOutputHoldings/holding_*.ttl
iterative_execution_shacl Terms shapes/1.0.2/terms.shacl.ttl shexmlOutputTerms/term_*.ttl
iterative_execution_shacl Camps shapes/1.0.2/camps.shacl.ttl shexmlOutputCamps/camp_*.ttl
iterative_execution_shacl Ghettos shapes/1.0.2/ghettos.shacl.ttl shexmlOutputGhettos/ghettos_*.ttl
iterative_execution_shacl People shapes/1.0.2/people.shacl.ttl shexmlOutputPeople/people_*.ttl
iterative_execution_shacl CB shapes/1.0.2/cb.shacl.ttl shexmlOutputCb/cb_*.ttl