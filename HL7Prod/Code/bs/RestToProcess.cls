Class HL7Prod.bs.RestToProcess Extends Ens.BusinessService
{

Method ProcessInput(pInput As HL7Prod.msg.ServiceToProcessInsert, Output pOutput As %RegisteredObject) As %Status
{
	set tSC = $$$OK
	try {
		set tRequest = ##class(HL7Prod.msg.ServiceToProcessInsert).%New()
    	//set tRequest.PatientID = pInput.StringValue

        set tSC = ..SendRequestSync("ServiceToOperationToOperation", pInput, .tResponse)
		$$$ThrowOnError(tSC)
	}
	catch ex {
		set tSC = ex.AsStatus()
	}
	return tSC
}

}
