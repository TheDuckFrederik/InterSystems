# Productions
## 1. MCAB - Medical Center Appointment Booking
### BS
#### 1. WADS - Web Appointment Data Service
This Business Service uses a REST Disp to get the data from the web interfaces to 
### BP
#### 1. WADP - Web Appointment Data Process
### BO
#### 1. WADBO - Web Appointment Data Base Operation 
#### 2. WAFO - Web Appointment File Operation 
## 2. AS - Appointment Scheduling
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
## 2. Provinces
```
CREATE TABLE Provinces (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Province VARCHAR(150)
)
```
|ID|Province|
|---|---|
|1|Barcelona|
|2|Tarragona|
|3|Zaragoza|
|4|Valencia|
## 3. Cities
```
CREATE TABLE Cities (
	ID INT AUTO_INCREMENT PRIMARY KEY,
	ProvinceID INT,
	City VARCHAR(150),
	FOREIGN KEY (ProvinceID) REFERENCES Provinces(ID)
)
```
|ID|ProvinceID|City|
|---|---|---|
|1|1|Barcelona|
|2|2|Tarragona|
|3|2|Reus|
|4|3|Zaragoza|
|5|4|Valencia|
## 4. Hospitals
```
CREATE TABLE Hospitals (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    HospitalName VARCHAR(150),
    CityID INT,
    PostalCode INT,
    Location VARCHAR(150),
    FOREIGN KEY (CityID) REFERENCES Cities(ID)
)
```
|ID|HospitalName|CityID|PostalCode|Location|
|---|---|---|---|---|
|1|Valle de Hebron|1|8035|Pg. de la Vall dHebron, 119, Horta-Guinardo|
|2|Juan XXIII|2|43005|Carrer Dr. Mallafré Guasch, 4|
|3|Sant Joan de Reus|3|43204|Avinguda del Doctor Josep Laporte, 2|
|4|Miguel Servet|4|50009|P.º de Isabel la Catolica, 1-3|
|5|Consorcio Hospital General Universitario de València|5|46014|Av. de les Tres Creus, 2|
## 5. Specialties
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
## 6. Professionals
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
## 7. AppointmentTypes
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
## 8. InsuranceCompanies
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
## 9. Appointments
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