cat shexmlOutputGhettos/*.ttl > ghettos.ttl
sed -i 's/@prefix.*//g' ghettos.ttl

sed -i "1i\@prefix ehri: <http://lod.ehri-project-test.eu/ontology#> ." ghettos.ttl
sed -i "1i\@prefix ehri_units: <http://lod.ehri-project-test.eu/units/> ." ghettos.ttl
sed -i "1i\@prefix ehri_ghettos: <http://lod.ehri-project-test.eu/vocabularies/ehri-ghettos/> ." ghettos.ttl