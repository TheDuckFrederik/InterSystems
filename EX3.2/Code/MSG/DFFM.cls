Class EX32.MSG.DDFM Extends Ens.Request
{

Property FirstName As %String;

Property MiddleName As %String;

Property LastName As %String;

Property SSN As %String;

Property hHospitalName As %String;

Property sSpecialty As %String;

Property prProfessionalName As %String;

Property atAppointmentType As %String;

Property icInsuranceCompany As %String;

Property aReason As %String(MAXLEN = 5000);

Property aAppointmentDate As %String;

Property aAppointmentTime As %String;

Property FileName As %String;

Storage Default
{
<Data name="DDFMDefaultData">
<Subscript>"DDFM"</Subscript>
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
<Value>SSN</Value>
</Value>
<Value name="5">
<Value>hHospitalName</Value>
</Value>
<Value name="6">
<Value>sSpecialty</Value>
</Value>
<Value name="7">
<Value>prProfessionalName</Value>
</Value>
<Value name="8">
<Value>atAppointmentType</Value>
</Value>
<Value name="9">
<Value>icInsuranceCompany</Value>
</Value>
<Value name="10">
<Value>aReason</Value>
</Value>
<Value name="11">
<Value>aAppointmentDate</Value>
</Value>
<Value name="12">
<Value>aAppointmentTime</Value>
</Value>
<Value name="13">
<Value>FileName</Value>
</Value>
</Data>
<DefaultData>DDFMDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
