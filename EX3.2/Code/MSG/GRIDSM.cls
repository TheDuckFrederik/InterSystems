Class EX32.MSG.GRIDSM Extends Ens.Response
{

Property FirstRangeID As %Integer;

Property LastRangeID As %Integer;

Storage Default
{
<Data name="GRIDSMDefaultData">
<Subscript>"GRIDSM"</Subscript>
<Value name="1">
<Value>FirstRangeID</Value>
</Value>
<Value name="2">
<Value>LastRangeID</Value>
</Value>
</Data>
<DefaultData>GRIDSMDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
