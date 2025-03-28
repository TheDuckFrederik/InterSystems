Class test0305.bs.UpdatePathService Extends Ens.BusinessService
{

Method ProcessInput(pInput As test0305.msg.UpdateProcessRequest, Output pOutput As %RegisteredObject) As %Status
{
	set tSC = $$$OK
	try {
		set tRequest = ##class(test0305.msg.UpdateProcessRequest).%New()
    	//set tRequest.PatientID = pInput.StringValue

        set tSC = ..SendRequestSync("UpdatePathProcess", pInput, .tResponse)
		$$$ThrowOnError(tSC)
	}
	catch ex {
		set tSC = ex.AsStatus()
	}
	return tSC
}

}
