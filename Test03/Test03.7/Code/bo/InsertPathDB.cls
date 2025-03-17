Class test0307.bo.InsertPathDB Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Parameter INVOCATION = "Queue";

Method ExecuteSQLQuery(query As %String) As %Status
{
    set tResult = ""
    set st = ..Adapter.ExecuteQuery(.tResult, query)
    $$$TRACE("SQL Execution Status: "_st)
    Quit st
}

Method MapRequestToResponse(pRequest As test0307.msg.InsertDBRequest, pResponse As test0307.msg.InsertDBResponse)
{
    set pResponse.PatientID = pRequest.PatientID
    set pResponse.FirstName = pRequest.FirstName
    set pResponse.MiddleName = pRequest.MiddleName
    set pResponse.LastName1 = pRequest.LastName1
    set pResponse.LastName2 = pRequest.LastName2
    set pResponse.BirthDate = pRequest.BirthDate
    set pResponse.DNI = pRequest.DNI
    set pResponse.Allergies = pRequest.Allergies
    set pResponse.CreateFile = pRequest.CreateFile
}

Method InsertData(pRequest As test0307.msg.InsertDBRequest, Output pResponse As test0307.msg.InsertDBResponse) As %Status
{
    set pResponse = ##class(test0307.msg.InsertDBResponse).%New()

    set query = "INSERT INTO SQLUser.MedicalHistory (PatientID, FirstName, MiddleName, FirstLastName, SecondLastName, BirthDate, DNI, Allergies) VALUES ("_pRequest.PatientID_", '"_pRequest.FirstName_"', '"_pRequest.MiddleName_"', '"_pRequest.LastName1_"', '"_pRequest.LastName2_"', '"_pRequest.BirthDate_"', '"_pRequest.DNI_"', '"_pRequest.Allergies_"')"
    set st = ..ExecuteSQLQuery(query)

    Do ..MapRequestToResponse(pRequest, pResponse)

    Quit $$$OK
}

XData MessageMap
{
<MapItems>
    <MapItem MessageType="test0307.msg.InsertDBRequest">
        <Method>InsertData</Method>
    </MapItem>
</MapItems>
}

}
