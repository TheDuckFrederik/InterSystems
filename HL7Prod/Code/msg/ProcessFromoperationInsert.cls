Class HL7Prod.msg.ProcessFromOperationInsert Extends Ens.Response
{

Property HL7Message As %String(MAXLEN = 5000);

Storage Default
{
<Data name="ProcessFromOperationInsertDefaultData">
<Subscript>"ProcessFromOperationInsert"</Subscript>
<Value name="1">
<Value>HL7Message</Value>
</Value>
</Data>
<DefaultData>ProcessFromOperationInsertDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
