Class test0307.bs.SelectPathService Extends Ens.BusinessService
{

Method OnProcessInput(pInput As test0307.msg.SelectProcessRequest, Output pOutput As %RegisteredObject) As %Status
{
    set tSC = $$$OK
    try {
        set tSC = ..SendRequestSync("SelectPathProcess", pInput, .pOutput)
        $$$ThrowOnError(tSC)
    }
    catch ex {
        set tSC = ex.AsStatus()
    }
    return tSC
}

}
