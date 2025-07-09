# Description
This has the same purpose as the regular EX3 but this is a 2.0 version, hence the EX3.2 name.

# Productions
## 1. AB - Appointment Booking
### BS
#### 1. PAUS - Periodic Appointment Update Service
This Business Service starts periodically the production.
### BP
#### 1. ADMP - Appointment Data Management Process
Takes the data from the Service and makes the calls to the 2 Business Operations on top of managing and directing the data.
### BO
#### 1. ULIDO - Update Last ID Operation
#### 2. GLIDO - Get Last ID Operation
#### 3. ADBO - Appointment Data Base Operation 
Sends a query into the Database and responds with the appropriate data.
```
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
```
#### 4. AFO - Appointment File Operation
Creates a file with the data.
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
	Property PatientID As %Integer;
	Property HospitalID As %Integer;
	Property SpecialtyID As %Integer;
	Property ProfessionalID As %Integer;
	Property AppointmentTypeID As %Integer;
	Property InsuranceCompanyID As %Integer;
	Property Reason As %String(MAXLEN = 5000);
	Property AppointmentDate As %String;
	Property AppointmentTime As %String;
}
```
#### 6. DFFM - Data For File Message
```
Class EX32.MSG.DDFM Extends Ens.Request
{
	Property ID As %Integer;
	Property PatientID As %Integer;
	Property HospitalID As %Integer;
	Property SpecialtyID As %Integer;
	Property ProfessionalID As %Integer;
	Property AppointmentTypeID As %Integer;
	Property InsuranceCompanyID As %Integer;
	Property Reason As %String(MAXLEN = 5000);
	Property AppointmentDate As %String;
	Property AppointmentTime As %String;
	Property FileName As %String;
}
```
### DB
#### 1. Patients
```
CREATE TABLE Patients (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(150),
    MiddleName VARCHAR(150),
    LastName VARCHAR(150),
    SSN VARCHAR(150)
)
```
| ID | FirstName | MiddleName | LastName             | SSN           |
|----|-----------|------------|----------------------|---------------|
|1|Gareth|Maryam|Morgan|3084314411|
|2|Nolan|Zena|Cole|4332328269|
|3|Sylvester|Shay|Poole|4510001076|
|4|Christine|Garrett|Wall|6892923369|
#### 2. Cities
```
CREATE TABLE Cities (
	ID INT AUTO_INCREMENT PRIMARY KEY,
	City VARCHAR(150)
)
```
|ID|City|
|---|---|
|1|A Coruña|
|2|Ávila|
|3|Alacant|
|4|Alcobendas|
|5|Algeciras|
#### 3. Hospitals
```
CREATE TABLE Hospitals (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    HospitalName VARCHAR(150),
    CityID INT,
    PostalCode INT,
    FOREIGN KEY (CityID) REFERENCES Cities(ID)
)
```
|ID|HospitalName|CityID|PostalCode|
|---|---|---|---|
|1|Hospital A Coruña Del Mar|1|23032|
|2|Hospital A Coruña General|1|37425|
|3|Hospital A Coruña Sur|1|17567|
|4|Hospital A Coruña Del Mar|1|22072|
|5|Hospital Ávila Central|2|48527|
#### 4. Specialties
```
CREATE TABLE Specialties (
	ID INT AUTO_INCREMENT PRIMARY KEY, 
	Specialty VARCHAR(150)
)
```
|ID|Specialty|
|---|---|
|1|Allergy and Immunology|
|2|Anesthesiology|
|3|Dermatology|
|4|Emergency Medicine|
|5|Family Medicine|
#### 5. Professionals
```
CREATE TABLE Professionals (
	ID INT AUTO_INCREMENT PRIMARY KEY, 
	HospitalID INT,
	SpecialtyID INT,
	Professional VARCHAR(150),
	FOREIGN KEY (HospitalID) REFERENCES Hospitals(ID),
	FOREIGN KEY (SpecialtyID) REFERENCES Specialties(ID)
)
```
|ID|HospitalID|SpecialtyID|Professional|
|---|---|---|---|
|1|170|22|Dr. Clark Fuller Butler|
|2|178|47|Dr. Sigourney Steel Pittman|
|3|28|43|Dr. Aretha Kirk Zimmerman|
|4|95|57|Dr. Alana Robin Hanson|
|5|90|61|Dr. Nash Wayne Medina|
#### 6. AppointmentTypes
```
CREATE TABLE AppointmentTypes (
	ID INT AUTO_INCREMENT PRIMARY KEY, 
	AppointmentType VARCHAR(150)
)
```
|ID|AppointmentType|
|---|---|
|1|Private|
|2|Insured|
#### 7. InsuranceCompanies
```
CREATE TABLE InsuranceCompanies (
	ID INT AUTO_INCREMENT PRIMARY KEY, 
	InsuranceCompany VARCHAR(150)
)
```
|ID|InsuranceCompany|
|---|---|
|1|Mafre|
|2|Sanitas|
|3|Asisa|
|4|Generali|
#### 8. Appointments
```
CREATE TABLE Appointments (
    ID INT AUTO_INCREMENT PRIMARY KEY,
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
|ID|PatientID|HospitalID|SpecialtyID|ProfessionalID|AppointmentTypeID|InsuranceCompanyID|Reason|AppointmentDate|AppointmentTime|
|---|---|---|---|---|---|---|---|---|---|
|1|238|28|72|470|2|2|metus vitae velit egestas lacinia. Sed congue, eli...|10-09-2024|12:04|
|2|418|18|45|129|2|1|Mauris nulla. Integer urna. Vivamus molestie dapib...|09-11-2025|15:49|
|3|76|31|30|308|1|3|lorem, sit amet ultricies sem magna nec quam. Cura...|11-10-2024|8:57|
|4|40|23|12|421|2|2|est, vitae sodales nisi magna sed dui. Fusce aliqu...|12-08-2024|13:30|
|5|153|82|64|284|1|3|sit amet, faucibus ut, nulla. Cras eu tellus eu au...|28-07-2026|13:26|
#### 9. IDC
```
CREATE TABLE IDC (
	ID INT AUTO_INCREMENT PRIMARY KEY,
	LastID INT
)
```
|ID|LastID|
|---|---|
|1|0|

## 2. MC - Medical Center
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