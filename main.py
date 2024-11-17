import jellyfish
import requests

hospital_column_synonyms = {
    "h_name": ["hospital_name", "facility_name", "clinic_name", "healthcare_name", "name", "h_name"],
    "email": ["email_address", "contact_email", "email_id", "mail", "email"],
    "address": ["location", "hospital_address", "clinic_address", "street_address", "address", "addr"],
    "speciality": ["specialization", "department", "area_of_expertise", "medical_field", "speciality"]
}

doctor_column_synonyms = {
    "d_name": ["doctor_name", "physician_name", "name", "medical_practitioner", "d_name"],
    "phone": ["contact_number", "mobile", "telephone", "phone_number", "phone"],
    "email": ["email_address", "contact_email", "email_id", "mail", "email"],
    "address": ["location", "clinic_address", "residential_address", "street_address", "address", "addr"],
    "speciality": ["specialization", "expertise", "field_of_practice", "medical_field", "speciality"],
    "experience": ["years_of_experience", "work_experience", "practice_years", "career_duration", "experience", "exp", "yoe"],
    "education": ["qualification", "degree", "certification", "academic_background", "education"],
}

test_table_synonyms = {
    "t_name": ["test_name", "diagnostic_name", "procedure_name", "medical_test", "t_name", "name"],
    "description": ["details", "test_details", "information", "procedure_description", "description"],
    "cost": ["price", "fee", "test_cost", "charge","cost"]
}

appointment_doctor_synonyms = {
    "price": ["cost", "fee", "consultation_charge", "appointment_fee", "price"],
    "time": ["appointment_time", "scheduled_time", "time_slot", "consultation_time", "time"],
    "date": ["appointment_date", "scheduled_date", "consultation_date", "visit_date", "date"],
    "status": ["appointment_status", "confirmation_status", "booking_status", "state", "status"]
}

appointment_test_synonyms = {
    "time": ["test_time", "scheduled_time", "time_slot", "procedure_time", "time"],
    "date": ["test_date", "scheduled_date", "procedure_date", "diagnostic_date", "date"],
    "status": ["test_status", "confirmation_status", "booking_status", "state", "status"]
}


def merge_address(response):
    if response.status_code == 200:
        # Step 2: Parse JSON data
        data = response.json()

        # Step 3: Process each entry
        for item in data:
            address = item.get("Address", {})
            merged_address = f"{address.get('Street', '')}, {address.get('State', '')}, {address.get('Country', '')} - {address.get('Pincode', '')}"
            item['Address'] = merged_address

        return data

    else:
        print(f"Failed to fetch data. Status code: {response.status_code}")

def map_api_to_warehouse(warehouse_dict, api_cols, threshold):
    mapping = {}

    for api_col in api_cols:
        best_match = None
        best_score = 0

        for warehouse_col, synonyms in warehouse_dict.items():
            for synonym in synonyms:
                score = jellyfish.jaro_similarity(api_col, synonym)
                if score > best_score and score >= threshold:
                    best_match = warehouse_col
                    best_score = score

        if best_match:
            mapping[api_col] = best_match

    return mapping



def return_col_mapping_db_satwik():
    # Hospital Table
    api_url_satwik_hospital = "http://127.0.0.1:5000/api/hospitals"  # Replace with the actual API URL
    response = requests.get(api_url_satwik_hospital)
    data = merge_address(response)
    api_cols_hospital = []
    for i in data[0]:
        api_cols_hospital.append(i)
    hospital_col_mapping = map_api_to_warehouse(hospital_column_synonyms, api_cols_hospital, 0.8)
    # print(hospital_col_mapping)

    # Doctor table
    api_url_satwik_doctor = "http://127.0.0.1:5000/api/doctors"
    response = requests.get(api_url_satwik_doctor)
    data = response.json()
    api_cols_doctor = []
    for i in data[0]:
        api_cols_doctor.append(i)
    doctor_col_mapping = map_api_to_warehouse(doctor_column_synonyms, api_cols_doctor, 0.8)
    # print(doctor_col_mapping)

    # Test table
    api_url_satwik_test = "http://127.0.0.1:5000/api/tests"
    response = requests.get(api_url_satwik_test)
    data = response.json()
    api_cols_test = []
    for i in data[0]:
        api_cols_test.append(i)
    test_col_mapping = map_api_to_warehouse(test_table_synonyms, api_cols_test, 0.8)
    # print(test_col_mapping)

    #     Appointment doctor
    api_url_satwik_hospital = "http://127.0.0.1:5000/api/doctors"
    response = requests.get(api_url_satwik_hospital)
    data = response.json()
    api_cols_appointment_doctor = []
    for i in data[0]['Hospitals'][0]['AppointmentDetails']:
        api_cols_appointment_doctor.append(i)

    appointment_doctor_col_mapping = map_api_to_warehouse(appointment_doctor_synonyms, api_cols_appointment_doctor, 0.8)
    # print(appointment_doctor_col_mapping)

    #   Appointment test
    api_url_satwik_test = "http://127.0.0.1:5000/api/tests"
    response = requests.get(api_url_satwik_test)
    data = response.json()
    api_cols_appointment_test = []
    for i in data[0]['AppointmentDetails']:
        api_cols_appointment_test.append(i)
    api_cols_appointment_test.append("Price")
    appointment_test_col_mapping = map_api_to_warehouse(appointment_test_synonyms, api_cols_appointment_test, 0.8)
    # print(appointment_test_col_mapping)

    return hospital_col_mapping, doctor_col_mapping, test_col_mapping, appointment_doctor_col_mapping, appointment_test_col_mapping




def call_db_satwik():
    hospital_col_mapping, doctor_col_mapping, test_col_mapping, appointment_doctor_col_mapping, appointment_test_col_mapping = return_col_mapping_db_satwik()
    print(hospital_col_mapping)
    print(doctor_col_mapping)
    print(test_col_mapping)
    print(appointment_doctor_col_mapping)
    print(appointment_test_col_mapping)



if __name__ == "__main__":
    call_db_satwik()







