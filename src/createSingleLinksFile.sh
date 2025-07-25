cat shexmlOutputLinks/*.ttl > links.ttl
sed -i 's/@prefix.*//g' links.ttl

sed -i "1i\@prefix wd:    <http://www.wikidata.org/entity/> ." links.ttl
sed -i "1i\@prefix rdfs:  <http://www.w3.org/2000/01/rdf-schema#> ." links.ttl
sed -i "1i\@prefix ehri:  <http://lod.ehri-project-test.eu/ontology#> ." links.ttl
sed -i "1i\@prefix ehri_countries: <http://lod.ehri-project-test.eu/countries/> ." links.ttl
sed -i "1i\@prefix ehri_regions: <http://lod.ehri-project-test.eu/regions/> ." links.ttl
sed -i "1i\@prefix ehri_cities: <http://lod.ehri-project-test.eu/cities/> ." links.ttl
sed -i "1i\@prefix ehri_institutions: <http://lod.ehri-project-test.eu/institutions/> ." links.ttl
sed -i "1i\@prefix ehri_units: <http://lod.ehri-project-test.eu/units/> ." links.ttl
sed -i "1i\@prefix ehri_terms: <http://lod.ehri-project-test.eu/vocabularies/ehri-terms/> ." links.ttl
sed -i "1i\@prefix dbr:   <http://dbpedia.org/resource/> ." links.ttl
sed -i "1i\@prefix schema: <http://schema.org/> ." links.ttl
sed -i "1i\@prefix xsd:    <http://www.w3.org/2001/XMLSchema#> ." links.ttl
sed -i "1i\@prefix owl:    <http://www.w3.org/2002/07/owl#> ." links.ttl
sed -i "1i\@prefix rico: <https://www.ica.org/standards/RiC/ontology#> ." links.ttl
sed -i "1i\@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> ." links.ttl