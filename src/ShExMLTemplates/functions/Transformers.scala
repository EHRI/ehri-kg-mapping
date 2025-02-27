class Transformers {

    def toLowerCase(input: String): String = {
        input.toLowerCase()
    }

    def leftPartDate(unitDate: String): String = {
        unitDate.split("-").head
    }

    def rightPartDate(unitDate: String): String = {
        unitDate.split("-").drop(1).headOption.getOrElse("")
    }

    def toBeginningDateID(id: String): String = {
        id + "-beginningDate"
    }

    def toEndDateID(id: String): String = {
        id + "-endDate"
    }

    def removeSquareBrackets(input: String): String = {
        input.replaceFirst("\\[", "").reverse.replaceFirst("\\]", "").reverse
    }

    def removeCBPrefix(value: String): String = {
        value.replaceFirst("ehri_cb-", "")
    }

    def combinedPathInstitutionLocation(institutionID: String): String = {
        institutionID + "/locations/primary"
    }

    def combinedPathInstitutionAddress(institutionID: String): String = {
        institutionID + "/addresses/primary"
    }

    def combinedPathInstitutionCoordinates(institutionID: String, lat: String, long: String): String = {
        institutionID + "/coordinates/" + lat + "-" + long
    }

    def combinedPathInstitutionMandates(institutionID: String): String = {
        institutionID + "/mandates/main"
    }

    def combinedPathHoldingAcquisition(holdingID: String): String = {
        holdingID + "/acquisitions/1"
    }

    def recordOrRecordSet(levelOfDescription: String, itemCount: Int): String = {
        if(levelOfDescription == "item" && itemCount == 0) "Record" else "RecordSet"
    }

    def getRecordSetType(levelOfDescription: String): String = {
        if(levelOfDescription == "fonds") "Fonds"
        else if(levelOfDescription == "series") "Series"
        else if(levelOfDescription == "collection") "Collection"
        else if(levelOfDescription == "file") "File"
        else ""
    }

    def getEHRIDefinedRecordSetType(levelOfDescription: String): String = {
        if(levelOfDescription == "subfonds") "Subfonds"
        else if(levelOfDescription == "subseries") "Subseries"
        else if(levelOfDescription == "recordgrp") "RecordGroup"
        else if(levelOfDescription == "subgrp") "Subgroup"
        else if(levelOfDescription == "subcollection") "Subcollection"
        else ""
    }
}