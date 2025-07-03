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

```
#### 2. NFQM - Number For Query Message
```
```
#### 3. GLIDM - Get Last ID Message
```

```
#### 4. DFQM - Data For Query Message
```
Class IRIS1.msg.DQFM Extends Ens.Request
{
	Property ID As %Integer;
}
```
#### 5. DFDBM - Data From Database Message
```
Class IRIS1.msg.DFDBM Extends Ens.Response
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
Class IRIS1.msg.DDFM Extends Ens.Response
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
# DB
## 1. Patients
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
| 1  | Unai      |            | Pujol Ovejero        | OVPU1030101002 |
| 2  | Ramon     |            | Fernandez Roig       | FERO2050702305 |
| 3  | Ricard    |            | Ferrando Paredes     | FEPA5010503601 |
| 4  | Eugenio   | Rafael     | Fernandez Gonzalez   | FEGO1010209506 |
## 2. Cities
```
CREATE TABLE Cities (
	ID INT AUTO_INCREMENT PRIMARY KEY,
	City VARCHAR(150)
)
```
|ID|City|
|---|---|
|1|Barcelona|
|2|Tarragona|
|3|Reus|
|4|Zaragoza|
|5|Valencia|
## 3. Hospitals
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
|1|Valle de Hebron|1|8035|
|2|Juan XXIII|2|43005|
|3|Sant Joan de Reus|3|43204|
|4|Miguel Servet|4|50009|
|5|Consorcio Hospital General Universitario de València|5|46014|
## 4. Specialties
```
CREATE TABLE Specialties (
	ID INT AUTO_INCREMENT PRIMARY KEY, 
	Specialty VARCHAR(150)
)
```
|ID|Specialty|
|---|---|
|1|Cardiology|
|2|Neurology|
|3|Dermatology|
|4|Pediatrics|
|5|Oncology|
|6|Psychiatry|
|7|Orthopedics|
|8|Gynecology|
|9|Ophthalmology|
## 5. Professionals
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
|1|1|1|Dr. Georgia Ima Downs|
|2|1|6|Dr. Boris Ray Richard|
|3|1|7|Dr. Zenia Brielle Navarro|
|4|1|7|Dr. Kalia Charissa Abbott|
|5|1|2|Dr. Lesley Lilah Hobbs|
|6|2|3|Dr. Hakeem Carl Watson|
|7|2|5|Dr. Audra Sydnee Wolf|
|8|2|2|Dr. Rina Pamela Keith|
|9|2|7|Dr. Nathaniel Sawyer Tran|
|10|2|4|Dr. Audra Tashya Valencia|
|11|3|1|Dr. Cody Kane Hampton|
|12|3|5|Dr. Zenaida Smith Peters|
|13|3|2|Dr. Shellie Cathleen Mathews|
|14|3|5|Dr. Nayda Hedda Colon|
|15|3|6|Dr. Damon Fitzgerald Castaneda|
|16|4|9|Dr. Madaline Adena Mclean|
|17|5|7|Dr. Sheila Candace Moran|
## 6. AppointmentTypes
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
## 7. InsuranceCompanies
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
## 8. Appointments
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
|1|1|3|1|11|2|2|I have been experiencing a sharp chest pain on top of general fatigue.|19-5-2025|17:12|
|2|4|1|1|1|2|1|This is a preiodic checkup|01-10-2025|10:45|
|3|2|2|3|6|2|1|A rash on my right elbow that has persisted for almost a month now.|10-5-2025|08:45|
|4|3|4|9|16|1||I am experiencing a slight balck spot on my sight, appearing from both sides.|10-5-2025|12:03|
## 9. IDC
```
CREATE TABLE IDC (
	ID INT AUTO_INCREMENT PRIMARY KEY,
	LastID INT
)
```
|ID|LastID|
|---|---|
|1|0|
## 10. HIS
```
CREATE TABLE HIS (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT,
    HospitalID INT,
    SpecialtyID INT,
    ProfessionalID INT,
    AppointmentTypeID INT,
    InsuranceCompanyID INT,
    Reason VARCHAR(5000),
    AppointmentDate VARCHAR(150),
    AppointmentTime VARCHAR(150)
)