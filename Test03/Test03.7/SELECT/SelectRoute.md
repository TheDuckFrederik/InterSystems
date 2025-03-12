# Documentation: Applying SOLID Principles to InterSystems ObjectScript REST API

## 1. Introduction

This document explains the differences between the original code and the refactored version, highlighting how **SOLID principles** were applied. Additionally, it provides an overview of each method's purpose in the final implementation.

---

## 2. Differences Between the Original and Refactored Code

### **Original Code Issues**

```objectscript
ClassMethod SelectPath(PatientID As %Integer, CreateFile As %Boolean) As %Status
{
    set tSC = $$$OK
    try {
        set tSC = ##class(Ens.Director).CreateBusinessService("SelectPathService", .tService)
        $$$ThrowOnError(tSC)

        set request = ##class(test0305.msg.SelectProcessRequest).%New()
        set request.PatientID = PatientID
        set request.CreateFile = CreateFile
        set tSC = tService.ProcessInput(request, .output)
        $$$ThrowOnError(tSC)

        do %response.SetHeader("ContentType", "application/json")
        set output = {}
        set output.PatientID = request.PatientID
        set output.CreateFile = request.CreateFile
        write output.%ToJSON()
    }
    catch ex {
        set tSC = ex.AsStatus()
    }
    return tSC
}
```

- **Single Responsibility Violation (SRP)**: The `SelectPath` method handled both HTTP request processing and business logic.
- **Tightly Coupled Logic**: The business logic and API response handling were mixed together.
- **Difficult to Extend (OCP Violation)**: If new business logic was required, the core REST API class would need modifications.
- **Error Handling Not Modular**: Try-catch logic was mixed with processing logic.

### **Refactored Code Improvements**

```objectscript
ClassMethod HandleRequest(PatientID As %Integer, CreateFile As %Boolean) As %Status
{
    set tSC = $$$OK
    try {
        set tSC = ..ProcessRequest(PatientID, CreateFile, .responseJSON)
        $$$ThrowOnError(tSC)

        do %response.SetHeader("ContentType", "application/json")
        write responseJSON
    }
    catch ex {
        set tSC = ex.AsStatus()
    }
    return tSC
}

ClassMethod ProcessRequest(PatientID As %Integer, CreateFile As %Boolean, Output responseJSON As %String) As %Status
{
    set tSC = $$$OK
    try {
        set tSC = ##class(Ens.Director).CreateBusinessService("SelectPathService", .tService)
        $$$ThrowOnError(tSC)

        set request = ##class(test0305.msg.SelectProcessRequest).%New()
        set request.PatientID = PatientID
        set request.CreateFile = CreateFile
        set tSC = tService.ProcessInput(request, .output)
        $$$ThrowOnError(tSC)

        set responseObj = {}
        set responseObj.PatientID = request.PatientID
        set responseObj.CreateFile = request.CreateFile
        set responseJSON = responseObj.%ToJSON()
    }
    catch ex {
        set tSC = ex.AsStatus()
    }
    return tSC
}
```

- **Separation of Concerns (SRP Applied)**:
    - `HandleRequest`: Manages HTTP interactions only.
    - `ProcessRequest`: Handles business logic separately.
- **Open/Closed Principle (OCP Applied)**:
    - The `ProcessRequest` method is now **self-contained**, making it easier to extend without modifying `HandleRequest`.
- **Dependency Inversion Principle (DIP Applied)**:
    - The REST API does not directly handle business logic; instead, it delegates processing to `ProcessRequest`.
- **Better Readability & Maintainability**:
    - Clear separation of responsibilities improves **code structure** and **future scalability**.

---

## 3. Explanation of the Refactored Code

### **Class: `test0305.RestDispTest0305`**

This class handles the REST API request and business logic separately while maintaining all functionality within a single class.

### **Methods and Their Purpose**

#### **1. `HandleRequest(PatientID, CreateFile) → %Status`**

```objectscript
ClassMethod HandleRequest(PatientID As %Integer, CreateFile As %Boolean) As %Status
{
    set tSC = $$$OK
    try {
        set tSC = ..ProcessRequest(PatientID, CreateFile, .responseJSON)
        $$$ThrowOnError(tSC)

        do %response.SetHeader("ContentType", "application/json")
        write responseJSON
    }
    catch ex {
        set tSC = ex.AsStatus()
    }
    return tSC
}
```

- **Purpose**:
    - Manages incoming HTTP requests.
    - Delegates processing to `ProcessRequest`.
    - Sets response headers and returns the JSON response.
- **SOLID Principles Applied**:
    - **SRP**: It only handles the request, leaving business logic to another method.
    - **DIP**: It depends on an internal method instead of handling business logic itself.

#### **2. `ProcessRequest(PatientID, CreateFile, Output responseJSON) → %Status`**

```objectscript
ClassMethod ProcessRequest(PatientID As %Integer, CreateFile As %Boolean, Output responseJSON As %String) As %Status
{
    set tSC = $$$OK
    try {
        set tSC = ##class(Ens.Director).CreateBusinessService("SelectPathService", .tService)
        $$$ThrowOnError(tSC)

        set request = ##class(test0305.msg.SelectProcessRequest).%New()
        set request.PatientID = PatientID
        set request.CreateFile = CreateFile
        set tSC = tService.ProcessInput(request, .output)
        $$$ThrowOnError(tSC)

        set responseObj = {}
        set responseObj.PatientID = request.PatientID
        set responseObj.CreateFile = request.CreateFile
        set responseJSON = responseObj.%ToJSON()
    }
    catch ex {
        set tSC = ex.AsStatus()
    }
    return tSC
}
```

- **Purpose**:
    - Handles business logic separately from the REST API method.
    - Calls `SelectPathService` to process the request.
    - Converts the response into JSON format.
- **SOLID Principles Applied**:
    - **SRP**: Only focuses on request processing.
    - **OCP**: If business logic changes, modifications are made here without affecting the REST API structure.

---

## 4. Conclusion

The refactored code follows SOLID principles while ensuring all logic remains inside a single class. This improves **maintainability, extensibility, and separation of concerns**, making the code easier to understand and modify.

## 5. Test 01 Integration

```
[User-provided Test 01 documentation inserted here]
```

Would you like further refinements or explanations? 😊