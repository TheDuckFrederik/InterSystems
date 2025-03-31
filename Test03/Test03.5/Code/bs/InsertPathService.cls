Class test0305.bs.InsertPathService Extends Ens.BusinessService
{

Method ProcessInput(pInput As test0305.msg.InsertProcessRequest, Output pOutput As %RegisteredObject) As %Status
{
	set tSC = $$$OK
	try {
		set tRequest = ##class(test0305.msg.InsertProcessRequest).%New()
    	//set tRequest.PatientID = pInput.StringValue

        set tSC = ..SendRequestSync("InsertPathProcess", pInput, .tResponse)
		$$$ThrowOnError(tSC)
	}
	catch ex {
		set tSC = ex.AsStatus()
	}
	return tSC
}

}
