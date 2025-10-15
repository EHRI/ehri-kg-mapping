cat shexmlOutputCb/*.ttl > cb.ttl
sed -i 's/@prefix.*//g' cb.ttl

sed -i "1i\@prefix rdfs:  <http://www.w3.org/2000/01/rdf-schema#> ." cb.ttl
sed -i "1i\@prefix ehri: <http://lod.ehri-project-test.eu/ontology#> ." cb.ttl
sed -i "1i\@prefix ehri_units: <http://lod.ehri-project-test.eu/units/> ." cb.ttl
sed -i "1i\@prefix ehri_cb: <http://lod.ehri-project-test.eu/vocabularies/ehri-cb/> ." cb.ttl
sed -i "1i\@prefix ehri_other_name: <http://lod.ehri-project-test.eu/otherNames/> ." cb.ttl
sed -i "1i\@prefix ehri_parallel_name: <http://lod.ehri-project-test.eu/parallelNames/> ." cb.ttl
sed -i "1i\@prefix ehri_dates: <http://lod.ehri-project-test.eu/dates/> ." cb.ttl
sed -i "1i\@prefix ehri_legal_status: <http://lod.ehri-project-test.eu/legalStatuses/> ." cb.ttl
sed -i "1i\@prefix ehri_mandate: <http://lod.ehri-project-test.eu/mandates/> ." cb.ttl
sed -i "1i\@prefix ehri_activity: <http://lod.ehri-project-test.eu/activities/> ." cb.ttl
sed -i "1i\@prefix rico: <https://www.ica.org/standards/RiC/ontology#> ." cb.ttl