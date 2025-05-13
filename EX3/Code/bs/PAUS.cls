Class IRIS1.bs.PAUS Extends Ens.BusinessService
{

Method OnProcessInput(pInput As IRIS1.msg.SPM, Output pOutput As %RegisteredObject) As %Status
{
	set tSC = $$$OK
	try {
		set tSC = ..SendRequestSync("ADMP", pInput, .tResponse)
		$$$ThrowOnError(tSC)
	}
	catch ex {
		set tSC = ex.AsStatus()
	}
	return tSC
}

}
