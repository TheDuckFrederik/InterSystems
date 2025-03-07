Class code.msg.ProcessOperationRequest Extends Ens.Request
{

Property PatientID As %Integer;

Storage Default
{
<Data name="ProcessOperationRequestDefaultData">
<Subscript>"ProcessOperationRequest"</Subscript>
<Value name="1">
<Value>PatientID</Value>
</Value>
</Data>
<DefaultData>ProcessOperationRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
