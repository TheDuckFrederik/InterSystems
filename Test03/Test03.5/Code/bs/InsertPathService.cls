Class test0305.bs.InsertPathService Extends Ens.BusinessService
{

Method OnProcessInput(pInput As test0305.msg.InsertProcessRequest, Output pOutput As %RegisteredObject) As %Status
{
	set tSC = $$$OK
	try {
        set tSC = ..SendRequestSync("InsertPathProcess", pInput, .tResponse)
		$$$ThrowOnError(tSC)
	}
	catch ex {
		set tSC = ex.AsStatus()
	}
	return tSC
}

}
