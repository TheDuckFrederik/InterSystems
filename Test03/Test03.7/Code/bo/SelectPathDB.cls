Class test0307.bo.SelectPathDB Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Parameter INVOCATION = "Queue";

Method SelectData(pRequest As test0307.msg.SelectDBRequest, Output pResponse As test0307.msg.SelectDBResponse) As %Status
{
    set pResponse = ##class(test0307.msg.SelectDBResponse).%New()
    
    // Extract query construction to a separate method
    set query = ..ConstructQuery(pRequest.PatientID)
    
    // Execute the query
    set st = ..Adapter.ExecuteQuery(.tResult, query)
    $$$TRACE("st = "_st)
    do tResult.Next()

    // Map the result to the response
    do ..MapResultToResponse(.tResult, .pResponse, pRequest.CreateFile)

    Quit $$$OK
}

Method ConstructQuery(patientID As %Integer) As %String
{
    return "SELECT PatientID, FirstName, MiddleName, FirstLastName, SecondLastName, BirthDate, DNI, Allergies from SQLUser.MedicalHistory where PatientID = "_patientID
}

Method MapResultToResponse(tResult As %SQL.StatementResult, Output pResponse As test0307.msg.SelectDBResponse, createFile As %Boolean) As %Status
{
    set pResponse.PatientID = tResult.Get("PatientID")
    set pResponse.FirstName = tResult.Get("FirstName")
    set pResponse.MiddleName = tResult.Get("MiddleName")
    set pResponse.LastName1 = tResult.Get("FirstLastName")
    set pResponse.LastName2 = tResult.Get("SecondLastName")
    set pResponse.BirthDate = tResult.Get("BirthDate")
    set pResponse.DNI = tResult.Get("DNI")
    set pResponse.Allergies = tResult.Get("Allergies")

    Quit $$$OK
}

XData MessageMap
{
<MapItems>
    <MapItem MessageType="test0307.msg.SelectDBRequest">
        <Method>SelectData</Method>
    </MapItem>
</MapItems>
}

}
