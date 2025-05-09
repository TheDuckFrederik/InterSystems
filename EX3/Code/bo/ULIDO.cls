Class IRIS1.bo.ULIDO Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Parameter INVOCATION = "Queue";

Method UpdateLastID(pRequest As IRIS1.msg.ULIDM, Output pResponse As Ens.Response) As %Status
{
   
    set query = "UPDATE SQLUser.IDC SET LastID = "_pRequest.LastID_" WHERE ID = "_pRequest.ID
    set st = ..Adapter.ExecuteQuery(.tResult, query)
    $$$TRACE("st = "_st)

    Quit $$$OK
}

XData MessageMap
{
<MapItems>
    <MapItem MessageType="IRIS1.msg.ULIDM">
        <Method>UpdateLastID</Method>
    </MapItem>
</MapItems>
}

}
