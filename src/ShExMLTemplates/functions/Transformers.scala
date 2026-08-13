class Transformers {

    def toLowerCase(input: String): String = {
        input.toLowerCase()
    }

    def toBeginningDateID(mainEntityID: String, dateID: String): String = {
        mainEntityID + "-" + dateID + "-beginningDate"
    }

    def toEndDateID(mainEntityID: String, dateID: String): String = {
        mainEntityID + "-" + dateID + "-endDate"
    }

    def removeSquareBrackets(input: String): String = {
        input.replaceFirst("\\[", "").reverse.replaceFirst("\\]", "").reverse
    }

    def removeCBPrefix(value: String): String = {
        value.replaceFirst("ehri_cb-", "")
    }

    def combinedPathInstitutionLocation(institutionID: String, index: String): String = {
        institutionID + "/locations/" + (index.toInt + 1)
    }

    def combinedPathInstitutionAddress(institutionID: String, index: String): String = {
        institutionID + "/addresses/" + (index.toInt + 1)
    }

    def combinedPathInstitutionCoordinates(institutionID: String): String = {
        institutionID + "/coordinates/1"
    }

    def combinedPathInstitutionMandates(institutionID: String): String = {
        institutionID + "/mandates/1"
    }

    def combinedPathHoldingAcquisition(holdingID: String): String = {
        holdingID + "/acquisitions/1"
    }

    def combinedPathHoldingAlternateIDs(holdingID: String, index: String): String = {
        holdingID + "/alternateIDs/" + (index.toInt + 1)
    }

    def combinedPathPersonLegalStatus(historicalAgentID: String): String = {
        historicalAgentID + "/legalStatuses/1"
    }

    def combinedPathPersonOccupation(historicalAgentID: String): String = {
        historicalAgentID + "/occupations/1"
    }

    def combinedPathPersonFunction(historicalAgentID: String, index: String): String = {
        historicalAgentID + "/functions/" + (index.toInt + 1)
    }

    def combinedPathPersonMandate(historicalAgentID: String, index: String): String = {
        historicalAgentID + "/mandates/" + (index.toInt + 1)
    }

    def combinedPathHistoricalAgentLegalStatus(historicalAgentID: String, cbType: String): String = {
        s"${getFamilyOrCbPrefix(historicalAgentID, cbType)}/legalStatuses/1"
    }

    def combinedPathHistoricalAgentOccupation(historicalAgentID: String, cbType: String): String = {
        s"${getFamilyOrCbPrefix(historicalAgentID, cbType)}/occupations/1"
    }

    def combinedPathHistoricalAgentFunction(historicalAgentID: String, cbType: String, index: String): String = {
        s"${getFamilyOrCbPrefix(historicalAgentID, cbType)}/functions/${(index.toInt + 1)}"
    }

    def combinedPathHistoricalAgentMandate(historicalAgentID: String, cbType: String, index: String): String = {
        s"${getFamilyOrCbPrefix(historicalAgentID, cbType)}/mandates/${(index.toInt + 1)}"
    }

    def recordOrRecordSet(levelOfDescription: String, itemCount: Int): String = {
        if(levelOfDescription == "item" && itemCount == 0) "Record" else "RecordSet"
    }

    def combinedPathOtherNamesCbs(id: String, cbType: String, name: String): String = {
        getFamilyOrCbPrefix(id, cbType) + "/otherNames/" + name
    }

    def combinedPathParallelNamesCbs(id: String, cbType: String, name: String): String = {
        getFamilyOrCbPrefix(id, cbType) + "/parallelNames/" + name
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
        else if(levelOfDescription == "item") "Item"
        else if(levelOfDescription == "otherlevel") "OtherLevel"
        else ""
    }

    def isFamily(cbType: String): Boolean = {
        cbType == "family"
    }

    def isCB(cbType: String): Boolean = {
        !isFamily(cbType)
    }

    def getFamilyOrCbPrefix(id: String, cbType: String): String = {
        if(isFamily(cbType)) s"ehri-families/$id"
        else s"ehri-cb/$id"
    }
}