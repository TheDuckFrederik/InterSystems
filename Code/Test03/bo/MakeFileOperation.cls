Class code.bo.CreateFileOperation Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.File.OutboundAdapter";

Parameter INVOCACION = "Queue";

Method DataFile(pRequest As code.msg.CreateFileRequest, Output pResponse As Ens.Response)
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
        <MapItem MessageType="code.msg.CreateFileRequest">
            <Method>DataFile</Method>
        </MapItem>
    </MapItems>
}

}
