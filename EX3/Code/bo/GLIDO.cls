Class IRIS1.bo.GLIDO Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Parameter INVOCATION = "Queue";

Method GetID(pRequest As IRIS1.msg.NFQM, Output pResponse As IRIS1.msg.GLIDM) As %Status
{
    set pResponse = ##class(IRIS1.msg.GLIDM).%New()
    
    set query = "SELECT LastID from SQLUser.IDC where ID = "_pRequest.ID
    set st = ..Adapter.ExecuteQuery(.tResult, query)
    $$$TRACE("st = "_st)
    do tResult.Next()

    set pResponse.LastID=tResult.Get("LastID")

    Quit $$$OK
}

XData MessageMap
{
<MapItems>
    <MapItem MessageType="IRIS1.msg.NFQM">
        <Method>GetID</Method>
    </MapItem>
</MapItems>
}

}
