"""
The logic works such middleware has a common schema for all the databases.
it wil ask for the mappings thtough these mapping logics and then it will
fetch the tables of the records. 

        The mediated schema is as follows:
        Doctors : {
            "d_id" : int,
            "d_name" : str,
            "phone" : str,
            "email" : str,
            "address" : str,
            "speciality" : str [NULL],
            "experience" : int [NULL],
            "education" : str [NULL],   
            "fee" : int,
            "h_id" : int
        }

        Hospital : {
            "h_id" : int,
            "name" : str,
            "phone" : str,
            "email" : str,
            "address" : str,
            "pincode" : int,
            "beds" : int,
            "rating" : int
        }

        Tests : {
            "t_id" : int,
            "name" : str,
            "description" : str,
            "price" : int,
            "h_id" : int
        }

        Appointments : {
            "a_id" : int,
            "d_id" : int,
            "date" : str,
            "time" : str,
            "status" : str
        }
"""
master_mapping_from_global_to_local = {
    "Doctors": {
        "DID": "d_id",
        "Name": "d_name",
        "Contact_Number": "phone",
        "Email": "email",
        "Specialization": "speciality",
        "Education": "education",
    },
    "Hospital": {
        "HID": "h_id",
        "Name": "name",
        "street": "address",
        "state": "address",
        "cuntry": "address",
        "pincode": "address"
    },
    "Tests": {
        "TID": "t_id",
        "Name": "name",
        "Description": "description",
    },
    "Appointment_test": {
        "ATID": "at_id",
        "TID": "d_id",
        "HID": "h_id",
        "Date": "date",
        "Time": "time",
        "Price": "price",
    },
    "Appointment_doctor": {
        "ADID": "ad_id",
        "TID": "t_id",
        "HID": "h_id",
        "Date": "date",
        "Time": "time",
        "Price": "price",
    }
}


master_mapping_from_local_to_global = {
    "Doctors": {
        "d_id": "DID",
        "d_name": "Name",
        "phone": "Contact_Number",
        "email": "Email",
        "speciality": "Specialization",
        "education": "Education",
    },
    "Hospital": {
        "h_id": "HID",
        "name": "Name",
        "address": ["street", "state", "cuntry", "pincode"]
    },
    "Tests": {
        "t_id": "TID",
        "name": "Name",
        "description": "Description",
    },
    "Appointment_test": {
        "at_id": "ATID",
        "d_id": "TID",
        "h_id": "HID",
        "date": "Date",
        "time": "Time",
        "price": "Price",
    },
    "Appointment_doctor": {
        "ad_id": "ADID",
        "t_id": "TID",
        "h_id": "HID",
        "date": "Date",
        "time": "Time",
        "price": "Price",
    }
}

schema = {
    "Doctors": ["Doctor ID", "Name", "Speciality", "Phone", "Email", "Experience_years", "Qualifications"],
    "Hospitals": ["Hospital ID", "Name", "Speciality", "Location", "Contact"],
    "Doctor_Hospitals": ["DH ID", "Doctor ID", "Hospital ID", "Available_day", "Available_time"],
    "Tests": ["Test ID", "Name", "Description", "Cost"],
    "Hospital_Tests": ["HT ID", "Hospital ID", "Test ID"]
}


# Transaction: from local schema to mediated schema


