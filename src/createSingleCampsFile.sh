cat shexmlOutputCamps/*.ttl > camps.ttl
sed -i 's/@prefix.*//g' camps.ttl

sed -i "1i\@prefix ehri: <http://lod.ehri-project-test.eu/ontology#> ." camps.ttl
sed -i "1i\@prefix ehri_units: <http://lod.ehri-project-test.eu/units/> ." camps.ttl
sed -i "1i\@prefix ehri_camps: <http://lod.ehri-project-test.eu/vocabularies/ehri-camps/> ." camps.ttl