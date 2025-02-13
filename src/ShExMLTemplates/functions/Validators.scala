class Validators {
    
    // This function needs to be made more complex
    def validateDateInterval(unitDate: String): Boolean = {
        unitDate.filter(_ == '-').size != 1
    }

    def nonDateInterval(unitDate: String): Boolean = {
        !validateDateInterval(unitDate)
    }

    def isRecord(parentID: String): Boolean = {
        parentID.nonEmpty
    }

    def isRecordSet(parentID: String): Boolean = {
        !isRecord(parentID)
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
            new java.net.URL(processedInput)
            true
        } catch {
            case e: java.net.MalformedURLException => false
            case _ => false
        }
    }

    def nonURL(input: String): Boolean = {
        !isURL(input)
    }
}