Class test0305.bs.SelectPathService Extends Ens.BusinessService
{

Method OnProcessInput(pInput As test0305.msg.SelectProcessRequest, Output pOutput As %RegisteredObject) As %Status
{
	set tSC = $$$OK
	try {
		set tSC = ..SendRequestSync("SelectPathProcess", pInput, .tResponse)
		$$$ThrowOnError(tSC)
	}
	catch ex {
		set tSC = ex.AsStatus()
	}
	return tSC
}

}
