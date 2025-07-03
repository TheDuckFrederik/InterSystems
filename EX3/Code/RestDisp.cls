Class IRIS1.RestDisp Extends %CSP.REST
{

// This file is used used to create calls to a Web Application in IRIS. To make the call you need to get the route from the Web App and add the "URL" to the end of the Web App URL.

// First the UrlMap.

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
	<Route Url="/start/:num" Method="GET" Call="sterter" Cors="true"/>
</Routes>
}

// ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑

// Here we declare the calls, you can declare one or more.

// First we declare the URL, this is the "path" for the call (After the one in the web application). The ":num" means a variable, in the sense that the ":num" is where the number will be placed and processed to the call. Now the method, in this case it's a GET. Then "Call="sterter"" is a call to the name of the class and "Cors="true"".

// ---------------------------------------------------------------------

// This is the class for the call. First we declare the variables and their type "(num As %Integer)" and add "As %Status" to the end.

// ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓

ClassMethod starter(num As %Integer) As %Status
{
	// We add a try catch.
	set tSC = $$$OK // We set the status code to OK, this is the default status code.
	try {
		set tSC = ##class(Ens.Director).CreateBusinessService("PAUS",.tService) // Here we add the name of the Business service on the quotes ("PAUS").

		$$$ThrowOnError(tSC) // Error handling.

		set request = ##class(IRIS1.msg.SPM).%New() // Here we add the message request class.
		set request.num = num // We assign the variable num inside request "request.num" then we assign the value of num (the one that we declared in the class header.
		set tSC = tService.ProcessInput(request, .output) // HEre we set "request" as the output.

		$$$ThrowOnError(tSC) // Error handling.

		do %response.SetHeader("ContentType", "application/json") // Here we give the output a JSON format.

		#Dim output As %Library.DynamicObject // We declare the output variable as a dynamic object, this is used to create a JSON object.
		set output = {} // We set the base value of the output.
        set output.num = request.num // We assign the request variable value to the output variable.
        set output.CreateFile = request.CreateFile // We assign the request variable value to the output variable.


		write output.%ToJSON() // We write the output in JSON format.
	}
	catch ex {
		set tSC = ex.AsStatus() // If there is an error, we catch it and set the status code to the error.
	}
	return tSC // Finally we return the status code.
}

}
