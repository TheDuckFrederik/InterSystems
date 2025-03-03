Class code.msg.PatientDataDBRequest Extends Ens.Request
{

Property PatientDataID As %Integer;

Property FirstName As %String;

Property MiddleName As %String;

Property LastName As %String;

Property Age As %Integer;

Property Allergies As %String;

Storage Default
{
<Data name="PatientDataDBRequestDefaultData">
<Subscript>"PatientDataDBRequest"</Subscript>
<Value name="1">
<Value>PatientDataID</Value>
</Value>
<Value name="2">
<Value>FirstName</Value>
</Value>
<Value name="3">
<Value>MiddleName</Value>
</Value>
<Value name="4">
<Value>LastName</Value>
</Value>
<Value name="5">
<Value>Age</Value>
</Value>
<Value name="6">
<Value>Allergies</Value>
</Value>
<Value name="7">
<Value>FileName</Value>
</Value>
</Data>
<DefaultData>PatientDataDBRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
