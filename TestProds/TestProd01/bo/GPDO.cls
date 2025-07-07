Class TestProds.TestProd01.BO.GPDO Extends Ens.BusinessOperation
{

// This is for stating the Adapter of this Business Operation, in this case we use the SQL Outbound Adapter because we are connecting to a database.

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

// Just do this.

Parameter INVOCATION = "Queue";

// Here you state the method name and in the parenthesis the request and response messages.

Method PatientInfo(pRequest As TestProds.TestProd01.MSG.RPIM, Output pResponse As TestProds.TestProd01.MSG.GPIM)
{
    // Here we create a new class that is tied to the response message.
    set pResponse=##class(TestProds.TestProd01.MSG.GPIM).%New()

    // Here we first make the query to the database, then we assign the result to the variable tResult.
    set query = "Select FirstName, MiddleName, LastName, BirthDate, Phone, Email, Address, ResidenceCiry, ResidencRegion, ResidencCountry, PostalZip from testprods.patients where PatientID = "_pRequest.PID
    set st =..Adapter.ExecuteQuery(.tResult,query)
    $$$TRACE("st = "_st)
    do tResult.Next()

    // To the left we declare the value of the poperties inside the request message. On the right we assign it to the different fields of the database response.
    set pResponse.PFirstName=tResult.Get("FirstName")
    set pResponse.PMiddleName=tResult.Get("MiddleName")
    set pResponse.PLastName=tResult.Get("LastName")
    set pResponse.PBirthDate=tResult.Get("BirthDate")
    set pResponse.PPhone=tResult.Get("Phone")
    set pResponse.PEmail=tResult.Get("Email")
    set pResponse.PAdress=tResult.Get("Adress")
    set pResponse.PResidenceCity=tResult.Get("ResidenceCity")
    set pResponse.PResidenceRegion=tResult.Get("ResidenceRegion")
    set pResponse.PResidenceCountry=tResult.Get("ResidenceCountry")
    set pResponse.PostalZip=tResult.Get("PostalZip")

    Quit $$$OK
}

// Inside the message map we declare the different methods and assign the request message.

XData MessageMap
{
<MapItems>
        <MapItem MessageType="TestProds.TestProd01.MSG.RPIM">
            <Method>PatientInfo</Method>
        </MapItem>
    </MapItems>
}

}
