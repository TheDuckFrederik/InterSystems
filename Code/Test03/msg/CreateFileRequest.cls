Class code.msg.CreateFileRequest Extends Ens.Request
{

Property PatientID As %Integer;

Property FirstName As %String;

Property MiddleName As %String;

Property LastName As %String;

Property BirthDate As %String;

Property DNI As %String;

Property Allergies As %String;

Property FileName As %String;

Storage Default
{
<Data name="CreateFileRequestDefaultData">
<Subscript>"CreateFileRequest"</Subscript>
<Value name="1">
<Value>PatientID</Value>
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
<Value>BirthDate</Value>
</Value>
<Value name="6">
<Value>DNI</Value>
</Value>
<Value name="7">
<Value>Allergies</Value>
</Value>
<Value name="8">
<Value>FileName</Value>
</Value>
</Data>
<DefaultData>CreateFileRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
