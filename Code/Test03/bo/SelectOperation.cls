Class code.bo.SelectOperation Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Parameter INVOCATION = "Queue";

Method DBSelect(pRequest As code.msg.ProcessOperationRequest, Output pResponse As code.msg.ProcessOperationResponse)
{
    set pResponse=##class(code.msg.ProcessOperationResponse).%New()
    
    set query = "SELECT FirstName, MiddleName, FirstLastName, SecondLastName, BirthDate, DNI, Allergies from SQLUser.MedicalHistory where PatientID = "_pRequest.PatientID
    set st =..Adapter.ExecuteQuery(.tResult,query)
    $$$TRACE("st = "_st)
    do tResult.Next()

    set pResponse.PatientID=pRequest.PatientID
    set pResponse.FirstName=tResult.Get("FirstName")    
    set pResponse.MiddleName=tResult.Get("MiddleName")
    set pResponse.LastName=tResult.Get("FirstLastName")_" "_tResult.Get("SecondLastName")
    set pResponse.BirthDate=tResult.Get("BirthDate")
    set pResponse.DNI=tResult.Get("DNI")
    set pResponse.Allergies=tResult.Get("Allergies")

    Quit $$$OK
}

XData MessageMap
{
<MapItems>
        <MapItem MessageType="code.msg.ProcessOperationRequest">
            <Method>DBSelect</Method>
        </MapItem>
    </MapItems>
}

}
