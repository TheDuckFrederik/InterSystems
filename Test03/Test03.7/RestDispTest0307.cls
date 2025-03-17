Class test0307.RestDispTest0307 Extends %CSP.REST
{

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
    <Route Url="/selectpath/:PatientID/:CreateFile" Method="GET" Call="SelectPath" Cors="true"/>
</Routes>
}

ClassMethod SelectPath(PatientID As %Integer, CreateFile As %Boolean) As %Status
{
    set tSC = $$$OK
    try {
        set tSC = ##class(Ens.Director).CreateBusinessService("SelectPathService", .tService)
        $$$ThrowOnError(tSC)

        set request = ##class(test0307.msg.SelectProcessRequest).%New()
        set request.PatientID = PatientID
        set request.CreateFile = CreateFile

        set tSC = tService.ProcessInput(request, .output)
        $$$ThrowOnError(tSC)

        do %response.SetHeader("ContentType", "application/json")

        write ..BuildJSONResponse(request).%ToJSON()
    }
    catch ex {
        set tSC = ex.AsStatus()
    }
    return tSC
}

}
