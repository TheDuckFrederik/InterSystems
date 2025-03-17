Class test0307.bo.InsertPathFile Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.File.OutboundAdapter";

Parameter INVOCACION = "Queue";

Method InsertFile(pRequest As test0307.msg.InsertFileRequest, Output pResponse As Ens.Response) As %Status
{
    set tData = ..FormatPatientData(pRequest)
    set sc = ..Adapter.PutString(pRequest.FileName, tData)
    $$$TRACE("Status: "_$system.Status.DisplayError(sc))

    Quit $$$OK
}

Method FormatPatientData(pRequest As test0307.msg.InsertFileRequest) As %String
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
        <MapItem MessageType="test0307.msg.InsertFileRequest">
            <Method>InsertFile</Method>
        </MapItem>
    </MapItems>
}

}
