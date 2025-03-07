Class code.msg.ServiceProcessRequest Extends Ens.Request
{

Property PatientID As %Integer;

Property CreateFile As %Boolean;

Storage Default
{
<Data name="ServiceProcessRequestDefaultData">
<Subscript>"ServiceProcessRequest"</Subscript>
<Value name="1">
<Value>PatientID</Value>
</Value>
<Value name="2">
<Value>CreateFile</Value>
</Value>
</Data>
<DefaultData>ServiceProcessRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
