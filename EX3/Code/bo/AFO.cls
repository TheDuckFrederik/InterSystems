Class IRIS1.bo.AFO Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.File.OutboundAdapter";

Parameter INVOCACION = "Queue";

Method CreateFile(pRequest As IRIS1.msg.DFFM, Output pResponse As Ens.Response)
{
        set tData = pRequest.PatientID_","_
                    pRequest.HospitalID_","_
                    pRequest.SpecialtyID_","_
                    pRequest.ProfessionalID_","_
                    pRequest.AppointmentTypeID_","_
                    pRequest.InsuranceCompanyID_","_
                    pRequest.Reason_","_
                    pRequest.AppointmentDate_","_
                    pRequest.AppointmentTime_","
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
