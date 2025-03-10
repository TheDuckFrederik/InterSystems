Class test0305.msg.SelectFileResponse Extends Ens.Response
{

Property PatientID As %Integer;

Property FirstName As %String;

Property MiddleName As %String;

Property LastName As %String;

Property BirthDate As %String;

Property DNI As %String;

Property Allergies As %String;

Storage Default
{
<Data name="SelectFileResponseDefaultData">
<Subscript>"SelectFileResponse"</Subscript>
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
</Data>
<DefaultData>SelectFileResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
