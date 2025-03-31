Class test0305.bo.DeletePathDB Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Parameter INVOCATION = "Queue";

Method DeleteData(pRequest As test0305.msg.DeleteDBRequest, Output pResponse As Ens.Response) As %Status
{
    set query = "DELETE from SQLUser.MedicalHistory WHERE PatientID = "_pRequest.PatientID
    set st = ..Adapter.ExecuteQuery(.tResult, query)
    $$$TRACE("st = "_st)

    Quit $$$OK
}

XData MessageMap
{
<MapItems>
    <MapItem MessageType="test0305.msg.DeleteDBRequest">
        <Method>DeleteData</Method>
    </MapItem>
</MapItems>
}

}
