Class IRIS1.msg.DFFM Extends Ens.Request
{

Property ID As %Integer;

Property PatientID As %Integer;

Property HospitalID As %Integer;

Property SpecialtyID As %Integer;

Property ProfessionalID As %Integer;

Property AppointmentTypeID As %Integer;

Property InsuranceCompanyID As %Integer;

Property Reason As %String(MAXLEN = 5000);

Property AppointmentDate As %String;

Property AppointmentTime As %String;

Storage Default
{
<Data name="DFFMDefaultData">
<Subscript>"DFFM"</Subscript>
<Value name="1">
<Value>ID</Value>
</Value>
<Value name="2">
<Value>PatientID</Value>
</Value>
<Value name="3">
<Value>HospitalID</Value>
</Value>
<Value name="4">
<Value>SpecialtyID</Value>
</Value>
<Value name="5">
<Value>ProfessionalID</Value>
</Value>
<Value name="6">
<Value>AppointmentTypeID</Value>
</Value>
<Value name="7">
<Value>InsuranceCompanyID</Value>
</Value>
<Value name="8">
<Value>Reason</Value>
</Value>
<Value name="9">
<Value>AppointmentDate</Value>
</Value>
<Value name="10">
<Value>AppointmentTime</Value>
</Value>
</Data>
<DefaultData>DFFMDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
