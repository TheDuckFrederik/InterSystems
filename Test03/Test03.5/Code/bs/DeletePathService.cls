Class test0305.bs.DeletePathService Extends Ens.BusinessService
{

Method OnProcessInput(pInput As test0305.msg.DeleteProcessRequest, Output pOutput As %RegisteredObject) As %Status
{
	set tSC = $$$OK
	try {
		set tSC = ..SendRequestSync("DeletePathProcess", pInput, .tResponse)
		$$$ThrowOnError(tSC)
	}
	catch ex {
		set tSC = ex.AsStatus()
	}
	return tSC
}

}
