import streamlit as st
import requests

def make_delete_request(patient_id):
    url = f"http://localhost:52773/csp/test0305/deletepath/{patient_id}"
    
    try:
        response = requests.delete(url)
        
        if response.status_code == 200:
            return response.json()
        else:
            return {"error": f"Error: Received status code {response.status_code}"}

    except requests.exceptions.RequestException as e:
        return {"error": f"Error: {e}"}

def main():
    st.title("Patient Data Deletion")

    patient_id = st.number_input("Enter PatientID:", min_value=1, step=1)

    if st.button("Delete"):
        result = make_delete_request(patient_id)
        
        if "error" in result:
            st.error(result["error"])
        else:
            st.success("Deletion successful!")
            st.json(result)

if __name__ == "__main__":
    main()
