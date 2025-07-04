cat shexmlOutputHoldings/*.ttl > holdings.ttl
sed -i 's/@prefix.*//g' holdings.ttl

sed -i "1i\@prefix wd:    <http://www.wikidata.org/entity/> ." holdings.ttl
sed -i "1i\@prefix rdfs:  <http://www.w3.org/2000/01/rdf-schema#> ." holdings.ttl
sed -i "1i\@prefix ehri:  <http://lod.ehri-project-test.eu/ontology#> ." holdings.ttl
sed -i "1i\@prefix ehri_institutions: <http://lod.ehri-project-test.eu/institutions/> ." holdings.ttl
sed -i "1i\@prefix ehri_units: <http://lod.ehri-project-test.eu/units/> ." holdings.ttl
sed -i "1i\@prefix ehri_terms: <http://lod.ehri-project-test.eu/vocabularies/ehri-terms/> ." holdings.ttl
sed -i "1i\@prefix ehri_languages: <http://lod.ehri-project-test.eu/languages/> ." holdings.ttl
sed -i "1i\@prefix ehri_parallel_name: <http://lod.ehri-project-test.eu/parallelNames/> ." holdings.ttl
sed -i "1i\@prefix ehri_material_script: <http://lod.ehri-project-test.eu/materialScripts/> ." holdings.ttl
sed -i "1i\@prefix ehri_cb: <http://lod.ehri-project-test.eu/vocabularies/ehri-cb/> ." holdings.ttl
sed -i "1i\@prefix dbr:   <http://dbpedia.org/resource/> ." holdings.ttl
sed -i "1i\@prefix schema: <http://schema.org/> ." holdings.ttl
sed -i "1i\@prefix xsd:    <http://www.w3.org/2001/XMLSchema#> ." holdings.ttl
sed -i "1i\@prefix owl:    <http://www.w3.org/2002/07/owl#> ." holdings.ttl
sed -i "1i\@prefix rico: <https://www.ica.org/standards/RiC/ontology#> ." holdings.ttl
sed -i "1i\@prefix ric_rst: <https://www.ica.org/standards/RiC/vocabularies/recordSetTypes#> ." holdings.ttl
sed -i "1i\@prefix ehri_rst: <http://lod.ehri-project-test.eu/vocabularies/recordSetTypes#> ." holdings.ttl