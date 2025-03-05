Class code.bo.PatientDataOperation Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Parameter INVOCATION = "Queue";

Method PatientData(pRequest As code.msg.PatientDataDBRequest, Output pResponse As code.msg.PatientDataDBResponse) As %Status
{
    set pResponse = ##class(code.msg.PatientDataDBResponse).%New()
    
    //set query = "INSERT INTO PatientData (PatientDataID, FirstName, MiddleName, LastName, Age, Allergies) VALUES ("_pRequest.PatientDataID_", "_pRequest.FirstName_", "_pRequest.MiddleName_", "_pRequest.LastName_", "_pRequest.Age_", "_pRequest.Allergies_")"
    set query = "INSERT INTO PatientData VALUES "_pRequest.PatientDataID_", "_pRequest.FirstName_", "_pRequest.MiddleName_", "_pRequest.LastName_", "_pRequest.Age_", "_pRequest.Allergies_""
    set st = ..Adapter.ExecuteQuery(.tResult, query)
    $$$TRACE("st = "_st)

    set pResponse.PatientDataID=pRequest.PatientDataID
    set pResponse.FirstName=pRequest.FirstName
    set pResponse.MiddleName=pRequest.MiddleName
    set pResponse.LastName=pRequest.LastName
    set pResponse.Age=pRequest.Age
    set pResponse.Allergies=pRequest.Allergies

    Quit $$$OK
}

XData MessageMap
{
<MapItems>
    <MapItem MessageType="code.msg.PatientDataDBRequest">
        <Method>PatientData</Method>
    </MapItem>
</MapItems>
}

}
