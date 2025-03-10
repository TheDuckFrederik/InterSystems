Class test0305.bo.SelectPathFile Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.File.OutboundAdapter";

Parameter INVOCACION = "Queue";

Method SelectFile(pRequest As test0305.msg.SelectFileRequest, Output pResponse As test0305.msg.SelectFileResponse)
{
        set tData = "Patient ID: "_pRequest.PatientID_$CHAR(13,10)_
            "First Name: "_pRequest.FirstName_$CHAR(13,10)_
            "Middle Name: "_pRequest.MiddleName_$CHAR(13,10)_
            "Last Name: "_pRequest.LastName_$CHAR(13,10)_
            "Birth Date: "_pRequest.BirthDate_$CHAR(13,10)_
            "DNI: "_pRequest.DNI_$CHAR(13,10)_
            "Allergies: "_pRequest.Allergies_$CHAR(13,10)
        set sc = ..Adapter.PutString(pRequest.FileName, tData)
        $$$TRACE("st = "_$system.Status.DisplayError(sc))

        set pResponse = ##class(test0305.msg.SelectFileResponse).%New()
        set pResponse.PatientID=pRequest.PatientID
        set pResponse.FirstName=pRequest.FirstName
        set pResponse.MiddleName=pRequest.MiddleName
        set pResponse.LastName=pRequest.LastName
        set pResponse.BirthDate=pRequest.BirthDate
        set pResponse.DNI=pRequest.DNI
        set pResponse.Allergies=pRequest.Allergies

        Quit $$$OK
}

XData MessageMap
{
<MapItems>
        <MapItem MessageType="test0305.msg.SelectFileRequest">
            <Method>SelectFile</Method>
        </MapItem>
    </MapItems>
}

}
