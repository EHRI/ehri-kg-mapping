cat shexmlOutputInstitutions/*.ttl > institutions.ttl
sed -i 's/@prefix.*//g' institutions.ttl

sed -i "1i\@prefix wd:    <http://www.wikidata.org/entity/> ." institutions.ttl
sed -i "1i\@prefix rdfs:  <http://www.w3.org/2000/01/rdf-schema#> ." institutions.ttl
sed -i "1i\@prefix ehri:  <http://lod.ehri-project-test.eu/ontology#> ." institutions.ttl
sed -i "1i\@prefix ehri_countries: <http://lod.ehri-project-test.eu/countries/> ." institutions.ttl
sed -i "1i\@prefix ehri_regions: <http://lod.ehri-project-test.eu/regions/> ." institutions.ttl
sed -i "1i\@prefix ehri_cities: <http://lod.ehri-project-test.eu/cities/> ." institutions.ttl
sed -i "1i\@prefix ehri_institutions: <http://lod.ehri-project-test.eu/institutions/> ." institutions.ttl
sed -i "1i\@prefix ehri_units: <http://lod.ehri-project-test.eu/units/> ." institutions.ttl
sed -i "1i\@prefix ehri_terms: <http://lod.ehri-project-test.eu/vocabularies/ehri-terms/> ." institutions.ttl
sed -i "1i\@prefix dbr:   <http://dbpedia.org/resource/> ." institutions.ttl
sed -i "1i\@prefix schema: <http://schema.org/> ." institutions.ttl
sed -i "1i\@prefix xsd:    <http://www.w3.org/2001/XMLSchema#> ." institutions.ttl
sed -i "1i\@prefix owl:    <http://www.w3.org/2002/07/owl#> ." institutions.ttl
sed -i "1i\@prefix rico: <https://www.ica.org/standards/RiC/ontology#> ." institutions.ttl
sed -i "1i\@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> ." institutions.ttl