Class test.msg.PatientDBResponse Extends Ens.Response
{

Property FirstName As %String;

Property MiddleName As %String;

Property LastName As %String;

Property Age As %Integer;

Property Allergies As %String;

Property OverAge As %Boolean;

Storage Default
{
<Data name="PatientDBResponseDefaultData">
<Subscript>"PatientDBResponse"</Subscript>
<Value name="1">
<Value>FirstName</Value>
</Value>
<Value name="2">
<Value>MiddleName</Value>
</Value>
<Value name="3">
<Value>LastName</Value>
</Value>
<Value name="4">
<Value>Age</Value>
</Value>
<Value name="5">
<Value>Allergies</Value>
</Value>
<Value name="6">
<Value>OverAge</Value>
</Value>
</Data>
<DefaultData>PatientDBResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
