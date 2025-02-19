Class code.bo.PatientDBOperation Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Parameter INVOCATION = "Queue";

Method PatientInfo(pRequest As code.msg.PatientDBRequest, Output pResponse As code.msg.PatientDBResponse)
{
    set pResponse=##class(code.msg.PatientDBResponse).%New()
    
    set query = "Select FirstName, MiddleName, LastName, Age, Allergies from SQLUser.Patients where PatientID = "_pRequest.PatientID
    set st =..Adapter.ExecuteQuery(.tResult,query)
    $$$TRACE("st = "_st) 
    do tResult.Next()

    set pResponse.FirstName=tResult.Get("FirstName")    
    set pResponse.MiddleName=tResult.Get("MiddleName")
    set pResponse.LastName=tResult.Get("LastName")
    set pResponse.Age=tResult.Get("Age")
    set pResponse.Allergies=tResult.Get("Allergies")
    set pResponse.OverAge=0
    if (pResponse.Age >= 18) {
        set pResponse.OverAge=1
    }

    Quit $$$OK
}

XData MessageMap
{
<MapItems>
        <MapItem MessageType="code.msg.PatientDBRequest">
            <Method>PatientInfo</Method>
        </MapItem>
    </MapItems>
}

}
