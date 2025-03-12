# Applying SOLID Principles to C# Code

## Introduction

This document provides a step-by-step guide on how to refactor a C# codebase to adhere to the SOLID principles. The refactoring aims to make the code more maintainable, scalable, and testable.

## Before Applying SOLID Principles

The original code (before applying SOLID principles) was structured in a way that had a large method handling multiple responsibilities. The `SelectPath` method handled:

1. Creating a business service.

2. Initializing a request object.

3. Processing the request.

4. Formatting the response.

5. Handling errors.

This violated the **Single Responsibility Principle (SRP)** as it mixed multiple concerns in one method.

### **Original Code**

```
Class test0305.RestDispTest0305 Extends %CSP.REST
{
    XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
    {
        <Routes>
            <Route Url="/hospital/:PatientID/:CreateFile" Method="GET" Call="SelectPath" Cors="true"/>
        </Routes>
    }

    ClassMethod SelectPath(PatientID As %Integer, CreateFile As %Boolean) As %Status
    {
        set tSC = $$$OK
        try {
            set tSC = ##class(Ens.Director).CreateBusinessService("SelectPathService",.tService)
            $$$ThrowOnError(tSC)

            set request = ##class(test0305.msg.SelectProcessRequest).%New()
            set request.PatientID = PatientID
            set request.CreateFile = CreateFile
            set tSC = tService.ProcessInput(request, .output)
            $$$ThrowOnError(tSC)

            do %response.SetHeader("ContentType", "application/json")
            
            #Dim output As %Library.DynamicObject
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
}
```

## After Applying SOLID Principles

The refactored code introduces **separation of concerns** by splitting responsibilities into different methods. The improvements include:

1. **SRP (Single Responsibility Principle)**: The logic for processing the request was moved to a separate method `ProcessRequest`, making `HandleRequest` cleaner.
    
2. **OCP (Open/Closed Principle)**: The new structure allows for easier extension by making it possible to introduce new processing logic without modifying `HandleRequest`.
    
3. **LSP (Liskov Substitution Principle)**: The new design ensures that derived classes can override methods without breaking functionality.
    
4. **ISP (Interface Segregation Principle)**: Although not fully implemented, the design allows different classes to focus on distinct operations.
    
5. **DIP (Dependency Inversion Principle)**: The `ProcessRequest` method now takes dependencies as parameters, making it easier to inject different services.
    

### **Refactored Code**

```
Class test0307.RestDispTest0307 Extends %CSP.REST
{
    XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
    {
        <Routes>
            <Route Url="/hospital/:PatientID/:CreateFile" Method="GET" Call="HandleRequest" Cors="true"/>
        </Routes>
    }

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
}
```

## **Step-by-Step Breakdown of SOLID Principles Applied**

### **1. Single Responsibility Principle (SRP)**

**Before:**

```
ClassMethod SelectPath(PatientID As %Integer, CreateFile As %Boolean) As %Status
```

Handled both request handling and business logic.

**After:**

```
ClassMethod HandleRequest(PatientID As %Integer, CreateFile As %Boolean) As %Status
ClassMethod ProcessRequest(PatientID As %Integer, CreateFile As %Boolean, Output responseJSON As %String) As %Status
```

Responsibilities are now clearly separated.

### **2. Open/Closed Principle (OCP)**

**Before:**

```
ClassMethod SelectPath(PatientID As %Integer, CreateFile As %Boolean) As %Status
```

Directly handled processing logic.

**After:**

```
ClassMethod ProcessRequest(PatientID As %Integer, CreateFile As %Boolean, Output responseJSON As %String) As %Status
```

Now, new behaviors can be added without modifying `HandleRequest`.

### **3. Liskov Substitution Principle (LSP)**

The `ProcessRequest` method allows overriding in a subclass without breaking `HandleRequest`.

### **4. Interface Segregation Principle (ISP)**

The new structure allows for modular interface design in future expansions.

### **5. Dependency Inversion Principle (DIP)**

**Before:**

```
set tSC = ##class(Ens.Director).CreateBusinessService("SelectPathService",.tService)
```

**After:**

```
ClassMethod ProcessRequest(PatientID As %Integer, CreateFile As %Boolean, Output responseJSON As %String) As %Status
```

Decouples the business service instantiation from request handling.