Class test0307.bs.InsertPathService Extends Ens.BusinessService
{

Method ProcessInput(pInput As test0307.msg.InsertProcessRequest, Output pOutput As %RegisteredObject) As %Status
{
    set tSC = $$$OK
    try {
        // Create a new InsertProcessRequest object to handle the process
        set tRequest = ##class(test0307.msg.InsertProcessRequest).%New()

        // Send the request synchronously to InsertPathProcess
        set tSC = ..SendRequestSync("InsertPathProcess", pInput, .tResponse)
        $$$ThrowOnError(tSC)
    }
    catch ex {
        // Catch any errors and convert them to a status
        set tSC = ex.AsStatus()
    }
    return tSC
}

}
