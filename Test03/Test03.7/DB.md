```
CREATE TABLE MedicalHistory (
  id INTEGER NOT NULL AUTO_INCREMENT,
  PatientID INTEGER,
  FirstName VARCHAR(255) DEFAULT NULL,
  MiddleName VARCHAR(255) DEFAULT NULL,
  LastName1 VARCHAR(255) DEFAULT NULL,
  LastName2 VARCHAR(255) DEFAULT NULL,
  BirthDate DATE,
  DNI VARCHAR(255),
  weightedlist VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (id)
)
```

```
INSERT INTO MedicalHistory (PatientID, FirstName, MiddleName, LastName1, LastName2, BirthDate, DNI, weightedlist) 
VALUES (1, 'Anne', 'Asher', 'Gill', 'Kline', TO_DATE('26-03-2017', 'DD-MM-YYYY'), '32210721E', '')
```
