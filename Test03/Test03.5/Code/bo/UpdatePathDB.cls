Class test0305.bo.UpdatePathDB Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Parameter INVOCATION = "Queue";

Method UpdateData(pRequest As test0305.msg.UpdateDBRequest, Output pResponse As test0305.msg.UpdateDBResponse) As %Status
{
    set pResponse = ##class(test0305.msg.UpdateDBResponse).%New()
    
    set query = "UPDATE MedicalHistory SET FirstName = '"_pRequest.FirstName_"', MiddleName = '"_pRequest.MiddleName_"', FirstLastName = '"_pRequest.LastName1_"', SecondLastName = '"_pRequest.LastName2_"', BirthDate = '"_pRequest.BirthDate_"', DNI = '"_pRequest.DNI_"', Allergies = '"_pRequest.Allergies_"' WHERE PatientID = "_pRequest.PatientID
    set st = ..Adapter.ExecuteQuery(.tResult, query)
    $$$TRACE("st = "_st)

    set pResponse.PatientID=pRequest.PatientID
    set pResponse.FirstName=pRequest.FirstName    
    set pResponse.MiddleName=pRequest.MiddleName
    set pResponse.LastName1=pRequest.LastName1
    set pResponse.LastName2=pRequest.LastName2
    set pResponse.BirthDate=pRequest.BirthDate
    set pResponse.DNI=pRequest.DNI
    set pResponse.Allergies=pRequest.Allergies
    set pResponse.CreateFile=pRequest.CreateFile

    Quit $$$OK
}

XData MessageMap
{
<MapItems>
    <MapItem MessageType="test0305.msg.UpdateDBRequest">
        <Method>UpdateData</Method>
    </MapItem>
</MapItems>
}

}
