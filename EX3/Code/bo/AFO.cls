Class IRIS1.bo.AFO Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.File.OutboundAdapter";

Parameter INVOCACION = "Queue";

Method CreateFile(pRequest As IRIS1.msg.DFFM, Output pResponse As Ens.Response)
{
        set tData = pRequest.ID_$CHAR(13,10)_
            pRequest.PatientID_$CHAR(13,10)_
            pRequest.HospitalID_$CHAR(13,10)_
            pRequest.SpecialtyID_$CHAR(13,10)_
            pRequest.ProfessionalID_$CHAR(13,10)_
            pRequest.AppointmentTypeID_$CHAR(13,10)_
            pRequest.InsuranceCompanyID_$CHAR(13,10)_
            pRequest.Reason_$CHAR(13,10)_
            pRequest.AppointmentDate_$CHAR(13,10)_
            pRequest.AppointmentTime_$CHAR(13,10)
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
