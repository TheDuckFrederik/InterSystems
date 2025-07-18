Class EX32.MSG.NFRM Extends Ens.Request
{

Property ID1 As %Integer;

Property ID2 As %Integer;

Storage Default
{
<Data name="NFRMDefaultData">
<Subscript>"NFRM"</Subscript>
<Value name="1">
<Value>ID1</Value>
</Value>
<Value name="2">
<Value>ID2</Value>
</Value>
</Data>
<DefaultData>NFRMDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
