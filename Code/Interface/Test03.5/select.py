import streamlit as st
import requests
#
def make_get_request(patient_id, create_file):
    url = f"http://localhost:52773/csp/test0305/selectpath/{patient_id}/{create_file}"
    #
    try:
        response = requests.get(url)
        #
        if response.status_code == 200:
            return response.json()
        else:
            return {"error": f"Error: Received status code {response.status_code}"}
    #
    except requests.exceptions.RequestException as e:
        return {"error": f"Error: {e}"}
#
def main():
    st.title("Patient Data Select")
    #
    patient_id = st.number_input("Enter PatientID:", min_value=1, step=1)
    create_file = st.number_input("Enter CreateFile value:", min_value=0, max_value=1, step=1)
    #
    if st.button("Submit"):
        result = make_get_request(patient_id, create_file)
        #
        if "error" in result:
            st.error(result["error"])
        else:
            st.success("Request successful!")
            st.json(result)
#
if __name__ == "__main__":
    main()

