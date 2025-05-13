Class IRIS1.RestDisp Extends %CSP.REST
{

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
	<Route Url="/start/:num" Method="GET" Call="sterter" Cors="true"/>
</Routes>
}

ClassMethod starter(num As %Integer) As %Status
{
	set tSC = $$$OK
	try {
		set tSC = ##class(Ens.Director).CreateBusinessService("PAUS",.tService)

		$$$ThrowOnError(tSC)

		set request = ##class(IRIS1.msg.SPM).%New()
		set request.num = num
		set tSC = tService.ProcessInput(request, .output)

		$$$ThrowOnError(tSC)

		do %response.SetHeader("ContentType", "application/json")

		#Dim output As %Library.DynamicObject
		set output = {}
        set output.num = request.num
        set output.CreateFile = request.CreateFile


		write output.%ToJSON()
	}
	catch ex {
		set tSC = ex.AsStatus()
	}
	return tSC
}

}
