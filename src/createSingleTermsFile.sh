cat shexmlOutputTerms/*.ttl > terms.ttl
sed -i 's/@prefix.*//g' terms.ttl

sed -i "1i\@prefix ehri: <http://lod.ehri-project-test.eu/ontology#> ." terms.ttl
sed -i "1i\@prefix ehri_units: <http://lod.ehri-project-test.eu/units/> ." terms.ttl
sed -i "1i\@prefix ehri_terms: <http://lod.ehri-project-test.eu/vocabularies/ehri-terms/> ." terms.ttl