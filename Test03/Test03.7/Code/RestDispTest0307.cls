Class test0307.RestDispTest0307 Extends %CSP.REST
{

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
<Route Url="/hospital/:PatientID/:CreateFile" Method="GET" Call="HandleRequest" Cors="true"/>
</Routes>
}

ClassMethod HandleRequest(PatientID As %Integer, CreateFile As %Boolean) As %Status
{
    set tSC = $$$OK
    try {
        set tSC = ..ProcessRequest(PatientID, CreateFile, .responseJSON)
        $$$ThrowOnError(tSC)

        do %response.SetHeader("ContentType", "application/json")
        write responseJSON
    }
    catch ex {
        set tSC = ex.AsStatus()
    }
    return tSC
}

ClassMethod ProcessRequest(PatientID As %Integer, CreateFile As %Boolean, Output responseJSON As %String) As %Status
{
    set tSC = $$$OK
    try {
        set tSC = ##class(Ens.Director).CreateBusinessService("SelectPathService", .tService)
        $$$ThrowOnError(tSC)

        set request = ##class(test0305.msg.SelectProcessRequest).%New()
        set request.PatientID = PatientID
        set request.CreateFile = CreateFile

        set tSC = tService.ProcessInput(request, .output)
        $$$ThrowOnError(tSC)

        set responseObj = {} 
        set responseObj.PatientID = request.PatientID
        set responseObj.CreateFile = request.CreateFile
        set responseJSON = responseObj.%ToJSON()
    }
    catch ex {
        set tSC = ex.AsStatus()
    }
    return tSC
}

}
