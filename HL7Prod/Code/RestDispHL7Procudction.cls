Class HL7Prod.RestDispHL7Production Extends %CSP.REST
{

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
	<Route Url="/RTP/:HL7Message" Method="PUT" Call="RestToProcess" Cors="true"/>
</Routes>
}

ClassMethod RestToProcess(HL7Message As %String(MAXLEN=500000000)) As %Status
{
	set tSC = $$$OK
	try {
		set tSC = ##class(Ens.Director).CreateBusinessService("RestToProcess",.tService)

		$$$ThrowOnError(tSC)

		set request = ##class(HL7Prod.msg.ServiceToProcessInsert).%New()
		set request.HL7Message = HL7Message
		set tSC = tService.ProcessInput(request, .output)

		$$$ThrowOnError(tSC)

		do %response.SetHeader("ContentType", "application/json")

		#Dim output As %Library.DynamicObject
		set output = {}
        set output.HL7Message = request.HL7Message

		write output.%ToJSON()
	}
	catch ex {
		set tSC = ex.AsStatus()
	}
	return tSC
}

}
