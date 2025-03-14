Class code.RestDispTest01 Extends %CSP.REST
{

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>

<Route Url="/patientinfo/:PatientID" Method="GET" Call="GetPatientInfo" Cors="true"/>

</Routes>
}

ClassMethod GetPatientInfo(PatientID As %Integer) As %Status
{
    do %response.SetHeader("Access-Control-Allow-Origin", "*")
    do %response.SetHeader("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS")
    do %response.SetHeader("Access-Control-Allow-Headers", "Content-Type")
    //
    set tSC = $$$OK
    try {
        set tSC = ##class(Ens.Director).CreateBusinessService("PatientIDService",.tService)

        $$$ThrowOnError(tSC)

        set request = ##class(code.msg.ProcessRequest).%New()
        set request.PatientID = PatientID
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
