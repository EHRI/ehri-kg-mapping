class Validators {
    
    def isRecord(itemCount: Int): Boolean = {
        itemCount == 0
    }

    def isRecordSet(itemCount: Int): Boolean = {
        !isRecord(itemCount)
    }

    def nonEmpty(str: String): Boolean = {
        str.nonEmpty
    }

    def isFamily(cbType: String): Boolean = {
        cbType == "family"
    }

    def isCB(cbType: String): Boolean = {
        !isFamily(cbType)
    }

    def isURL(input: String): Boolean = {
        try {
            // For the moment this allows to parse the output
            val processedInput = input.replaceFirst("\\[", "").reverse.replaceFirst("\\]", "").reverse
            new java.net.URL(processedInput).toURI()
            true
        } catch {
            case e: java.net.MalformedURLException => false
            case ue: java.net.URISyntaxException => false
            case _ => false
        }
    }

    def nonURL(input: String): Boolean = {
        !isURL(input)
    }

    def isDocumentaryUnit(id: String, targetID: String, theType: String): Boolean = {
        id == targetID && theType == "DocumentaryUnit"
    }

    def isObjectDocumentaryUnit(id: String, targetID: String, theType: String): Boolean = {
        id != targetID && theType == "DocumentaryUnit"
    }

    def isObjectInstitution(id: String, targetID: String, theType: String): Boolean = {
        id != targetID && theType == "Repository"
    }

    def isInstitution(id: String, targetID: String, theType: String): Boolean = {
        id == targetID && theType == "Repository"
    }

    def hasCBPrefix(value: String): Boolean = {
        value.startsWith("ehri_cb-")
    }
    
    def nonEmptyTwo(id: String, attribute: String): Boolean = {
        id.nonEmpty && attribute.nonEmpty
    }

     def isRecordSetTypeDefinedInRiC(levelOfDescription: String): Boolean = {
        levelOfDescription == "fonds" ||
        levelOfDescription == "series" ||
        levelOfDescription == "collection" ||
        levelOfDescription == "file" 
    }

    def isRecordSetTypeDefinedInEHRI(levelOfDescription: String): Boolean = {
        levelOfDescription == "subfonds" ||
        levelOfDescription == "subseries" ||
        levelOfDescription == "recordgrp" ||
        levelOfDescription == "subgrp" ||
        levelOfDescription == "subcollection"
    }
}