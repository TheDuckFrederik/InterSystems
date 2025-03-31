Class test0305.RestDispTest0305 Extends %CSP.REST
{

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
	<Route Url="/selectpath/:PatientID/:CreateFile" Method="GET" Call="SelectPath" Cors="true"/>
	<Route Url="/insertpath/:PatientID/:FirstName/:MiddleName/:LastName1/:LastName2/:BirthDate/:DNI/:Allergies/:CreateFile" Method="PUT" Call="InsertPath" Cors="true"/>
	<Route Url="/updatepath/:PatientID/:FirstName/:MiddleName/:LastName1/:LastName2/:BirthDate/:DNI/:Allergies/:CreateFile" Method="POST" Call="UpdatePath" Cors="true"/>
	<Route Url="/deletepath/:PatientID" Method="DELETE" Call="DeletePath" Cors="true"/>
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

ClassMethod InsertPath(PatientID As %Integer, FirstName As %String, MiddleName As %String, LastName1 As %String, LastName2 As %String, BirthDate As %String, DNI As %String, Allergies As %String, CreateFile As %Boolean) As %Status
{
	set tSC = $$$OK
	try {
		set tSC = ##class(Ens.Director).CreateBusinessService("InsertPathService",.tService)

		$$$ThrowOnError(tSC)

		set request = ##class(test0305.msg.InsertProcessRequest).%New()
		set request.PatientID = PatientID
		set request.FirstName = FirstName
		set request.MiddleName = MiddleName
		set request.LastName1 = LastName1
		set request.LastName2 = LastName2
		set request.BirthDate = BirthDate
		set request.DNI = DNI
		set request.Allergies = Allergies
        set request.CreateFile = CreateFile
		set tSC = tService.ProcessInput(request, .output)

		$$$ThrowOnError(tSC)

		do %response.SetHeader("ContentType", "application/json")

		#Dim output As %Library.DynamicObject
		set output = {}
        set output.PatientID = request.PatientID
		set output.FirstName = request.FirstName
		set output.MiddleName = request.MiddleName
		set output.LastName1 = request.LastName1
		set output.LastName2 = request.LastName2
		set output.BirthDate = request.BirthDate
		set output.DNI = request.DNI
		set output.Allergies = request.Allergies
        set output.CreateFile = request.CreateFile

		#; do %response.SetHeader("ContentType", "application/json")

		#; #Dim output As %Library.DynamicObject
		#; set response = ##class(test0305.msg.InsertProcessRequest).%New()
		#; set output = {}
        #; set output.PatientID = response.PatientID
		#; set output.FirstName = response.FirstName
		#; set output.MiddleName = response.MiddleName
		#; set output.LastName1 = response.LastName1
		#; set output.LastName2 = response.LastName2
		#; set output.BirthDate = response.BirthDate
		#; set output.DNI = response.DNI
		#; set output.Allergies = response.Allergies
        #; set output.CreateFile = response.CreateFile

		write output.%ToJSON()
	}
	catch ex {
		set tSC = ex.AsStatus()
	}
	return tSC
}

ClassMethod UpdatePath(PatientID As %Integer, FirstName As %String, MiddleName As %String, LastName1 As %String, LastName2 As %String, BirthDate As %String, DNI As %String, Allergies As %String, CreateFile As %Boolean) As %Status
{
	set tSC = $$$OK
	try {
		set tSC = ##class(Ens.Director).CreateBusinessService("UpdatePathService",.tService)

		$$$ThrowOnError(tSC)

		set request = ##class(test0305.msg.UpdateProcessRequest).%New()
		set request.PatientID = PatientID
		set request.FirstName = FirstName
		set request.MiddleName = MiddleName
		set request.LastName1 = LastName1
		set request.LastName2 = LastName2
		set request.BirthDate = BirthDate
		set request.DNI = DNI
		set request.Allergies = Allergies
        set request.CreateFile = CreateFile
		set tSC = tService.ProcessInput(request, .output)

		$$$ThrowOnError(tSC)

		do %response.SetHeader("ContentType", "application/json")

		#Dim output As %Library.DynamicObject
		set output = {}
        set output.PatientID = request.PatientID
		set output.FirstName = request.FirstName
		set output.MiddleName = request.MiddleName
		set output.LastName1 = request.LastName1
		set output.LastName2 = request.LastName2
		set output.BirthDate = request.BirthDate
		set output.DNI = request.DNI
		set output.Allergies = request.Allergies
        set output.CreateFile = request.CreateFile

		write output.%ToJSON()
	}
	catch ex {
		set tSC = ex.AsStatus()
	}
	return tSC
}

ClassMethod DeletePath(PatientID As %Integer) As %Status
{
	set tSC = $$$OK
	try {
		set tSC = ##class(Ens.Director).CreateBusinessService("DeletePathService",.tService)

		$$$ThrowOnError(tSC)

		set request = ##class(test0305.msg.DeleteProcessRequest).%New()
		set request.PatientID = PatientID
		set tSC = tService.ProcessInput(request, .output)

		$$$ThrowOnError(tSC)

		do %response.SetHeader("ContentType", "application/json")

		#Dim output As %Library.DynamicObject
		set output = {}
        set output.PatientID = request.PatientID


		write output.%ToJSON()
	}
	catch ex {
		set tSC = ex.AsStatus()
	}
	return tSC
}

}
