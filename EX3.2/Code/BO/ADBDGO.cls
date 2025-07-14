Class EX32.BO.ADBDGO Extends Ens.BusinessOperation
{

// Declare the adapter class that is going to be used for the business operation, in this case we use the SQL Outbound Adapter because we are connecting to a database.

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

// Mandatory parameter to state the invocation type of the business operation.

Parameter INVOCATION = "Queue";

// Here you state the method name and in the parenthesis the request and response messages.

Method AppointmentDataBaseDataGathereing(pRequest As EX32.MSG.DQFM, Output pResponse As EX32.MSG.DFDBM)
{
    // Here we create a new class that is tied to the response message.
    set pResponse = ##class(EX32.MSG.DFDBM).%New()

    // Here we first make the query to the database, then we assign the result to the variable tResult.
    set query = "SELECT a.id AS AppointmentID, p.FirstName, p.MiddleName, p.LastName, p.SSN, h.HospitalName, s.Specialty, pr.Professional AS ProfessionalName, t.AppointmentType, ic.InsuranceCompany, a.Reason, a.AppointmentDate, a.AppointmentTime FROM Appointments a JOIN Patients p ON a.PatientID = p.id JOIN Hospitals h ON a.HospitalID = h.id JOIN Specialties s ON a.SpecialtyID = s.id JOIN Professionals pr ON a.ProfessionalID = pr.id JOIN AppointmentTypes t ON a.AppointmentTypeID = t.id LEFT JOIN InsuranceCompanies ic ON a.InsuranceCompanyID = ic.id WHERE a.id = "_pRequest.ID
    set st = ..Adapter.ExecuteQuery(.tResult, query)
    $$$TRACE("st = "_st)
    do tResult.Next()

    // To the left we declare the value of the properties inside the request message. 
    // On the right we assign it to the different fields of the database response.
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

    // Here we end the method and return the status code.
    Quit $$$OK
}

// Inside the message map we declare the different methods and assign the request message.

XData MessageMap
{
<MapItems>
        <MapItem MessageType="EX32.MSG.DQFM">
            <Method>AppointmentDataBaseDataGathereing</Method>
        </MapItem>
    </MapItems>
}

}
