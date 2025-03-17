Class test0307.bs.SelectPathService Extends Ens.BusinessService
{

/// Main method to process input
Method OnProcessInput(pInput As test0307.msg.SelectProcessRequest, Output pOutput As %RegisteredObject) As %Status
{
    set tSC = $$$OK
    try {
        set tSC = ..SendRequestToProcess("SelectPathProcess", pInput, .tResponse)
        $$$ThrowOnError(tSC)
    }
    catch ex {
        set tSC = ex.AsStatus()
    }
    return tSC
}

Method SendRequestToProcess(processName As %String, pInput As test0307.msg.SelectProcessRequest, Output tResponse As %RegisteredObject) As %Status
{
    return ..SendRequestSync(processName, pInput, .tResponse)
}

}
