Class IRIS1.msg.ULIDM Extends Ens.Request
{

Property ID As %Integer;

Property LastID As %Integer;

Storage Default
{
<Data name="ULIDMDefaultData">
<Subscript>"ULIDM"</Subscript>
<Value name="1">
<Value>ID</Value>
</Value>
<Value name="2">
<Value>LastID</Value>
</Value>
</Data>
<DefaultData>ULIDMDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
