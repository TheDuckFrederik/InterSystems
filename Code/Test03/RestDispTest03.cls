Class code.RestDispTest03 Extends %CSP.REST
{

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
<Route Url="/hospital/:PatientID" Method="GET" Call="SelectInfo" Cors="true"/>

</Routes>
}

ClassMethod SelectInfo(PatientID As %Integer) As %Status
{
	set tSC = $$$OK
	try {
		set tSC = ##class(Ens.Director).CreateBusinessService("SelectService",.tService)

		$$$ThrowOnError(tSC)

		set request = ##class(code.msg.ServiceProcessRequest).%New()
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
