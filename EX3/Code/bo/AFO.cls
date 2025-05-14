Class IRIS1.bo.AFO Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.File.OutboundAdapter";

Parameter INVOCACION = "Queue";

Method CreateFile(pRequest As IRIS1.msg.DFFM, Output pResponse As Ens.Response)
{
        set tData = pRequest.FirstName_","_
                    pRequest.MiddleName_","_
                    pRequest.LastName_","_
                    pRequest.SSN_","_
                    pRequest.hHospitalName_","_
                    pRequest.sSpecialty_","_
                    pRequest.prProfessionalName_","_
                    pRequest.atAppointmentType_","_
                    pRequest.icInsuranceCompany_","_
                    pRequest.aReason_","_
                    pRequest.aAppointmentDate_","_
                    pRequest.aAppointmentTime_$CHAR(13,10)
        set sc = ..Adapter.PutString(pRequest.FileName, tData)
        $$$TRACE("st = "_$system.Status.DisplayError(sc))

        Quit $$$OK
}

XData MessageMap
{
<MapItems>
        <MapItem MessageType="IRIS1.msg.DFFM">
            <Method>CreateFile</Method>
        </MapItem>
    </MapItems>
}

}
