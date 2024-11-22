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
            "h_id" : int,
            "sources" : lst
        }

        Hospital : {
            "h_id" : int,
            "name" : str,
            "phone" : str,
            "email" : str,
            "address" : str,
            "speciality" : str [NULL],
            "rating" : int
            "sources" : lst
        }

        Tests : {
            "t_id" : int,
            "name" : str,
            "description" : str,
            "h_id" : int,
            "sources" : lst
        }

        Appointment_test : {
            "at_id" : int,
            "d_id" : int,
            "h_id" : int,
            "date" : str,
            "time" : str,
            "price" : int,
            "status" : str
        }

        Appointment_doctor : {
            "ad_id" : int,
            "t_id" : int,
            "h_id" : int,
            "date" : str,
            "time" : str,
            "price" : int,
            "status" : str,
            "sources" : lst
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

local_schema = {
    "Doctors": [
        "DID",
        "Name",
        "Contact_Number",
        "Email",
        "Specialization",
        "Education",
    ],
    "Hospital": [
        "HID",
        "Name",
        "street",
        "state",
        "cuntry",
        "pincode",
    ],
    "Tests": [
        "TID",
        "Name",
        "Description",
    ],
    "Appointment_test": [
        "ATID",
        "TID",
        "HID",
        "Date",
        "Time",
        "Price",
    ],
    "Appointment_doctor": [
        "ADID",
        "TID",
        "HID",
        "Date",
        "Time",
        "Price",
    ]
}

global_schema = {
    "Doctors": [
        "d_id",
        "d_name",
        "phone",
        "email",
        "speciality",
        "education",
    ],
    "Hospital": [
        "h_id",
        "name",
        "address",
    ],
    "Tests": [
        "t_id",
        "name",
        "description",
    ],
    "Appointment_test": [
        "at_id",
        "d_id",
        "h_id",
        "date",
        "time",
        "price",
    ],
    "Appointment_doctor": [
        "ad_id",
        "t_id",
        "h_id",
        "date",
        "time",
        "price",
    ]
}

#Translation 1: local schema to mediated schema

def local_to_global(local_table, table_name):
    global_table = {}
    for local_row in local_table:
        global_row = {}
        for local_column in local_schema[table_name]:
            global_column = master_mapping_from_local_to_global[table_name][local_column]
            global_row[global_column] = local_row[local_column]
        global_table[local_row[local_schema[table_name][0]]] = global_row
    return global_table

#Translation 2: mediated schema to local schema

def global_to_local(global_table, table_name):
    local_table = {}
    for global_row in global_table:
        local_row = {}
        for global_column in global_schema[table_name]:
            local_column = master_mapping_from_global_to_local[table_name][global_column]
            local_row[local_column] = global_table[global_row][global_column]
        local_table[global_table[global_row][global_schema[table_name][0]]] = local_row
    return local_table


