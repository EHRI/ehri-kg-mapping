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
}