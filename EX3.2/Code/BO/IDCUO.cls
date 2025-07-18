Class EX32.BO.IDCUO Extends Ens.BusinessOperation
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

    // ID is always 3 for this Method.
    set pRequest.ID = 3

    // Here we first make the query to the database, then we assign the result to the variable tResult.
    set query = "SELECT * FROM IDC WHERE ID = "_pRequest.ID
    set st = ..Adapter.ExecuteQuery(.tResult, query)
    $$$TRACE("st = "_st)
    do tResult.Next()

    // To the left we declare the value of the properties inside the request message. 
    // On the right we assign it to the different fields of the database response.
    set pResponse.LastID = tResult.Get("Identifier")

    // Here we end the method and return the status code.
    Quit $$$OK
}

// Here you state the method name and in the parenthesis the request and response messages.

Method UpdateLastID(pRequest As EX32.MSG.ULIDM, Output pResponse As Ens.Response) As %Status
{
    // ID is always 3 for this Method.
    set pRequest.ID = 3

    // Here we first make the query to the database, then we assign the result to the variable tResult.
    set query = "UPDATE IDC SET Identifier = "_pRequest.LastID_" WHERE ID = "_pRequest.ID
    set st = ..Adapter.ExecuteQuery(.tResult, query)
    $$$TRACE("st = "_st)
    
    // Here we end the method and return the status code.
    Quit $$$OK
}

// Here you state the method name and in the parenthesis the request and response messages.

Method UpdateIDRange(pRequest As EX32.MSG.UIDRM, Output pResponse As Ens.Response) As %Status
{
    // ID1 is always 1 and ID2 is always 2 for this Method.
    set pRequest.ID1 = 1
    set pRequest.ID2 = 2

    // Here we first make the query to the database, then we assign the result to the variable tResult.
    set query = "UPDATE idc"_$char(13,10)_"SET"_$char(13,10)_"  Identifier = CASE"_$char(13,10)_"       WHEN id = "_pRequest.ID1_" THEN "_pRequest.FirstRangeID_$char(13,10)_"       WHEN id = "_pRequest.ID2_" THEN "_pRequest.LastRangeID_$char(13,10)_"       ELSE Identifier"_$char(13,10)_"  END"_$char(13,10)_"WHERE id IN ("_pRequest.ID1_", "_pRequest.ID2_")"
    set st = ..Adapter.ExecuteQuery(.tResult, query)
    $$$TRACE("st = "_st)
    
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
        <MapItem MessageType="EX32.MSG.ULIDM">
            <Method>UpdateLastID</Method>
        </MapItem>
        <MapItem MessageType="EX32.MSG.UIDRM">
            <Method>UpdateIDRange</Method>
        </MapItem>
    </MapItems>
}

}
