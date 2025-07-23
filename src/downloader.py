import urllib.request
import json
import os
from multiprocessing import Pool
import multiprocessing as mp
from functools import partial
import sys
import requests
import time

ehri_terms_query_end = """\"){
      items {
        id
        identifier
        links {
          targets {
            id
            type
          }
        }
      }
      pageInfo {
        hasPreviousPage
        previousPage
        hasNextPage
        nextPage
      }
    }
  }
}"""

ehri_terms_query_start = """{
  CvocVocabulary(id: \""""

ehri_terms_query_middle = """\") {
    id
    concepts(first: 100, after: \""""
    
ehri_historical_query_end = """\") {
      items {
          id
          identifier
          description {
            languageCode
            name
            identifier
            dates {
              startDate
              endDate
            }
            lastName
            firstName
            source
            typeOfEntity
            datesOfExistence
            biographicalHistory
            legalStatus
            structure
            generalContext
            occupation
            otherFormsOfName
            parallelFormsOfName
            place
            functions
            mandates
          }
          links {
            targets {
              id
              type
            }
          }
      }
      pageInfo {
        hasPreviousPage
        previousPage
        hasNextPage
        nextPage
  		}
    }
  }
}"""

ehri_historical_query_start = """{
  AuthoritativeSet(id: \""""
  
ehri_historical_query_middle = """\") {
    authorities(first: 100, after: \""""

ehri_holdings_start = """{
  documentaryUnits(first: 100, after: \""""

ehri_repositories_start = """{
  repositories(first: 100, after: \""""

ehri_countries_start = """{
  countries(first: 100, after: \""""

ehri_holdings_end = """\") {
    items {
      id
      type
      identifier
      otherIdentifiers
    	descriptions {
        languageCode
        name
        identifier
        accessPoints {
          id
          name
          type
        }
        dates {
          startDate
          endDate
        }
        archivistNote
        archivalHistory
        acquisition
        appraisal
        accruals
        biographicalHistory
        conditionsOfAccess
        conditionsOfReproduction
        datesOfDescriptions
        extentAndMedium
        levelOfDescription
        relatedUnitsOfDescription
        physicalCharacteristics
        publicationNote
        ref
        rulesAndConventions
        scopeAndContent
        separatedUnitsOfDescription
        systemOfArrangement
        findingAids
        languageOfMaterial
        locationOfOriginals
        locationOfCopies
        parallelFormsOfName
        physicalLocation
        notes
        scriptOfMaterial
        sources
        unitDates
      }
      parent {
        id
      }
      itemCount
      repository {
        id
      }
      links {
        id
        type
        description
        field
        body {
          id
          name
          type
        }
        targets {
          id
          type
        }
        source {
          id
          type
        }
      }
    }
    pageInfo {
      hasPreviousPage
      previousPage
      hasNextPage
      nextPage
    }
  }
}"""

ehri_repositories_end = """\") {
    items {
      id
      type
      identifier
      latitude
      longitude
      descriptions {
        languageCode
        name
        identifier
        addresses {
          addressName
          contactPerson
          street
          municipality
          firstdem
          countryCode
          postalCode
          email
          telephone
          fax
          webpage
        }
        typeOfEntity
        history
        geoculturalContext
        mandates
        administrativeStructure
        records
        buildings
        holdings
        findingAids
        openingTimes
        conditions
        accessibility
        researchServices
        reproductionServices
        publicAreas
        rulesAndConventions
        status
        datesOfDescriptions
        maintenanceNotes
        otherFormsOfName
        parallelFormsOfName
        languages
        scripts
        sources
      }
      country {
        id
      }
      links {
        id
        type
        description
        field
        body {
          type
        }
        targets {
          id
          type
        }
        source {
          id
          type
        }
      }
    }
    pageInfo {
      hasPreviousPage
      previousPage
      hasNextPage
      nextPage
    }
  }
}"""

ehri_countries_end = """\") {
    items {
      id
      type
      identifier
      name
      history
      situation
      summary
      extensive
    }
    pageInfo {
      hasPreviousPage
      previousPage
      hasNextPage
      nextPage
    }
  }
}"""

def download_from_graphql(type_name, url, query_start, query_end, wait_seconds=0):
    i = 1
    after = ""
    next_page = True
    while next_page:
        filename = type_name + "/" + type_name + "_" + str(i) + ".json"
        print(type_name + ": " + str(i))
        final_query = query_start + after + query_end
        json_query = {'query': final_query}
        headers = {'Content-type': 'application/json'}
        success = False
        while not(success):
            try:
                if os.path.isfile(filename):
                    print(filename + " not downloaded as it already exists")
                else:
                    time.sleep(wait_seconds)
                    r = requests.post(url=url, json=json_query, headers=headers)
                    with open(filename, "w", encoding="utf-8") as file:
                        file.write(r.text)
                with open(filename, "r", encoding="utf-8") as file:
                    json_content = file.read()
                data = json.loads(json_content)
                if 'CvocVocabulary' in data['data']:
                    next_page = data['data']['CvocVocabulary']['concepts']['pageInfo']['hasNextPage']
                    after = data['data']['CvocVocabulary']['concepts']['pageInfo']['nextPage']
                elif 'AuthoritativeSet' in data['data']:
                    next_page = data['data']['AuthoritativeSet']['authorities']['pageInfo']['hasNextPage']
                    after = data['data']['AuthoritativeSet']['authorities']['pageInfo']['nextPage']
                elif 'documentaryUnits' in data['data']:
                    next_page = data['data']['documentaryUnits']['pageInfo']['hasNextPage']
                    after = data['data']['documentaryUnits']['pageInfo']['nextPage']
                elif 'repositories' in data['data']:
                    next_page = data['data']['repositories']['pageInfo']['hasNextPage']
                    after = data['data']['repositories']['pageInfo']['nextPage']
                elif 'countries' in data['data']:
                    next_page = data['data']['countries']['pageInfo']['hasNextPage']
                    after = data['data']['countries']['pageInfo']['nextPage']
                else:
                    raise Exception("Unsupported data type")
                success = True
            except Exception as err:
                print("Error while downloading from GraphQL URL " + url + ": " + err)
        i += 1

if __name__ == '__main__':
    print("Downloading contents from the EHRI Portal API")

    wait_seconds = 5
    
    grapql_url = "https://portal.ehri-project.eu/api/graphql"

    print("Downloading EHRI countries...")
    query_start = ehri_countries_start
    download_from_graphql("countries", grapql_url, query_start, ehri_countries_end, wait_seconds)

    print("Downloading EHRI institutions...")
    query_start = ehri_repositories_start
    download_from_graphql("institutions", grapql_url, query_start, ehri_repositories_end, wait_seconds)

    print("Downloading EHRI documentary units...")
    query_start = ehri_holdings_start
    download_from_graphql("holdings", grapql_url, query_start, ehri_holdings_end, wait_seconds)
    
    print("Downloading EHRI terms...")
    query_start = ehri_terms_query_start + "ehri_terms" + ehri_terms_query_middle
    download_from_graphql("terms", grapql_url, query_start, ehri_terms_query_end, wait_seconds)

    print("Downloading EHRI ghettos...")
    query_start = ehri_terms_query_start + "ehri_ghettos" + ehri_terms_query_middle
    download_from_graphql("ghettos", grapql_url, query_start, ehri_terms_query_end, wait_seconds)

    print("Downloading EHRI camps...")
    query_start = ehri_terms_query_start + "ehri_camps" + ehri_terms_query_middle
    download_from_graphql("camps", grapql_url, query_start, ehri_terms_query_end, wait_seconds)

    print("Downloading EHRI people...")
    query_start = ehri_historical_query_start + "ehri_pers" + ehri_historical_query_middle
    download_from_graphql("people", grapql_url, query_start, ehri_historical_query_end, wait_seconds)

    print("Downloading EHRI corporate bodies...")
    query_start = ehri_historical_query_start + "ehri_cb" + ehri_historical_query_middle
    download_from_graphql("cb", grapql_url, query_start, ehri_historical_query_end, wait_seconds)
