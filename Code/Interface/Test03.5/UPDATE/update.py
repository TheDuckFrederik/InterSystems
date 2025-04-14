import streamlit as st
import requests

def make_post_request(patient_id, first_name, middle_name, last_name1, last_name2, birth_date, dni, allergies, create_file):
    url = f"http://localhost:52773/csp/test0305/updatepath/{patient_id}/{first_name}/{middle_name}/{last_name1}/{last_name2}/{birth_date}/{dni}/{allergies}/{create_file}"
    data = {
        "patient_id": patient_id,
        "first_name": first_name,
        "middle_name": middle_name,
        "last_name1": last_name1,
        "last_name2": last_name2,
        "birth_date": birth_date,
        "dni": dni,
        "allergies": allergies,
        "create_file": create_file
    }
    
    try:
        response = requests.post(url, json=data)
        
        if response.status_code == 200:
            return response.json()
        else:
            return {"error": f"Error: Received status code {response.status_code}"}
    
    except requests.exceptions.RequestException as e:
        return {"error": f"Error: {e}"}

def main():
    st.title("Patient Data Update")
    #
    patient_id = st.number_input("Enter Patient ID:", min_value=1, step=1)
    first_name = st.text_input("Enter First Name:")
    middle_name = st.text_input("Enter Middle Name:")
    last_name1 = st.text_input("Enter Last Name 1:")
    last_name2 = st.text_input("Enter Last Name 2:")
    birth_date = st.text_input("Enter Birth Date (YYYY-MM-DD):")
    dni = st.text_input("Enter DNI:")
    allergies = st.text_input("Enter Allergies:")
    create_file = st.number_input("Enter CreateFile value (0 or 1):", min_value=0, max_value=1, step=1)
    #
    if st.button("Submit"):
        result = make_post_request(patient_id, first_name, middle_name, last_name1, last_name2, birth_date, dni, allergies, create_file)
        #
        if "error" in result:
            st.error(result["error"])
        else:
            st.success("Request successful!")
            st.json(result)
#
if __name__ == "__main__":
    main()
