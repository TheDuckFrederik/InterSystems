Class test0305.msg.SelectProcessRequest Extends Ens.Request
{

Property PatientID As %Integer;

// Property CreateFile As %Boolean;

Storage Default
{
<Data name="SelectProcessRequestDefaultData">
<Subscript>"SelectProcessRequest"</Subscript>
<Value name="1">
<Value>PatientID</Value>
</Value>
</Data>
<DefaultData>SelectProcessRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
