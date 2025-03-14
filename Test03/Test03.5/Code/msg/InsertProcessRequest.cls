Class test0305.msg.InsertProcessRequest Extends Ens.Request
{

Property PatientID As %Integer;

Property FirstName As %String;

Property MiddleName As %String;

Property LastName1 As %String;

Property LastName2 As %String;

Property BirthDate As %String;

Property DNI As %String;

Property Allergies As %String;

Property CreateFile As %Boolean;

Storage Default
{
<Data name="InsertProcessRequestDefaultData">
<Subscript>"InsertProcessRequest"</Subscript>
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
<Value>BirthDate</Value>
</Value>
<Value name="7">
<Value>DNI</Value>
</Value>
<Value name="8">
<Value>Allergies</Value>
</Value>
<Value name="9">
<Value>CreateFile</Value>
</Value>
</Data>
<DefaultData>InsertProcessRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
