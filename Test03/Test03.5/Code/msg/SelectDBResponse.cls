Class test0305.msg.SelectDBResponse Extends Ens.Response
{

Property FirstName As %String;

Property MiddleName As %String;

Property LastName1 As %String;

Property LastName2 As %String;

Property BirthDate As %String;

Property DNI As %String;

Property Allergies As %String;

Storage Default
{
<Data name="SelectDBResponseDefaultData">
<Subscript>"SelectDBResponse"</Subscript>
<Value name="1">
<Value>FirstName</Value>
</Value>
<Value name="2">
<Value>MiddleName</Value>
</Value>
<Value name="3">
<Value>LastName1</Value>
</Value>
<Value name="4">
<Value>LastName2</Value>
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
<DefaultData>SelectDBResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
