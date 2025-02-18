Class test.msg.PatientDBRequest Extends Ens.Request
{

Property PatientID As %Integer;

Storage Default
{
<Data name="PatientDBRequestDefaultData">
<Subscript>"PatientDBRequest"</Subscript>
<Value name="1">
<Value>PatientID</Value>
</Value>
</Data>
<DefaultData>PatientDBRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
