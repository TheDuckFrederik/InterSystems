Class TestProds.TestProd01.MSG.GPIM Extends Ens.Response
{

Property PFirstName As %String;

Property PMiddleNane As %String;

Property PLastName As %String;

Property PBirthDate As %String;

Property PPhone As %String;

Property PEmail As %String;

Property PAdress As %String;

Property PResidenceCity As %String;

Property PResidenceRegion As %String;

Property PResidenceCountry As %String;

Property PostalZip As %String;

Storage Default
{
<Data name="GPIMDefaultData">
<Subscript>"GPIM"</Subscript>
<Value name="1">
<Value>PFirstName</Value>
</Value>
<Value name="2">
<Value>PMiddleNane</Value>
</Value>
<Value name="3">
<Value>PLastName</Value>
</Value>
<Value name="4">
<Value>PBirthDate</Value>
</Value>
<Value name="5">
<Value>PPhone</Value>
</Value>
<Value name="6">
<Value>PEmail</Value>
</Value>
<Value name="7">
<Value>PAdress</Value>
</Value>
<Value name="8">
<Value>PResidenceCity</Value>
</Value>
<Value name="9">
<Value>PResidenceRegion</Value>
</Value>
<Value name="10">
<Value>PResidenceCountry</Value>
</Value>
<Value name="11">
<Value>PostalZip</Value>
</Value>
</Data>
<DefaultData>GPIMDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
