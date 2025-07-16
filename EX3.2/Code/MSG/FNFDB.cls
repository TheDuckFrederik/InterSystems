Class EX32.MSG.FNFDB Extends Ens.Response
{

Property FileName As %String;

Storage Default
{
<Data name="FNFDBDefaultData">
<Subscript>"FNFDB"</Subscript>
<Value name="1">
<Value>FileName</Value>
</Value>
</Data>
<DefaultData>FNFDBDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
