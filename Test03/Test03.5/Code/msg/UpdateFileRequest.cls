Class test0305.msg.UpdateFileRequest Extends Ens.Request
{

Property PatientID As %Integer;

Property FirstName As %String;

Property MiddleName As %String;

Property LastName1 As %String;

Property LastName2 As %String;

Property LastName As %String;

Property BirthDate As %String;

Property DNI As %String;

Property Allergies As %String;

Property FileName As %String;

Storage Default
{
<Data name="UpdateFileRequestDefaultData">
<Subscript>"UpdateFileRequest"</Subscript>
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
<Value>LastName1</Value>
</Value>
<Value name="5">
<Value>LastName2</Value>
</Value>
<Value name="6">
<Value>LastName</Value>
</Value>
<Value name="7">
<Value>BirthDate</Value>
</Value>
<Value name="8">
<Value>DNI</Value>
</Value>
<Value name="9">
<Value>Allergies</Value>
</Value>
<Value name="10">
<Value>FileName</Value>
</Value>
</Data>
<DefaultData>UpdateFileRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
