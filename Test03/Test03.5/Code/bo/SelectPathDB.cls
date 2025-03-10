Class test0305.bo.SelectPathDB Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Parameter INVOCATION = "Queue";

Method SelectData(pRequest As test0305.msg.SelectDBRequest, Output pResponse As test0305.msg.SelectDBResponse) As %Status
{
    set pResponse = ##class(test0305.msg.SelectDBResponse).%New()
    
    set query = "SELECT PatientID, FirstName, MiddleName, FirstLastName, SecondLastName, BirthDate, DNI, Allergies from SQLUser.MedicalHistory where PatientID = "_pRequest.PatientID
    set st = ..Adapter.ExecuteQuery(.tResult, query)
    $$$TRACE("st = "_st)
    do tResult.Next()

    set pResponse.FirstName=tResult.Get("FirstName")    
    set pResponse.MiddleName=tResult.Get("MiddleName")
    set pResponse.LastName1=tResult.Get("FirstLastName")
    set pResponse.LastName2=tResult.Get("SecondLastName")
    set pResponse.BirthDate=tResult.Get("BirthDate")
    set pResponse.DNI=tResult.Get("DNI")
    set pResponse.Allergies=tResult.Get("Allergies")

    Quit $$$OK
}

XData MessageMap
{
<MapItems>
    <MapItem MessageType="test0305.msg.SelectDBRequest">
        <Method>SelectData</Method>
    </MapItem>
</MapItems>
}

}
