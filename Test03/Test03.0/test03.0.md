# Test 03
## Namespace
- ### Package:
	- This production will be in the pIRIS namespace and will be in the package: test03.
- ### Production:
	- This production will be in the test03 package and will be called: .
### ![Diagram](/Test03/Test03.0/DIAGRAMCTest03.png)
## Data Base
- ### SQL Table: Patients
    ```
    CREATE TABLE MedicalHistory (
        PatientID INT PRIMARY KEY,
        FirstName VARCHAR(150),
        MiddleName VARCHAR(150),
        FirstLastName VARCHAR(150),
        SecondLastName VARCHAR(150),
        BirthDate VARCHAR(150),
        DNI VARCHAR(150),
        Allergies VARCHAR(150)
    )
    ```
## Select Route
- ### ![Select Route Diagram](/Test03/Test03.0/SRD.png)