class Transformers {

    def toLowerCase(input: String): String = {
        input.toLowerCase()
    }

    def leftPartDate(unitDate: String): String = {
        unitDate.split("-").head
    }

    def rightPartDate(unitDate: String): String = {
        unitDate.split("-")(1)
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

}