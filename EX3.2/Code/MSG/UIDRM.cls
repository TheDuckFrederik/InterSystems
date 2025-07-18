Class EX32.MSG.UIDRM Extends Ens.Request
{

Property ID1 As %Integer;

Property FirstRangeID As %Integer;

Property ID2 As %Integer;

Property LastRangeID As %Integer;

Storage Default
{
<Data name="UIDRMDefaultData">
<Subscript>"UIDRM"</Subscript>
<Value name="1">
<Value>ID1</Value>
</Value>
<Value name="2">
<Value>FirstRangeID</Value>
</Value>
<Value name="3">
<Value>ID2</Value>
</Value>
<Value name="4">
<Value>LastRangeID</Value>
</Value>
</Data>
<DefaultData>UIDRMDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
