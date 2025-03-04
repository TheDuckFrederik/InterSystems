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
