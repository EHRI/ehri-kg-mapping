# EHRI KG mapping

This repository hosts the mapping files and all the orchestating resources for converting the [EHRI Portal data](https://portal.ehri-project.eu/) to the [EHRI Knowledge Graph (EHRI-KG)](https://lod.ehri-project-test.eu/). The mapping rules follow the definitions of the [EHRI Ontology](https://lod.ehri-project-test.eu/ontology/) which aligns as much as possible to the [Records in Contexts Ontology (RiC-O)](https://www.ica.org/standards/RiC/ontology) and, where not possible, extends it using [schema.org](https://schema.org/) or custom properties.

The latest conversion can be accesed through a dedicated LodView instance: [https://lod.ehri-project-test.eu/](https://lod.ehri-project-test.eu/).

> To know more about this project and its current status you can visit the [EHRI-KG project website](https://ehri-kg.ehri-project.eu/).

## Current conversion versions
* EHRI Ontology: 0.1.0
* RiC-O: 1.0.2

## Crosswalks
In order to facilitate an easier interpretation of the mapping rules, and how the different EHRI Portal attributes are aligned against their counterpart ones in RiC-O, schema.org and the EHRI Ontology, a set of crosswalks files are offered under the `crosswalks` folder:
* ehri2rico0.2_old.csv: Contains the old conversion to the draft RiC-O 0.2 version.
* ehri2rico1.0.2.csv: Contains the current alignment to RiC-O 1.0.2 as well as to the first release of the EHRI Ontology.

## How to launch the conversion?
The conversion process is designed to be unattended and you can start it by using the following command:

```
$ bash convertAll.sh
```

The script will generate several outputs (which are further explained later) and a final file (`allWithExtras.ttl`) containing the merged results from all the different conversion steps. This Turtle file is ready to be used by any application or directly uploaded to a triple store.

Due to the high number of files and the long conversion time, the script incorporates a resuming mechanism, ensuring that already downloaded or converted files are not reprocessed. This allows to run the process at intervals or recuperate the process after an error (e.g., a network failure).

If at any point, you desire to start from scratch, you can always invoke the command below to remove all the downloaded and converted files.

```
$ bash removeAll.sh
```

### Editing mapping rules
The mapping rules are centralised under the `ShExMLTemplates` folder. Be aware that some of the file import content from other files or use common features centralised in auxiliary files (e.g., functions in Scala under the `functions` folder).

Therefore, changes pertaining to how the output should be generated should be introduced here. Introducing changes in other files or folders will drive to unexpected results or even the loss of the introduced changes.

### Steps of the conversion
The download and conversion processes are divided per entity type, guaranteeing that the conversion of each entity can be rerun separately and that a change on one entity type does not mean having to recreate the whole conversion. Moreover, the download script creates a single file for each of the pages on the API which makes the conversion much more approachable than converting a big file in one go.

Presently, the following entities are included in the conversion:
* Countries
* Institutions
* Holdings (or Documentary Units)
* People
* Corporate Bodies (including Families)
* Terms (links to terms only)
* Ghettos (links to ghettos only)
* Camps (links to camps only)
* Links (creator and copy links)

Based on this division, each conversion will generate a number of dedicated folders and files according to the following schema.

Example for countries:
* countries (this folder will contain the downloaded files from the API for the countries)
* shexmlRulesCountries (the created mapping rules based on the ShExML template and on the downloaded files)
* shexmlOutputCountries (the Turtle files obtained after the conversion)
* countries.ttl (the unified Turtle file obtained after merging all the files under the folder shexmlOutputCountries)

### Additional data
The conversion is enriched with additional data which does not require to be transformed in order to be part of the final output. As such, this data is included in the final output by the `convertAll.sh` script. Nevertheless, the `all.ttl` file contains the results without the mentioned enrichment, in case a standalone version is needed for testing or debugging purposes.

Right now, the following data is added to the final result:
* EHRI Terms (as SKOS thesaurus)
* EHRI Ghettos (as SKOS thesaurus)
* EHRI Camps (as SKOS thesaurus)
* owl:sameAs links to DBpedia (languages)
* owl:sameAs links to CDEC (people)

## Validation
In order to validate the results of the conversion and its adherence to the EHRI Ontology, a set of SHACL and ShEx validation rules are provided under the `shapes` folder. These were initially generated using ShExML capability to generate ShEx and SHACL from a provided set of mapping rules and further fine-tuned to cover all the requirements imposed by the data model. The validation process for both SHACL and ShEx can be executed using the following script:

```
$ bash validateAll.sh > validationResults.txt
```

This script will validate all the different files per entity and produce the subsequent output files:
* validationResults.txt (contains the validation results for each file as well as an aggregated summary per entity)
* validationReport.txt (contains the validation results as extracted from the Apache Jena output)
* shaclCommandOutput.txt (contains any possible erros encountered during the execution of the SHACL validation)
* shexCommandOutput.txt (contains any possible erros encountered during the execution of the ShEx validation)

> Disclaimer: This part of the project is still a work in progress, so not all the converted files will validate succesfully. A full working validation may require further formalisation of the data and/or further fine-tuning of the validation rules.

## Minimum Requirements
| Tool | Version |
----------|----------
| JRE     | 17.x    |
| Python  | 3.x     |

The following libraries are downloaded during the conversion process:
| Library | Version |
----------|----------
| ShExML  | 0.5.4   |
| Apache Jena (for validation) | 5.5.0 | 