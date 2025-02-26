Class code.bs.PatientIDService Extends Ens.BusinessService
{

Method OnProcessInput(pInput As code.msg.ProcessRequest, Output pOutput As %RegisteredObject) As %Status
{
    set tSC = $$$OK
	try {
		//set tRequest = ##class(code.msg.PatientDBRequest).%New()
		//set tRequest.PatientID = pInput.StringValue

		set tSC = ..SendRequestSync("GetPatientInfo", pInput, .tResponse)
		$$$ThrowOnError(tSC)
	}
	catch ex {
		set tSC = ex.AsStatus()
	}
	return tSC
}

}
