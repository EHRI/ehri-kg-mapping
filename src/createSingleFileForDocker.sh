curl https://portal.ehri-project.eu/vocabularies/ehri_terms/export?format=TTL > ehri-terms.ttl
curl https://portal.ehri-project.eu/vocabularies/ehri_camps/export?format=TTL > ehri-camps.ttl
curl https://portal.ehri-project.eu/vocabularies/ehri_ghettos/export?format=TTL > ehri-ghettos.ttl

sed -i 's/http:\/\/data.ehri-project.eu/http:\/\/lod.ehri-project-test.eu/g' ehri-terms.ttl
sed -i 's/http:\/\/data.ehri-project.eu/http:\/\/lod.ehri-project-test.eu/g' ehri-camps.ttl
sed -i 's/http:\/\/data.ehri-project.eu/http:\/\/lod.ehri-project-test.eu/g' ehri-ghettos.ttl

rm all.ttl
rm allWithExtras.ttl

cat *.ttl > all.ttl
sed -i 's/@prefix.*//g' all.ttl

sed -i "1i\@prefix schema: <http://schema.org/> ." all.ttl
sed -i "1i\@prefix xsd:    <http://www.w3.org/2001/XMLSchema#> ." all.ttl
sed -i "1i\@prefix rico: <https://www.ica.org/standards/RiC/ontology#> ." all.ttl
sed -i "1i\@prefix owl:     <http://www.w3.org/2002/07/owl#> ." all.ttl
sed -i "1i\@prefix wd:    <http://www.wikidata.org/entity/> ." all.ttl
sed -i "1i\@prefix rdfs:  <http://www.w3.org/2000/01/rdf-schema#> ." all.ttl
sed -i "1i\@prefix ehri:  <http://lod.ehri-project-test.eu/ontology#> ." all.ttl
sed -i "1i\@prefix ehri_countries: <http://lod.ehri-project-test.eu/countries/> ." all.ttl
sed -i "1i\@prefix ehri_regions: <http://lod.ehri-project-test.eu/regions/> ." all.ttl
sed -i "1i\@prefix ehri_cities: <http://lod.ehri-project-test.eu/cities/> ." all.ttl
sed -i "1i\@prefix ehri_institutions: <http://lod.ehri-project-test.eu/institutions/> ." all.ttl
sed -i "1i\@prefix ehri_units: <http://lod.ehri-project-test.eu/units/> ." all.ttl
sed -i "1i\@prefix ehri_terms: <http://lod.ehri-project-test.eu/vocabularies/ehri-terms/> ." all.ttl
sed -i "1i\@prefix dbr:   <http://dbpedia.org/resource/> ." all.ttl
sed -i "1i\@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> ." all.ttl
sed -i "1i\@prefix ehri_pers: <http://lod.ehri-project-test.eu/vocabularies/ehri-pers/> ." all.ttl
sed -i "1i\@prefix ehri_other_name: <http://lod.ehri-project-test.eu/otherNames/> ." all.ttl
sed -i "1i\@prefix ehri_parallel_name: <http://lod.ehri-project-test.eu/parallelNames/> ." all.ttl
sed -i "1i\@prefix ehri_date: <http://lod.ehri-project-test.eu/dates/> ." all.ttl
sed -i "1i\@prefix ehri_legal_status: <http://lod.ehri-project-test.eu/legalStatuses/> ." all.ttl
sed -i "1i\@prefix ehri_mandate: <http://lod.ehri-project-test.eu/mandates/> ." all.ttl
sed -i "1i\@prefix ehri_activity: <http://lod.ehri-project-test.eu/activities/> ." all.ttl
sed -i "1i\@prefix ehri_camps: <http://lod.ehri-project-test.eu/vocabularies/ehri-camps/> ." all.ttl
sed -i "1i\@prefix ehri_ghettos: <http://lod.ehri-project-test.eu/vocabularies/ehri-ghettos/> ." all.ttl
sed -i "1i\@prefix ehri_cb: <http://lod.ehri-project-test.eu/vocabularies/ehri-cb/> ." all.ttl
sed -i "1i\@prefix ehri_languages: <http://lod.ehri-project-test.eu/languages/> ." all.ttl
sed -i "1i\@prefix ehri_material_script: <http://lod.ehri-project-test.eu/materialScripts/> ." all.ttl
sed -i "1i\@prefix ric_rst: <https://www.ica.org/standards/RiC/vocabularies/recordSetTypes#> ." all.ttl
sed -i "1i\@prefix ehri_rst: <http://lod.ehri-project-test.eu/vocabularies/recordSetTypes#> ." all.ttl
sed -i "1i\@prefix geo:     <http://www.w3.org/2003/01/geo/wgs84_pos#> ." all.ttl
sed -i "1i\@prefix skos:    <http://www.w3.org/2004/02/skos/core#> ." all.ttl
sed -i "1i\@prefix sem:     <http://semanticweb.cs.vu.nl/2009/11/sem/> ." all.ttl
sed -i "1i\@prefix foaf:    <http://xmlns.com/foaf/0.1/> ." all.ttl
sed -i "1i\@prefix dc:      <http://purl.org/dc/elements/1.1/> ." all.ttl

# Fixes some problems with the data
sed -i "s/<empty>>/empty>/g" all.ttl
sed -i "s/fond_<br_\/>/fond/g" all.ttl
sed -i "s/Pio_<papa_;_12.>/Pio_papa_12/g" all.ttl
sed -i "s/Pius_<papa_;_12.>/Pius_papa_12/g" all.ttl

cp all.ttl allWithExtras.ttl
cat auxFiles/linksLanguagesDBpedia/linksLanguagesDBpedia.ttl >> allWithExtras.ttl
cat auxFiles/linksToCDEC/linksCDECDescriptionsToPeople.ttl >> allWithExtras.ttl
cat auxFiles/linksToCDEC/linksToCDECPeople.ttl >> allWithExtras.ttl
