Class test0305.bo.SelectPathFile Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.File.OutboundAdapter";

Parameter INVOCACION = "Queue";

Method SelectFile(pRequest As test0305.msg.SelectFileRequest, Output pResponse As Ens.Response)
{
        set tData = pRequest.PatientID_" "_
                    pRequest.FirstName_" "_
                    pRequest.MiddleName_" "_
                    pRequest.LastName_" "_
                    pRequest.BirthDate_" "_
                    pRequest.DNI_" "_
                    pRequest.Allergies_" "
        set sc = ..Adapter.PutString(pRequest.FileName, tData)
        $$$TRACE("st = "_$system.Status.DisplayError(sc))

        Quit $$$OK
}

XData MessageMap
{
<MapItems>
        <MapItem MessageType="test0305.msg.SelectFileRequest">
            <Method>SelectFile</Method>
        </MapItem>
    </MapItems>
}

}
