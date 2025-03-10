Class test0305.msg.SelectDBRequest Extends Ens.Request
{

Property PatientID As %Integer;

Property CreateFile As %Boolean;

Storage Default
{
<Data name="SelectDBRequestDefaultData">
<Subscript>"SelectDBRequest"</Subscript>
<Value name="1">
<Value>PatientID</Value>
</Value>
<Value name="2">
<Value>CreateFile</Value>
</Value>
</Data>
<DefaultData>SelectDBRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
