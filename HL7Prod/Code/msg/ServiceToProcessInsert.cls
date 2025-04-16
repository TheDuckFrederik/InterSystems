Class HL7Prod.msg.ServiceToProcessInsert Extends Ens.Request
{

Property HL7Message As %String(MAXLEN = 5000);

Storage Default
{
<Data name="ServiceToProcessInsertDefaultData">
<Subscript>"ServiceToProcessInsert"</Subscript>
<Value name="1">
<Value>HL7Message</Value>
</Value>
</Data>
<DefaultData>ServiceToProcessInsertDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
