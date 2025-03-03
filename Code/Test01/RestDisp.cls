Class code.RestDisp Extends %CSP.REST
{

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
    <Route Url="/patientinfo/:PatientID" Method="GET" Call="GetPatientInfo"/>
    <Route Url="/patientinfo/:PatientID" Method="OPTIONS" Call="HandleOptions"/>
</Routes>
}

// Handle CORS globally for all requests

ClassMethod OnPreDispatch() As %Status
{
    Do %response.SetHeader("Access-Control-Allow-Origin", "*")
    Do %response.SetHeader("Access-Control-Allow-Methods", "GET, POST, OPTIONS")
    Do %response.SetHeader("Access-Control-Allow-Headers", "Content-Type, Authorization")
    Quit $$$OK
}

// Handle OPTIONS requests (CORS preflight)

ClassMethod HandleOptions(PatientID As %String) As %Status
{
    Do %response.SetStatus(204)  // No content response
    Quit $$$OK
}

// Handle GET request for Patient Info

ClassMethod GetPatientInfo(PatientID As %Integer) As %Status
{
    Set tSC = $$$OK
    Try {
        // Call Business Service
        Set tSC = ##class(Ens.Director).CreateBusinessService("PatientIDService", .tService)
        $$$ThrowOnError(tSC)

        Set request = ##class(code.msg.ProcessRequest).%New()
        Set request.PatientID = PatientID
        Set tSC = tService.ProcessInput(request, .output)
        $$$ThrowOnError(tSC)

        // Send JSON response
        Do %response.SetHeader("Content-Type", "application/json")

        #Dim output As %Library.DynamicObject
        Set output = {"status":"pending"}

        Write output.%ToJSON()
    }
    Catch ex {
        Set tSC = ex.AsStatus()
    }
    Quit tSC
}

}
