Class code.bs.SelectService Extends Ens.BusinessService
{

Method OnProcessInput(pInput As code.msg.ServiceProcessRequest, Output pOutput As %RegisteredObject) As %Status
{
    set tSC = $$$OK
    try {
    //set tRequest = ##class(code.msg.PatientDataDBRequest).%New()
    //set tRequest.PatientID = pInput.StringValue

    set tSC = ..SendRequestSync("SelectProcess", pInput, .tResponse)
    $$$ThrowOnError(tSC)
    }
    catch ex {
        set tSC = ex.AsStatus()
    }
        return tSC
}

}
