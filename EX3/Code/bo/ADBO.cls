Class IRIS1.bo.ADBO Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Parameter INVOCATION = "Queue";

Method DBComm(pRequest As IRIS1.msg.DFQM, Output pResponse As IRIS1.msg.DFDBM)
{
    set pResponse=##class(IRIS1.msg.DFDBM).%New()

    set query = "SELECT a.ID AS AppointmentID, p.FirstName, p.MiddleName, p.LastName, p.SSN, h.HospitalName, s.Specialty, pr.Professional AS ProfessionalName, t.AppointmentType, ic.InsuranceCompany, a.Reason, a.AppointmentDate, a.AppointmentTime FROM Appointments a JOIN Patients p ON a.PatientID = p.ID JOIN Hospitals h ON a.HospitalID = h.ID JOIN Specialties s ON a.SpecialtyID = s.ID JOIN Professionals pr ON a.ProfessionalID = pr.ID JOIN AppointmentTypes t ON a.AppointmentTypeID = t.ID LEFT JOIN InsuranceCompanies ic ON a.InsuranceCompanyID = ic.ID WHERE a.ID = "_pRequest.ID
    set st =..Adapter.ExecuteQuery(.tResult,query)
    $$$TRACE("st = "_st)
    do tResult.Next()

    set pResponse.ID=pRequest.ID
    set pResponse.FirstName=tResult.Get("FirstName")
    set pResponse.MiddleName=tResult.Get("MiddleName")
    set pResponse.LastName=tResult.Get("LastName")
    set pResponse.SSN=tResult.Get("SSN")
    set pResponse.hHospitalName=tResult.Get("HospitalName")
    set pResponse.sSpecialty=tResult.Get("Specialty")
    set pResponse.prProfessionalName=tResult.Get("ProfessionalName")
    set pResponse.atAppointmentType=tResult.Get("AppointmentType")
    set pResponse.icInsuranceCompany=tResult.Get("InsuranceCompany")
    set pResponse.aReason=tResult.Get("Reason")
    set pResponse.aAppointmentDate=tResult.Get("AppointmentDate")
    set pResponse.aAppointmentTime=tResult.Get("AppointmentTime")

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
