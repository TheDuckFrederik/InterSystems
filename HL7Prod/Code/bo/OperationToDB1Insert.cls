Class HL7Prod.bo.OperationToDB1Insert Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Parameter INVOCATION = "Queue";

Method InsertToDB1(pRequest As HL7Prod.msg.ProcessToOperationInsert, Output pResponse As Ens.Response)
{
    set pResponse = ##class(HL7Prod.msg.ProcessToOperationInsert).%New()

    set query = "INSERT INTO SQLUser.RAWHL7 (HL7_Message) VALUES ('"_pRequest.HL7Message_"')"
    set st = ..Adapter.ExecuteQuery(.tResult, query)
    $$$TRACE("st = "_st)

    set pResponse.HL7Message=pRequest.HL7Message

    Quit $$$OK
}

XData MessageMap
{
<MapItems>
    <MapItem MessageType="HL7Prod.msg.ProcessToOperationInsert">
        <Method>InsertToDB1</Method>
    </MapItem>
</MapItems>
}

}
