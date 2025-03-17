Class test0307.bo.SelectPathFile Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.File.OutboundAdapter";

Parameter INVOCATION = "Queue";

Method SelectFile(pRequest As test0307.msg.SelectFileRequest, Output pResponse As Ens.Response) As %Status
{
    
    set tData = ..FormatPatientData(pRequest)

    set sc = ..WriteToFile(pRequest.FileName, tData)
    $$$TRACE("Status: "_$system.Status.DisplayError(sc))

    Quit sc
}

Method WriteToFile(pFileName As %String, pData As %String) As %Status
{
    Quit ..Adapter.PutString(pFileName, pData)
}

Method FormatPatientData(pRequest As test0307.msg.SelectFileRequest) As %String
{
    
    set tJSON = {}
    set tJSON.PatientID = pRequest.PatientID
    set tJSON.FirstName = pRequest.FirstName
    set tJSON.MiddleName = pRequest.MiddleName
    set tJSON.LastName = pRequest.LastName
    set tJSON.BirthDate = pRequest.BirthDate
    set tJSON.DNI = pRequest.DNI
    set tJSON.Allergies = pRequest.Allergies

    set tJSONString = tJSON.%ToJSON()

    Quit tJSONString
}

XData MessageMap
{
<MapItems>
    <MapItem MessageType="test0307.msg.SelectFileRequest">
        <Method>SelectFile</Method>
    </MapItem>
</MapItems>
}

}
