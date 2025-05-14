Class IRIS1.msg.DFDBM Extends Ens.Response
{

Property ID As %Integer;

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

Storage Default
{
<Data name="DFDBMDefaultData">
<Subscript>"DFDBM"</Subscript>
<Value name="1">
<Value>ID</Value>
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
<Value>SSN</Value>
</Value>
<Value name="6">
<Value>hHospitalName</Value>
</Value>
<Value name="7">
<Value>sSpecialty</Value>
</Value>
<Value name="8">
<Value>prProfessionalName</Value>
</Value>
<Value name="9">
<Value>atAppointmentType</Value>
</Value>
<Value name="10">
<Value>icInsuranceCompany</Value>
</Value>
<Value name="11">
<Value>aReason</Value>
</Value>
<Value name="12">
<Value>aAppointmentDate</Value>
</Value>
<Value name="13">
<Value>aAppointmentTime</Value>
</Value>
</Data>
<DefaultData>DFDBMDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
