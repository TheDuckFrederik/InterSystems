Class IRIS1.bo.ADBO Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Parameter INVOCATION = "Queue";

Method DBComm(pRequest As IRIS1.msg.DFQM, Output pResponse As IRIS1.msg.DFDBM)
{
    set pResponse=##class(IRIS1.msg.DFDBM).%New()
    
    set query = "Select PatientID, HospitalID, SpecialtyID, ProfessionalID, AppointmentTypeID, InsuranceCompanyID, Reason, AppointmentDate, AppointmentTime from SQLUser.Appointments where ID = "_pRequest.ID
    set st =..Adapter.ExecuteQuery(.tResult,query)
    $$$TRACE("st = "_st) 
    do tResult.Next()

    set pResponse.ID=pRequest.ID
    set pResponse.PatientID=tResult.Get("PatientID")
    set pResponse.HospitalID=tResult.Get("HospitalID")
    set pResponse.SpecialtyID=tResult.Get("SpecialtyID")
    set pResponse.ProfessionalID=tResult.Get("ProfessionalID")
    set pResponse.AppointmentTypeID=tResult.Get("AppointmentTypeID")
    set pResponse.InsuranceCompanyID=tResult.Get("InsuranceCompanyID")
    set pResponse.Reason=tResult.Get("Reason")
    set pResponse.AppointmentDate=tResult.Get("AppointmentDate")
    set pResponse.AppointmentTime=tResult.Get("AppointmentTime")

    Quit $$$OK
}

XData MessageMap
{
<MapItems>
        <MapItem MessageType="IRIS1.msg.DFQM">
            <Method>DBComm</Method>
        </MapItem>
    </MapItems>
}

}
