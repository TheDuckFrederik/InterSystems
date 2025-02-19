Class code.bo.MakeFileOperation Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.File.OutboundAdapter";

Parameter INVOCACION = "Queue";

/*
Method DecisionFile(pRequest As code.msg.MakeFileRequest, Output pResponse As Ens.Response)
{
        set tData = $ZDATETIME($H)_$$$NL_
                    pRequest.InsuranceCompany_$$$NL_
                    pRequest.Contents.PatientID_$$$NL_
                    pRequest.Contents.RequestedOperation_$$$NL_
                    pRequest.Contents.LikelyOutcome_$$$NL
        set st = ..Adapter.PutString(pRequest.FileName, tData)
        $$$TRACE("st = "_$system.Status.DisplayError(st))

        Quit $$$OK
}
*/
Method NotifyFile(pRequest As code.msg.MakeFileRequest, Output pResponse As Ens.Response)
{
        set tData = $ZDATETIME($H)_$$$NL_
                    pRequest.PatientID_" "_
                    pRequest.FirstName_" "_
                    pRequest.MiddleName_" "_
                    pRequest.LastName_" "_
                    pRequest.Age_" "_
                    pRequest.Allergies_" "
        set sc = ..Adapter.PutString(pRequest.FileName, tData)
        $$$TRACE("st = "_$system.Status.DisplayError(sc))

        Quit $$$OK
}

XData MessageMap
{
<MapItems>
            <!-- <MapItem MessageType="code.msg.MakeFileRequest">
            <Method>DecisionFile</Method>
        </MapItem> -->
            <MapItem MessageType="code.msg.MakeFileRequest">
            <Method>NotifyFile</Method>
        </MapItem>
    </MapItems>
}

}
