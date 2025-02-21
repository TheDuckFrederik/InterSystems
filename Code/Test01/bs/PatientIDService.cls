Class code.bs.PatientIDService Extends Ens.BusinessService
{

Parameter ADAPTER = "EnsLib.REST.Operation";

Parameter INVOCATION = "Queue";

Method OnProcessInput(pInput As code.msg.ProcessRequest, Output pOutput As %RegisteredObject) As %Status
{
    set tSC = $$$OK
	try {
		set tRequest = ##class(code.msg.ProcessRequest).%New()
		set tRequest.PatientID = pInput.StringValue
		set tSC = ..OnProcessInput("PatientInfoProcess", pInput, .tResponse)
		$$$ThrowOnError(tSC)
	}
	catch ex {
		set tSC = ex.AsStatus()
	}
	return tSC
}

}
