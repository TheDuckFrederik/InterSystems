# Description
This has the same purpose as the regular EX3 but this is a 2.0 version, hence the EX3.2 name.

# Productions
## 1. AB
### Appointment Booking
---
### BS
#### 1. DBITS - DB Insert Trigger Service
This Business Service starts when it detects a INSERT in the [Appointments](####8.appointments) table.
### BP
#### 1. NADPM - New Appointment Data Manager Process
Takes the data from an specific field that was inserted in the [Appointments](####7.Appointments) table, extract the data and create a file.
#### 2. UADPM - Updated Appointment Data Manager Process
Takes the data from an specific field that was updated in the [Appointments](####7.Appointments) table, extract the data and create a file.
#### 3. CADPM - Cyclic Appointment Data Manager Process
Takes the data from a given to comb and extract the data and create files for a certain range of  the [Appointments](####7.Appointments) table's fields. 
### BO
#### 1. IDCUO - ID Count & Update Operation
Manages and uses the DB table [IDC](####9.idc).
```
Class EX32.BO.IDUO Extends Ens.BusinessOperation
{
// Declare the adapter class that is going to be used for the business operation, in this case we use the SQL Outbound Adapter because we are connecting to a database.
Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

// Mandatory parameter to state the invocation type of the business operation.
Parameter INVOCATION = "Queue";

// Here you state the method name and in the parenthesis the request and response messages.
Method GetLastID(pRequest As EX32.MSG.NFQM, Output pResponse As EX32.MSG.GLIDM) As %Status
{
    // Here we create a new class that is tied to the response message.
    set pResponse = ##class(EX32.MSG.GLIDM).%New()

    // Here we first make the query to the database, then we assign the result to the variable tResult.
    set query = "SELECT * FROM IDC WHERE ID = "_pRequest.ID
    set st = ..Adapter.ExecuteQuery(.tResult, query)
    $$$TRACE("st = "_st)
    do tResult.Next()

    // To the left we declare the value of the poperties inside the request message. On the right we assign it to the different fields of the database response.
    set pResponse.LastID = tResult.Get("LastID")

    // Here we end the method and return the status code.
    Quit $$$OK
}

// Here you state the method name and in the parenthesis the request and response messages.
Method UpdateLastID(pRequest As EX32.MSG.ULIDM, Output pResponse As Ens.Response) As %Status
{
    // Here we first make the query to the database, then we assign the result to the variable tResult.
    set query = "UPDATE IDC SET LastID = "_pRequest.LastID_" WHERE ID = "_pRequest.ID
    set st = ..Adapter.ExecuteQuery(.tResult, query)
    $$$TRACE("st = "_st)

    // Here we end the method and return the status code.
    Quit $$$OK
}

// Inside the message map we declare the different methods and assign the request message.
XData MessageMap
{
<MapItems>
    <MapItem MessageType="EX32.MSG.NFQM">
        <Method>GetLastID</Method>
    </MapItem>
    <MapItem MessageType="EX32.MSG.ULIDM">
        <Method>UpdateLastID</Method>
    </MapItem>
</MapItems>
}
}
```
##### 1. GetLastID 
Sends a ID number to the [IDC](####9.idc) DB, Selects the number in the LastID field and returns said field's value. 
```
Method GetLastID(pRequest As EX32.MSG.NFQM, Output pResponse As EX32.MSG.GLIDM) As %Status
{
    // Here we create a new class that is tied to the response message.
    set pResponse = ##class(EX32.MSG.GLIDM).%New()

    // Here we first make the query to the database, then we assign the result to the variable tResult.
    set query = "SELECT * FROM IDC WHERE ID = "_pRequest.ID
    set st = ..Adapter.ExecuteQuery(.tResult, query)
    $$$TRACE("st = "_st)
    do tResult.Next()

    // To the left we declare the value of the properties inside the request message. 
    // On the right we assign it to the different fields of the database response.
    set pResponse.LastID = tResult.Get("LastID")

    // Here we end the method and return the status code.
    Quit $$$OK
}
```
##### 2. UpdateLastID 
Sends a ID and a LastID that happens to be the last ID used and updates is in the [IDC](####9.idc) DB.
```
Method UpdateLastID(pRequest As EX32.MSG.ULIDM, Output pResponse As Ens.Response) As %Status
{
    // Here we first make the query to the database, then we assign the result to the variable tResult.
    set query = "UPDATE IDC SET LastID = "_pRequest.LastID_" WHERE ID = "_pRequest.ID
    set st = ..Adapter.ExecuteQuery(.tResult, query)
    $$$TRACE("st = "_st)
    
    // Here we end the method and return the status code.
    Quit $$$OK
}
```
#### 2. ADBDGO - Appointment Data Base Data Gathering Operation
Sends a query into the Database and responds with the appropriate data.
```
Class EX32.BO.ADBDGO Extends Ens.BusinessOperation
{

    // Declare the adapter class that is going to be used for the business operation,
    // in this case we use the SQL Outbound Adapter because we are connecting to a database.
    Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

    // Mandatory parameter to state the invocation type of the business operation.
    Parameter INVOCATION = "Queue";

    // Method that gathers appointment information from the database.
    Method AppointmentDataBaseDataGathereing(pRequest As EX32.MSG.DQFM, Output pResponse As EX32.MSG.DFDBM)
    {
        // Here we create a new class that is tied to the response message.
        set pResponse = ##class(EX32.MSG.DFDBM).%New()

        // Here we first make the query to the database, then we assign the result to the variable tResult.
        set query = "SELECT a.id AS AppointmentID, p.FirstName, p.MiddleName, p.LastName, p.SSN, h.HospitalName, s.Specialty, pr.Professional AS ProfessionalName, t.AppointmentType, ic.InsuranceCompany, a.Reason, a.AppointmentDate, a.AppointmentTime FROM Appointments a JOIN Patients p ON a.PatientID = p.id JOIN Hospitals h ON a.HospitalID = h.id JOIN Specialties s ON a.SpecialtyID = s.id JOIN Professionals pr ON a.ProfessionalID = pr.id JOIN AppointmentTypes t ON a.AppointmentTypeID = t.id LEFT JOIN InsuranceCompanies ic ON a.InsuranceCompanyID = ic.id WHERE a.id = "_pRequest.ID
        set st = ..Adapter.ExecuteQuery(.tResult, query)
        $$$TRACE("st = "_st)
        do tResult.Next()

        // Map query results to response object.
        set pResponse.ID = pRequest.ID
        set pResponse.FirstName = tResult.Get("FirstName")
        set pResponse.MiddleName = tResult.Get("MiddleName")
        set pResponse.LastName = tResult.Get("LastName")
        set pResponse.SSN = tResult.Get("SSN")
        set pResponse.hHospitalName = tResult.Get("HospitalName")
        set pResponse.sSpecialty = tResult.Get("Specialty")
        set pResponse.prProfessionalName = tResult.Get("ProfessionalName") 
        set pResponse.atAppointmentType = tResult.Get("AppointmentType")
        set pResponse.icInsuranceCompany = tResult.Get("InsuranceCompany")
        set pResponse.aReason = tResult.Get("Reason")
        set pResponse.aAppointmentDate = tResult.Get("AppointmentDate")
        set pResponse.aAppointmentTime = tResult.Get("AppointmentTime")

        // Return OK status.
        Quit $$$OK
    }

    // Method that retrieves the file name from the database.
    Method FileNameGathering(pRequest As EX32.MSG.FNRM, Output pResponse As EX32.MSG.FNFDB)
    {
        // Here we create a new class that is tied to the response message.
        set pResponse = ##class(EX32.MSG.FNFDB).%New()

        // Here we first make the query to the database, then we assign the result to the variable tResult.
        set query = "SELECT * from FileNames where id = "_pRequest.ID
        set st = ..Adapter.ExecuteQuery(.tResult, query)
        $$$TRACE("st = "_st)
        do tResult.Next()

        // Map result to response.
        set pResponse.FileName = tResult.Get("FileName")

        // Return OK status.
        Quit $$$OK
    }

    // Message map for routing requests to methods.
    XData MessageMap
    {
        <MapItems>
            <MapItem MessageType="EX32.MSG.DQFM">
                <Method>AppointmentDataBaseDataGathereing</Method>
            </MapItem>
            <MapItem MessageType="EX32.MSG.FNRM">
                <Method>FileNameGathering</Method>
            </MapItem>
        </MapItems>
    }
}
```
##### 1. AppointmentDataBaseDataGathereing
This connects to the table [Appointments](####7.Appointments) to get all of the data from the different tables.
```
Method AppointmentDatabaseDataGathering(pRequest As EX32.MSG.DQFM, Output pResponse As EX32.MSG.DFDBM)
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
```
##### 2. FileNameGathering
This connects to the [FileNames](####10.filenames) table to get the randomly generated file names.
```
Method FileNameGathering(pRequest As EX32.MSG.FNRM, Output pResponse As EX32.MSG.FNFDB)
{
    // Here we create a new class that is tied to the response message.
    set pResponse = ##class(EX32.MSG.FNFDB).%New()

    // Here we first make the query to the database, then we assign the result to the variable tResult.
    set query = "SELECT * FROM FileNames WHERE id = "_pRequest.ID
    set st = ..Adapter.ExecuteQuery(.tResult, query)
    $$$TRACE("st = "_st)
    do tResult.Next()

    // To the left we declare the value of the properties inside the request message. 
    // On the right we assign it to the different fields of the database response.
    set pResponse.FileName=tResult.Get("FileName")

    // Here we end the method and return the status code.
    Quit $$$OK
}
```
#### 3. CADFO - Create Appointment Data File Operation
Creates a file with the data harvested with [ADBDG](#1.appointmentdatabasedatagathereing) .
```
Class EX32.BO.CADFO Extends Ens.BusinessOperation
{
    // Declare the adapter class that is going to be used for the business operation, in this case we use the SQL Outbound Adapter because we are connecting to a database.
    Parameter ADAPTER = "EnsLib.File.OutboundAdapter";

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
```
### MSG
#### 1. SPM - Start Production Message
```

```
#### 1. ULIDM - Update Last ID Message
```
Class EX32.MSG.ULIDM Extends Ens.Request
{
	Property ID As %Integer; 
	Property LastID As %Integer;
}
```
#### 2. NFQM - Number For Query Message
```
Class EX32.MSG.NFQM Extends Ens.Request
{
	Property ID As %Integer;
}
```
#### 3. GLIDM - Get Last ID Message
```
Class EX32.MSG.GLIDM Extends Ens.Response
{
	Property LastID As %Integer;
}
```
#### 4. DFQM - Data For Query Message
```
Class EX32.MSG.DQFM Extends Ens.Request
{
	Property ID As %Integer;
}
```
#### 5. DFDBM - Data From Database Message
```
Class EX32.MSG.DFDBM Extends Ens.Response
{
	Property ID As %Integer;
	Property FirstName As %String;
	Property MiddleName As %String;
	Property LastName As %String;
	Property SSN As %String;
	Property HospitalName As %String;
	Property Specialty As %String;
	Property ProfessionalName As %String;
	Property AppointmentType As %String;
	Property InsuranceCompany As %String;
	Property Reason As %String(MAXLEN = 5000);
	Property AppointmentDate As %String;
	Property AppointmentTime As %String;
}
```
#### 6. FNRM - FileName Request Message
```
Class EX32.MSG.FNRM Extends Ens.Request
{
	Property ID As %Integer;
}
```
#### 7. FNFDB - FileName From Database
```
Class EX32.MSG.FNFDB Extends Ens.Response
{
	Property FileName As %String;
}
```
#### 8. DFFM - Data For File Message
```
Class EX32.MSG.DDFM Extends Ens.Request
{
	Property FirstName As %String;
	Property MiddleName As %String;
	Property LastName As %String;
	Property SSN As %String;
	Property hHospitalName As %String;
	Property sSpecialty As %String;
	Property prProfessionalName As %String;
	Property atAppointmentType As %String;
	Property icInsuranceCompany As %String;
	Property aReason As %String(MAXLEN = 5000);
	Property aAppointmentDate As %String;
	Property aAppointmentTime As %String;
	Property FileName As %String;
}
```
### DB
#### 1. Patients
```
CREATE TABLE Patients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(150),
    MiddleName VARCHAR(150),
    LastName VARCHAR(150),
    SSN VARCHAR(150)
)
```
| id | FirstName | MiddleName | LastName             | SSN           |
|----|-----------|------------|----------------------|---------------|
|1|Gareth|Maryam|Morgan|3084314411|
|2|Nolan|Zena|Cole|4332328269|
|3|Sylvester|Shay|Poole|4510001076|
|4|Christine|Garrett|Wall|6892923369|
#### 2. Cities
```
CREATE TABLE Cities (
	id INT AUTO_INCREMENT PRIMARY KEY,
	City VARCHAR(150)
)
```
|id|City|
|---|---|
|1|A Coruña|
|2|Ávila|
|3|Alacant|
|4|Alcobendas|
|5|Algeciras|
#### 3. Hospitals
```
CREATE TABLE Hospitals (
    id INT AUTO_INCREMENT PRIMARY KEY,
    HospitalName VARCHAR(150),
    CityID INT,
    PostalCode INT,
    FOREIGN KEY (CityID) REFERENCES Cities(ID)
)
```
|id|HospitalName|CityID|PostalCode|
|---|---|---|---|
|1|Hospital A Coruña Del Mar|1|23032|
|2|Hospital A Coruña General|1|37425|
|3|Hospital A Coruña Sur|1|17567|
|4|Hospital A Coruña Del Mar|1|22072|
|5|Hospital Ávila Central|2|48527|
#### 4. Specialties
```
CREATE TABLE Specialties (
	id INT AUTO_INCREMENT PRIMARY KEY, 
	Specialty VARCHAR(150)
)
```
|id|Specialty|
|---|---|
|1|Allergy and Immunology|
|2|Anesthesiology|
|3|Dermatology|
|4|Emergency Medicine|
|5|Family Medicine|
#### 5. Professionals
```
CREATE TABLE Professionals (
	id INT AUTO_INCREMENT PRIMARY KEY, 
	HospitalID INT,
	SpecialtyID INT,
	Professional VARCHAR(150),
	FOREIGN KEY (HospitalID) REFERENCES Hospitals(ID),
	FOREIGN KEY (SpecialtyID) REFERENCES Specialties(ID)
)
```
|id|HospitalID|SpecialtyID|Professional|
|---|---|---|---|
|1|170|22|Dr. Clark Fuller Butler|
|2|178|47|Dr. Sigourney Steel Pittman|
|3|28|43|Dr. Aretha Kirk Zimmerman|
|4|95|57|Dr. Alana Robin Hanson|
|5|90|61|Dr. Nash Wayne Medina|
#### 6. AppointmentTypes
```
CREATE TABLE AppointmentTypes (
	id INT AUTO_INCREMENT PRIMARY KEY, 
	AppointmentType VARCHAR(150)
)
```
|id|AppointmentType|
|---|---|
|1|Private|
|2|Insured|
#### 7. InsuranceCompanies
```
CREATE TABLE InsuranceCompanies (
	id INT AUTO_INCREMENT PRIMARY KEY, 
	InsuranceCompany VARCHAR(150)
)
```
|id|InsuranceCompany|
|---|---|
|1|Mafre|
|2|Sanitas|
|3|Asisa|
|4|Generali|
#### 8. Appointments
```
CREATE TABLE Appointments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT,
    HospitalID INT,
    SpecialtyID INT,
    ProfessionalID INT,
    AppointmentTypeID INT,
    InsuranceCompanyID INT,
    Reason VARCHAR(5000),
    AppointmentDate VARCHAR(150),
    AppointmentTime VARCHAR(150),
    FOREIGN KEY (PatientID) REFERENCES Patients(ID),
    FOREIGN KEY (HospitalID) REFERENCES Hospitals(ID),
    FOREIGN KEY (SpecialtyID) REFERENCES Specialties(ID),
    FOREIGN KEY (ProfessionalID) REFERENCES Professionals(ID),
    FOREIGN KEY (AppointmentTypeID) REFERENCES AppointmentTypes(ID),
    FOREIGN KEY (InsuranceCompanyID) REFERENCES InsuranceCompanies(ID)
)
```
|id|PatientID|HospitalID|SpecialtyID|ProfessionalID|AppointmentTypeID|InsuranceCompanyID|Reason|AppointmentDate|AppointmentTime|
|---|---|---|---|---|---|---|---|---|---|
|1|238|28|72|470|2|2|metus vitae velit egestas lacinia. Sed congue, eli...|10-09-2024|12:04|
|2|418|18|45|129|2|1|Mauris nulla. Integer urna. Vivamus molestie dapib...|09-11-2025|15:49|
|3|76|31|30|308|1|3|lorem, sit amet ultricies sem magna nec quam. Cura...|11-10-2024|8:57|
|4|40|23|12|421|2|2|est, vitae sodales nisi magna sed dui. Fusce aliqu...|12-08-2024|13:30|
|5|153|82|64|284|1|3|sit amet, faucibus ut, nulla. Cras eu tellus eu au...|28-07-2026|13:26|
#### 9. IDC
```
CREATE TABLE IDC (
	id INT AUTO_INCREMENT PRIMARY KEY,
	LastID INT
)
```
|id|LastID|
|---|---|
|1|0|
#### 10. FileNames
```
CREATE TABLE FileNames (
	id INT AUTO_INCREMENT PRIMARY KEY,
	FileName VARCHAR(255)
)
```
|id|FileName|
|---|---|
|1|CA91VXV6VT774OQ27|
|2|ON35MNK4UA235WR75|
|3|SP31JII3AQ415XC93|
|4|LS83WDH7WE564YU43|
|5|KP27MKY6GJ802BT89|
## 2. MC
### Medical Center
---
### BS
#### 1. RFS - Receive File Service
Receives the files and sends the data to the Process.
### BP
#### 1. MRDP - Manage Received Data Process
Makes a call to the Operation and sends the received data.
### BO
#### 1. IRDO - Insert Received Data Operation
Sends a query and the data to the Database.
### MSG
#### 1. RDM - Received Data Message
#### 2. DFQM - Data For Query Message
#### 3. DFDBM - Data From Database Message
### DB
#### 1. HIS
```
```