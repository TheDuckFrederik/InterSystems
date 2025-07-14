Class EX32.BO.CADFO Extends Ens.BusinessOperation
{

// Declare the adapter class that is going to be used for the business operation, in this case we use the SQL Outbound Adapter because we are connecting to a database.

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

// Mandatory parameter to state the invocation type of the business operation.

Parameter INVOCATION = "Queue";

// Here you state the method name and in the parenthesis the request and response messages.

Method CreateAppointmentDataFileOperation(pRequest As EX32.MSG.DDFM, Output pResponse As Ens.Response)
{
    // Here we create the data string that will be written to the file.
    // At the same time giving it a format and structure.
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

    // Here we write the data to the file using the adapter.
    set sc = ..Adapter.PutString(pRequest.FileName, tData)
    $$$TRACE("st = "_$system.Status.DisplayError(sc))

    // Here we end the method and return the status code.
    Quit $$$OK
}

// Inside the message map we declare the different methods and assign the request message.

XData MessageMap
{
<MapItems>
        <MapItem MessageType="EX32.MSG.DDFM">
            <Method>CreateAppointmentDataFileOperation</Method>
        </MapItem>
    </MapItems>
}

}
