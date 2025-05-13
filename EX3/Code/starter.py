import streamlit as st
import requests
import time
#
while True:
    def starter_request(num):
        url = f"http://localhost:52773/csp/IRIS1/start/{num}"
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
        st.title("Start Production")
        #
        num = st.number_input("Enter PatientID:", min_value=1, max_value=1, step=1)
        #
        if st.button("Submit"):
            result = starter_request(num)
            #
            if "error" in result:
                st.error(result["error"])
            else:
                st.success("Request successful!")
                st.json(result)
    #
    if __name__ == "__main__":
        main()
    #
    time.sleep(3600)
# streamlit run C:\Users\unai.ovejero.ext\Documents\InterSystems\InterSystems\EX3\Code\starter.py