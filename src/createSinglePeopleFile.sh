cat shexmlOutputPeople/*.ttl > people.ttl
sed -i 's/@prefix.*//g' people.ttl

sed -i "1i\@prefix rdfs:  <http://www.w3.org/2000/01/rdf-schema#> ." people.ttl
sed -i "1i\@prefix ehri: <http://lod.ehri-project-test.eu/ontology#> ." people.ttl
sed -i "1i\@prefix ehri_units: <http://lod.ehri-project-test.eu/units/> ." people.ttl
sed -i "1i\@prefix ehri_pers: <http://lod.ehri-project-test.eu/vocabularies/ehri-pers/> ." people.ttl
sed -i "1i\@prefix ehri_other_name: <http://lod.ehri-project-test.eu/otherNames/> ." people.ttl
sed -i "1i\@prefix ehri_parallel_name: <http://lod.ehri-project-test.eu/parallelNames/> ." people.ttl
sed -i "1i\@prefix ehri_dates: <http://lod.ehri-project-test.eu/dates/> ." people.ttl
sed -i "1i\@prefix ehri_legal_status: <http://lod.ehri-project-test.eu/legalStatuses/> ." people.ttl
sed -i "1i\@prefix ehri_mandate: <http://lod.ehri-project-test.eu/mandates/> ." people.ttl
sed -i "1i\@prefix ehri_activity: <http://lod.ehri-project-test.eu/activities/> ." people.ttl
sed -i "1i\@prefix rico: <https://www.ica.org/standards/RiC/ontology#> ." people.ttl