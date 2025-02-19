Class test.msg.ProcessRequest Extends Ens.Request
{

Property PatientID As %Integer;

Storage Default
{
<Data name="ProcessRequestDefaultData">
<Subscript>"ProcessRequest"</Subscript>
<Value name="1">
<Value>PatientID</Value>
</Value>
</Data>
<DefaultData>ProcessRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
