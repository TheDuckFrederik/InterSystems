Class test0305.RestDispTest0305 Extends %CSP.REST
{

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
<Route Url="/hospital/:PatientID/:CreateFile" Method="GET" Call="SelectPath" Cors="true"/>

</Routes>
}

ClassMethod SelectPath(PatientID As %Integer, CreateFile As %Boolean) As %Status
{
	set tSC = $$$OK
	try {
		set tSC = ##class(Ens.Director).CreateBusinessService("SelectPathService",.tService)

		$$$ThrowOnError(tSC)

		set request = ##class(test0305.msg.SelectProcessRequest).%New()
		set request.PatientID = PatientID
        set request.CreateFile = CreateFile
		set tSC = tService.ProcessInput(request, .output)

		$$$ThrowOnError(tSC)

		do %response.SetHeader("ContentType", "application/json")

		#Dim output As %Library.DynamicObject
		set output = {}
        set output.PatientID = request.PatientID
        set output.CreateFile = request.CreateFile


		write output.%ToJSON()
	}
	catch ex {
		set tSC = ex.AsStatus()
	}
	return tSC
}

}
