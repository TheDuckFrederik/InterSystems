Class IRIS1.bo.ADBO Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Parameter INVOCATION = "Queue";

Method DBComm(pRequest As IRIS1.msg.DFQM, Output pResponse As IRIS1.msg.DFDBM)
{
    set pResponse=##class(IRIS1.msg.DFDBM).%New()

    set query = "SELECT a.ID AS AppointmentID, p.FirstName || ' ' || p.MiddleName || ' ' || p.LastName || ' (' || p.SSN || ')' AS PatientName, h.HospitalName, s.Specialty, pr.Professional AS ProfessionalName, 'AT'.AppointmentType, ic.InsuranceCompany, a.Reason, a.AppointmentDate, a.AppointmentTime FROM Appointments a JOIN Patients p ON a.PatientID = p.ID JOIN Hospitals h ON a.HospitalID = h.ID JOIN Specialties s ON a.SpecialtyID = s.ID JOIN Professionals pr ON a.ProfessionalID = pr.ID JOIN AppointmentTypes 'AT' ON a.AppointmentTypeID = 'AT'.ID LEFT JOIN InsuranceCompanies ic ON a.InsuranceCompanyID = ic.ID WHERE a.ID = "_pRequest.ID
    set st =..Adapter.ExecuteQuery(.tResult,query)
    $$$TRACE("st = "_st)
    //do tResult.Next()

    set pResponse.FirstName=tResult.Get("p.FirstName")
    set pResponse.MiddleName=tResult.Get("p.MiddleName")
    set pResponse.LastName=tResult.Get("p.LastName")
    set pResponse.SSN=tResult.Get("p.SSN")
    set pResponse.hHospitalName=tResult.Get("h.HospitalName")
    set pResponse.sSpecialty=tResult.Get("s.Specialty")
    set pResponse.prProfessionalName=tResult.Get("pr.Professional")
    set pResponse.atAppointmentType=tResult.Get("'AT'.AppointmentType")
    set pResponse.icInsuranceCompany=tResult.Get("ic.InsuranceCompany")
    set pResponse.aReason=tResult.Get("a.Reason")
    set pResponse.aAppointmentDate=tResult.Get("a.AppointmentDate")
    set pResponse.aAppointmentTime=tResult.Get("a.AppointmentTime")

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
