Class TestProds.TestProd01.MSG.RPIM Extends Ens.Request
{

Property PID As %Integer;

Storage Default
{
<Data name="RPIMDefaultData">
<Subscript>"RPIM"</Subscript>
<Value name="1">
<Value>PID</Value>
</Value>
</Data>
<DefaultData>RPIMDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
