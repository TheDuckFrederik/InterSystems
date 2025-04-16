Class HL7Prod.msg.ProcessToOperationInsert Extends Ens.Request
{

Property HL7Message As %String(MAXLEN = 5000);

Storage Default
{
<Data name="ProcessToOperationInsertDefaultData">
<Subscript>"ProcessToOperationInsert"</Subscript>
<Value name="1">
<Value>HL7Message</Value>
</Value>
</Data>
<DefaultData>ProcessToOperationInsertDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
