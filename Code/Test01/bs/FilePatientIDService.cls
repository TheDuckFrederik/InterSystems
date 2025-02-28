Class code.bs.FilePatientIDService Extends Ens.BusinessService
{

Parameter ADAPTER = "EnsLib.File.InboundAdapter";

Method OnProcessInput(pRequest As %Stream.Object, Output pResponse As %RegisteredObject) As %Status
{
            set tLine = pRequest.ReadLine()
            $$$TRACE("tLine = "_tLine)
            set tRequest = ##class(code.msg.ProcessRequest).%New()
            $$$TRACE("Created request.")
            set tRequest.PatientID = $piece(tLine,":",1)
            $$$TRACE("PatientID = "_ tRequest.PatientID)
            set st = ..SendRequestAsync("PatientInfoProcess",tRequest)
            ///
            Quit $$$OK
}

}
