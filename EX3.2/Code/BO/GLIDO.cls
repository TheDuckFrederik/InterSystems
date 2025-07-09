Class EX32.BO.GLIDO Extends Ens.BusinessOperation
{

// Declare the adapter class that is going to be used for the business operation, in this case we use the SQL Outbound Adapter because we are connecting to a database.

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

// Mandatory parameter to state the invocation type of the business operation.

Parameter INVOCATION = "Queue";

// Here you state the method name and in the parenthesis the request and response messages.

Method GetLastID(pRequest As EX32.MSG.NFQM, Output pResponse As EX32.MSG.GLIDM) As %Status
{
    // Here we create a new class that is tied to the response message.
    set pResponse = ##class(EX32.MSG.GLIDM).%New()

    // Here we first make the query to the database, then we assign the result to the variable tResult.
    set query = "Select * from idc where ID="_pRequest.ID
    set st =..Adapter.ExecuteQuery(.tResult,query)
    $$$TRACE("st = "_st)
    do tResult.Next()

    // To the left we declare the value of the poperties inside the request message. On the right we assign it to the different fields of the database response.
    set pResponse.LastID = tResult.Get("LastID")

    // Here we end the method and return the status code.
    Quit $$$OK
}

// Inside the message map we declare the different methods and assign the request message.

XData MessageMap
{
<MapItems>
        <MapItem MessageType="EX32.MSG.NFQM">
            <Method>GetLastID</Method>
        </MapItem>
    </MapItems>
}

}
