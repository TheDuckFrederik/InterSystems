# Test 02
## Namespace
- ### Package:
	- This production will be in the pIRIS namespace and will be in the package: test02.
- ### Production:
	- This production will be in the test02 package and will be called: PatientData.
### ![Diagram](/Test02/Test02.png)
## Variables
- PatientDataID %Integer
- FirstName %String
- MiddleName %String
- LastName %String
- Age %Integer
- Allergies %String
## Messages
- ### PatientDataProcessRequest
    ```
    Class code.msg.PatientDataProcessRequest Extends Ens.Request
    {

    Property PatientDataID As %Integer;

    Property FirstName As %String;

    Property MiddleName As %String;

    Property LastName As %String;

    Property Age As %Integer;

    Property Allergies As %String;

    Storage Default
    }
    ```
- ### PatientDataDBRequest
    ```
    Class code.msg.PatientDataDBRequest Extends Ens.Request
    {

    Property PatientDataID As %Integer;

    Property FirstName As %String;

    Property MiddleName As %String;

    Property LastName As %String;

    Property Age As %Integer;

    Property Allergies As %String;

    }
    ```
- ### PatientDataDBResponse
    ```
    Class code.msg.PatientDataDBResponse Extends Ens.Response
    {

    Property PatientDataID As %Integer;

    Property FirstName As %String;

    Property MiddleName As %String;

    Property LastName As %String;

    Property Age As %Integer;

    Property Allergies As %String;

    }
    ```
## Dispatch
- ### RestDispTest02
    ```
    Class code.RestDispTest02 Extends %CSP.REST
    {

    XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
    {
    <Routes>

    <Route Url="/patientdata/:PatientDataID/:FirstName/:MiddleName/:LastName/:Age/:Allergies" Method="PUT" Call="GetPatientData" Cors="true"/>

    </Routes>
    }

    ClassMethod GetPatientData(PatientDataID As %Integer, FirstName As %String, MiddleName As %String, LastName As %String, Age As %Integer, Allergies As %String) As %Status
    {
        set tSC = $$$OK
        try {
            set tSC = ##class(Ens.Director).CreateBusinessService("PatientDataService",.tService)

            $$$ThrowOnError(tSC)

            set request = ##class(code.msg.PatientDataProcessRequest).%New()
            set request.PatientDataID = PatientDataID
            set request.FirstName = FirstName
            set request.MiddleName = MiddleName
            set request.LastName = LastName
            set request.Age = Age
            set request.Allergies = Allergies
            set tSC = tService.ProcessInput(request, .output)

            $$$ThrowOnError(tSC)

            do %response.SetHeader("ContentType", "application/json")

            #Dim output As %Library.DynamicObject
            set output = {"status":"pending"}

            write output.%ToJSON()
        }
        catch ex {
            set tSC = ex.AsStatus()
        }
        return tSC
    }

    }
    ```
- ### Web Application
	- ### ![Web Application General](/Test02/WAG.png)
	- ### ![Web Application Application Roles](/Test01/WAARAS.png)
	- ### ![Web Application Application Roles Selected](/Test01/WAAR.png)
## Buisness Services
- ### PatientDataService
    ```
    Class code.bs.PatientDataService Extends Ens.BusinessService
    {

    Method OnProcessInput(pInput As code.msg.PatientDataProcessRequest, Output pOutput As %RegisteredObject) As %Status
    {
        set tSC = $$$OK
        try {
        //set tRequest = ##class(code.msg.PatientDataDBRequest).%New()
        //set tRequest.PatientID = pInput.StringValue

        set tSC = ..SendRequestSync("PatientDataProcess", pInput, .tResponse)
        $$$ThrowOnError(tSC)
        }
        catch ex {
            set tSC = ex.AsStatus()
        }
            return tSC
    }

    }
    ```
- ## Postman
	- ### `http://localhost:52773/csp/test02/patientdata/:PatientDataID/:FirstName/:MiddleName/:LastName/:Age/:Allergies`
    - ### ![Postman](/Test02/Postman.png)
## Buisness Processes
- ### PatientDataProcess
	- ### ![Diagram](/Test02/Process1.png)
	- ### ![Context](/Test02/Context.png)
	- ### ![Patient Data](/Test02/PatientData.png)
	- ### ![Patient Data Request Builder](/Test02/PDRequestBuilder.png)
	- ### ![Patient Data Response Builder](/Test02/PDResponseBuilder.png)
## Buisness Operations
- ### PatientDataOperation
    ```
    Class code.bo.PatientDataOperation Extends Ens.BusinessOperation
    {

    Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

    Parameter INVOCATION = "Queue";

    Method PatientData(pRequest As code.msg.PatientDataDBRequest, Output pResponse As code.msg.PatientDataDBResponse) As %Status
    {
        set pResponse = ##class(code.msg.PatientDataDBResponse).%New()
        
        set query = "INSERT INTO SQLUser.PatientData (PatientDataID, FirstName, MiddleName, LastName, Age, Allergies) VALUES ("_pRequest.PatientDataID_", '"_pRequest.FirstName_"', '"_pRequest.MiddleName_"', '"_pRequest.LastName_"', "_pRequest.Age_", '"_pRequest.Allergies_"')"
        set st = ..Adapter.ExecuteQuery(.tResult, query)
        $$$TRACE("st = "_st)

        set pResponse.PatientDataID=pRequest.PatientDataID
        set pResponse.FirstName=pRequest.FirstName
        set pResponse.MiddleName=pRequest.MiddleName
        set pResponse.LastName=pRequest.LastName
        set pResponse.Age=pRequest.Age
        set pResponse.Allergies=pRequest.Allergies

        Quit $$$OK
    }

    XData MessageMap
    {
    <MapItems>
        <MapItem MessageType="code.msg.PatientDataDBRequest">
            <Method>PatientData</Method>
        </MapItem>
    </MapItems>
    }

    }
    ```
## Data Base
- ### SQL Table: Patients
    ```
    CREATE TABLE PatientData (
        PatientID INT PRIMARY KEY,
        FirstName VARCHAR(150),
        MiddleName VARCHAR(150),
        LastName VARCHAR(150),
        Age INT,
        Allergies VARCHAR(150)
    )
    ```
- ### SQL Select Rows
    ```
    SELECT * from SQLUser.Patientdata
    ```
- ### SQL Drop Table
    ```
    DROP TABLE PatientData;
    ```
- ### DSN
	- Open ODBC 64 bits
	- Under "System DSN" click "Add..."
	- ![Action description](DSNAdd.png)
	- Select the "InterSystems IRIS" then click "Finish"
	- ![Action Despcription 2](DSNServer.png)
	- Now fill the server info with the following details then click "Ok".
	- ![Action Description 3](/Test02/DSNInfo.png)
