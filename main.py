import jellyfish
import requests
import pandas as pd
from rapidfuzz.distance import Jaro, Levenshtein
import textdistance
from difflib import SequenceMatcher
import phonetics
import json


class Node:
    def __init__(self, value):
        self.value = value
        self.children = []

    def add_child(self, child_node):
        """Adds a child node."""
        self.children.append(child_node)

    def __repr__(self):
        """String representation of the node for debugging."""
        return f"Node({self.value})"


hospital_column_synonyms = {
    "h_name": ["hospital_name", "facility_name", "clinic_name", "healthcare_name", "name", "h_name"],
    "email": ["email_address", "contact_email", "email_id", "mail", "email", "contact_email", "contact_info"],
    "address": ["location", "hospital_address", "clinic_address", "street_address", "address", "addr"],
    "speciality": ["specialization", "department", "area_of_expertise", "medical_field", "speciality"]
}

doctor_column_synonyms = {
    "d_name": ["doctor_name", "physician_name", "name", "medical_practitioner", "d_name"],
    "phone": ["contact_number", "mobile", "telephone", "phone_number", "phone"],
    "email": ["email_address", "contact_email", "email_id", "mail", "email"],
    "address": ["location", "clinic_address", "residential_address", "street_address", "address", "addr"],
    "speciality": ["specialization", "expertise", "field_of_practice", "medical_field", "speciality"],
    "experience": ["years_of_experience", "work_experience", "practice_years", "career_duration", "experience", "exp",
                   "yoe"],
    "education": ["qualification", "degree", "certification", "academic_background", "education"],
    "h_name": ["hospital_name", "facility_name", "clinic_name", "healthcare_name", "name", "h_name","Hospitals"],
}

test_table_synonyms = {
    "t_name": ["test_name", "diagnostic_name", "procedure_name", "medical_test", "t_name", "name"],
    "description": ["details", "test_details", "information", "procedure_description", "description"],
    "cost": ["price", "fee", "test_cost", "charge", "cost"]
}

appointment_doctor_synonyms = {
    "address": ["location", "hospital_address", "clinic_address", "street_address", "address", "addr"],
    "phone": ["contact_number", "mobile", "telephone", "phone_number", "phone", "ContactNumber","DoctorPhone"],
    "d_name": ["doctor_name", "physician_name", "name", "medical_practitioner", "d_name", "DoctorName"],
    "h_name": ["hospital_name", "facility_name", "clinic_name", "healthcare_name", "name", "h_name", "HospitalName"],
    "email": ["email_address", "contact_email", "email_id", "mail", "email", "DoctorEmail"],
    "price": ["cost", "fee", "consultation_charge", "appointment_fee", "price"],
    "time": ["appointment_time", "scheduled_time", "time_slot", "consultation_time", "time", "AppointmentTime"],
    "date": ["appointment_date", "scheduled_date", "consultation_date", "visit_date", "date","AppointmentDate"],
    "status": ["appointment_status", "confirmation_status", "booking_status", "state", "status"]
}

appointment_test_synonyms = {
    "t_name": ["test_name", "diagnostic_name", "procedure_name", "medical_test", "t_name", "name", "TestName"],
    "address": ["location", "hospital_address", "clinic_address", "street_address", "address", "addr"],
    "time": ["test_time", "scheduled_time", "time_slot", "procedure_time", "time","AppointmentTime"],
    "price": ["cost", "fee", "consultation_charge", "appointment_fee", "price"],
    "date": ["test_date", "scheduled_date", "procedure_date", "diagnostic_date", "date","AppointmentDate"],
    "status": ["test_status", "confirmation_status", "booking_status", "state", "status"],
    "h_name": ["hospital_name", "facility_name", "clinic_name", "healthcare_name", "name", "h_name", "HospitalName"],
}

matching_rules_hospital = {
    "weights": {
        1: {"h_name": [1], "email": [1], "address": [1]},
        2: {
            "email-h_name": [0.3, 0.7],
            "address-h_name": [0.2, 0.8],
            "address-email": [0.2, 0.8],
        },
        3: {"address-email-h_name": [0.1, 0.2, 0.7]},
    },
    "methods": {
        "h_name": "edit",
        "email": "exact",
        "address": "smith_waterman",
    },
}

matching_rules_doctor = {
    "weights": {
        1: {
            "d_name": 1,
            "phone": 1,
            "email": 1,
            "address": 1,
        },
        2: {
            "d_name-phone": [0.3, 0.7],
            "d_name-email": [0.3, 0.7],
            "address-d_name": [0.5, 0.5],
            "email-phone": [0.4, 0.6],
            "address-phone": [0.2, 0.8],
            "address-email": [0.2, 0.8],
        },
        3: {
            "d_name-email-phone": [0.2, 0.4, 0.4],
            "address-d_name-phone": [0.2, 0.2, 0.6],
            "address-d_name-email": [0.2, 0.2, 0.6],
            "address-email-phone": [0.1, 0.45, 0.45],
        },
        4: {
            "address-d_name-email-phone": [0.1, 0.1, 0.4, 0.4]
        }
    },
    "methods": {
        "d_name": "edit",
        "phone": "exact",
        "email": "exact",
        "address": "smith_waterman",
    },
}

matching_rules_tests ={
    "weights": {
        1: {
            "t_name": [1],
        }
    },
    "methods": {
        "t_name": "edit",
    }
}

hospital_attribute_match_list = ['address', 'email', 'h_name']
doctor_attribute_match_list = ['address', 'email', 'd_name', 'phone']
test_attribute_match_list = ['t_name']



def merge_address(response):
    if response.status_code == 200:
        # Step 2: Parse JSON data
        data = response.json()

        # Step 3: Process each entry
        for item in data:
            merged_address = f"{item['Street']}, {item['State']}, {item['Country']}, {item['Pincode']}"
            item['Address'] = merged_address
            item.pop('Street')
            item.pop('State')
            item.pop('Country')
            item.pop('Pincode')
        return data

    else:
        print(f"Failed to fetch data. Status code: {response.status_code}")
        return None


def process_hospital_data(response):
    if response.status_code == 200:
        # Parse JSON data if the request was successful
        data = response.json()

        # Iterate through each doctor in the response
        for doctor in data:
            # Extract the hospital names and concatenate them
            hospital_names = [hospital for hospital in doctor['Hospitals']]
            # Join the hospital names into a single string (you can customize the separator)
            doctor['Hospitals'] = ', '.join(hospital_names)

        return data
    else:
        # Handle failure response
        print(f"Failed to fetch data. Status code: {response.status_code}")
        return None


def map_api_to_warehouse(warehouse_dict, api_cols, threshold):
    mapping = {}

    for api_col in api_cols:
        best_match = None
        best_score = 0

        for warehouse_col, synonyms in warehouse_dict.items():
            for synonym in synonyms:
                score = jellyfish.jaro_similarity(api_col.lower(), synonym.lower())
                if score > best_score and score >= threshold:
                    best_match = warehouse_col
                    best_score = score

        if best_match:
            mapping[api_col] = best_match

    return mapping


import requests

def return_col_mapping_db_satwik():
    # Hospital Table
    api_url_satwik_hospital = "http://127.0.0.1:5000/api/hospitals"
    response = requests.get(api_url_satwik_hospital)
    data = merge_address(response)  # Parse the JSON response
    api_cols_hospital = list(data[0].keys())  # Get keys from the first dictionary
    hospital_col_mapping = map_api_to_warehouse(hospital_column_synonyms, api_cols_hospital, 0.8)

    # Doctor Table
    api_url_satwik_doctor = "http://127.0.0.1:5000/api/doctors"
    response = requests.get(api_url_satwik_doctor)
    data = response.json()
    api_cols_doctor = list(data[0].keys())  # Get keys from the first dictionary
    doctor_col_mapping = map_api_to_warehouse(doctor_column_synonyms, api_cols_doctor, 0.8)

    # Test Table
    api_url_satwik_test = "http://127.0.0.1:5000/api/tests"
    response = requests.get(api_url_satwik_test)
    data = response.json()
    api_cols_test = list(data[0].keys())  # Get keys from the first dictionary
    test_col_mapping = map_api_to_warehouse(test_table_synonyms, api_cols_test, 0.8)

    # Appointment Doctor Table
    api_url_satwik_appointment_doctor = "http://127.0.0.1:5000/api/appointmentdoctor"
    response = requests.get(api_url_satwik_appointment_doctor)
    data = response.json()
    api_cols_appointment_doctor = list(data[0].keys())  # Get keys from the first dictionary
    appointment_doctor_col_mapping = map_api_to_warehouse(appointment_doctor_synonyms, api_cols_appointment_doctor, 0.8)

    # Appointment Test Table
    api_url_satwik_appointment_test = "http://127.0.0.1:5000/api/appointmenttest"
    response = requests.get(api_url_satwik_appointment_test)
    data = response.json()
    api_cols_appointment_test = list(data[0].keys())  # Get keys from the first dictionary
    appointment_test_col_mapping = map_api_to_warehouse(appointment_test_synonyms, api_cols_appointment_test, 0.8)

    return (
        hospital_col_mapping,
        doctor_col_mapping,
        test_col_mapping,
        appointment_doctor_col_mapping,
        appointment_test_col_mapping
    )


def return_col_mapping_db_saurav():
    # Hospital Table
    api_url_saurav_hospital = "http://127.0.0.1:5001/api/hospitals"  # Replace with the actual API URL
    response = requests.get(api_url_saurav_hospital)
    data = response.json()
    api_cols_hospital = list(data[0].keys()) if data else []
    hospital_col_mapping = map_api_to_warehouse(hospital_column_synonyms, api_cols_hospital, 0.8)

    # Doctor table
    api_url_saurav_doctor = "http://127.0.0.1:5001/api/doctors"
    response = requests.get(api_url_saurav_doctor)
    data = response.json()
    api_cols_doctor = list(data[0].keys()) if data else []
    doctor_col_mapping = map_api_to_warehouse(doctor_column_synonyms, api_cols_doctor, 0.8)

    # Test table
    api_url_saurav_test = "http://127.0.0.1:5001/api/tests"
    response = requests.get(api_url_saurav_test)
    data = response.json()
    api_cols_test = list(data[0].keys()) if data else []
    test_col_mapping = map_api_to_warehouse(test_table_synonyms, api_cols_test, 0.8)

    # Appointment doctor
    api_url_appointments_doctor = "http://127.0.0.1:5001/api/appointments-doctor"
    response = requests.get(api_url_appointments_doctor)
    data = response.json()
    api_cols_appointment_doctor = list(data[0].keys()) if data else []
    appointment_doctor_col_mapping = map_api_to_warehouse(appointment_doctor_synonyms, api_cols_appointment_doctor, 0.8)

    # Appointment test
    api_url_appointments_test = "http://127.0.0.1:5001/api/appointments-test"
    response = requests.get(api_url_appointments_test)
    data = response.json()
    api_cols_appointment_test = list(data[0].keys()) if data else []
    appointment_test_col_mapping = map_api_to_warehouse(appointment_test_synonyms, api_cols_appointment_test, 0.8)

    return hospital_col_mapping, doctor_col_mapping, test_col_mapping, appointment_doctor_col_mapping, appointment_test_col_mapping



def call_db_saurav():
    hospital_col_mapping, doctor_col_mapping, test_col_mapping, appointment_doctor_col_mapping, appointment_test_col_mapping = return_col_mapping_db_saurav()
    return hospital_col_mapping, doctor_col_mapping, test_col_mapping, appointment_doctor_col_mapping, appointment_test_col_mapping


def call_db_satwik():
    hospital_col_mapping, doctor_col_mapping, test_col_mapping, appointment_doctor_col_mapping, appointment_test_col_mapping = return_col_mapping_db_satwik()
    return hospital_col_mapping, doctor_col_mapping, test_col_mapping, appointment_doctor_col_mapping, appointment_test_col_mapping


def print_mapping(hospital_col_mapping, doctor_col_mapping, test_col_mapping, appointment_doctor_col_mapping,
                  appointment_test_col_mapping):
    print("Hospital Column Mapping:", hospital_col_mapping)
    print("Doctor Column Mapping:", doctor_col_mapping)
    print("Test Column Mapping:", test_col_mapping)
    print("Appointment Doctor Column Mapping:", appointment_doctor_col_mapping)
    print("Appointment Test Column Mapping:", appointment_test_col_mapping)
    print()


def fetch_data_from_api(api_url, params=None):
    response = requests.get(api_url, params=params)
    if response.status_code == 200:
        return response
    else:
        print(f"Error fetching data from {api_url}: {response.status_code}")
        return None


def score_attributes(df, columns):
    if len(columns) == 0:
        return 0
    scores = {}
    for column in columns:
        non_missing = df[column].notna().sum()
        unique_values = df[column].nunique()
        total_values = len(df)
        scores[column] = min(
            non_missing / total_values,
            unique_values / non_missing if non_missing else 0
        )
    total_score = 0
    for (column, value) in scores.items():
        total_score += value

    return total_score / len(columns)


def generate_tree(lst):
    root = Node(lst)  # Create the root node

    for i in range(len(lst)):
        # Remove the current element to form the child node
        child_list = lst[:i] + lst[i + 1:]
        # Recursively generate the subtree for the child list
        child_node = generate_tree(child_list)
        # Add the child node to the current node
        root.add_child(child_node)

    return root


max_score_blocking = -1
max_score_blocking_attr = []


def max_score(node, df):
    global max_score_blocking
    global max_score_blocking_attr
    score = score_attributes(df, node.value)
    if score > max_score_blocking:
        max_score_blocking = score
        max_score_blocking_attr = node.value
    elif score == max_score_blocking and len(max_score_blocking_attr) < len(node.value):
        max_score_blocking = score
        max_score_blocking_attr = node.value

    for child in node.children:
        max_score(child, df)


def blocking_attribute(df):
    global max_score_blocking
    global max_score_blocking_attr
    selected_attributes = [
        col for col in df.columns
        if not pd.api.types.is_numeric_dtype(df[col]) and not pd.api.types.is_bool_dtype(
            df[col])
    ]
    root = generate_tree(selected_attributes)
    max_score(root, df)
    return max_score_blocking, max_score_blocking_attr


def blocking_attribute_set(df_list):
    global max_score_blocking
    global max_score_blocking_attr
    blocking_attribute_list = []
    # blocking_attribute_set = set()
    for df in df_list:
        blocking_attribute(df)
        blocking_attribute_list.append(max_score_blocking_attr)
        max_score_blocking = -1
        max_score_blocking_attr = []

    blocking_attribute_set = set(blocking_attribute_list[0])
    for i in blocking_attribute_list[1:]:
        blocking_attribute_set = blocking_attribute_set.intersection(i)

    return blocking_attribute_set


def add_unique_identifier(dataframes):
    processed_dataframes = []

    for idx, df in enumerate(dataframes):
        # Make a copy to avoid modifying the original DataFrame
        df_copy = df.copy()
        df_copy['table_id'] = idx + 1  # Assign table ID
        df_copy['row_id'] = range(1, len(df_copy) + 1)  # Assign row ID
        df_copy['unique_id'] = df_copy['table_id'].astype(str) + '_' + df_copy['row_id'].astype(str)
        df_copy = df_copy.drop(['table_id', 'row_id'], axis=1)
        processed_dataframes.append(df_copy)

    return processed_dataframes


def combine_columns(dataframes, columns_to_combine):
    combined_data = []

    for idx, df in enumerate(dataframes):
        if not set(columns_to_combine).issubset(df.columns):
            raise ValueError(f"Some columns in {columns_to_combine} are not present in DataFrame at index {idx}")

        # Create a new column by combining specified columns with ','
        df_combined = df[columns_to_combine].apply(lambda row: ','.join(row.astype(str)), axis=1)

        # Add row identifiers
        combined_data.append(pd.DataFrame({
            'unique_id': df['unique_id'],
            'combined_column': df_combined
        }))

    for df in combined_data:
        for index, row in enumerate(df['combined_column']):
            # Split by commas, then split each result by spaces
            terms = [
                subterm.strip().lower()
                for term in row.split(",")
                for subterm in term.split()
            ]

            # Join the processed terms back into a string and update the DataFrame
            df.at[index, 'combined_column'] = terms

    return combined_data


def create_combined_inverted_index(dataframes, stopwords=None):
    if stopwords is None:
        # Default stopwords list
        stopwords = {"the", "a", "an", "and", "or", "of", "to", "is", "in"}

    # Combine all DataFrames into one
    combined_df = pd.concat(dataframes, ignore_index=True)

    if "combined_column" not in combined_df.columns:
        raise ValueError("'combined_column' not found in the DataFrame(s).")

    # Initialize an inverted index
    inverted_index = {}

    # Iterate through rows
    for idx, row in combined_df.iterrows():
        row_identifier = row['unique_id']  # Default to index if no 'unique_id'
        combined_text = row["combined_column"]

        # Remove stopwords
        filtered_terms = [
            term for term in combined_text
            if term not in stopwords and not term.isnumeric()
        ]

        # Populate the inverted index
        for term in filtered_terms:
            if term not in inverted_index:
                inverted_index[term] = [row_identifier]  # Initialize the list if the term is new
            if row_identifier not in inverted_index[term]:
                inverted_index[term].append(row_identifier)

    return inverted_index


def sort_combined_column_by_word_order(df_list, word_order):
    # Create a mapping of words to their positions in the word_order list
    word_to_index = {word: idx for idx, word in enumerate(word_order)}

    # Function to sort lists based on word_order
    def sort_by_word_order(word_list):
        return sorted(word_list, key=lambda word: word_to_index.get(word, float('inf')))

    # Process each dataframe in the list
    for df in df_list:
        df["combined_column"] = df["combined_column"].apply(sort_by_word_order)

    return df_list


def create_inverted_index_for_rest_tables(df, k):
    inverted_index = {}

    # Iterate over each dataframe in the list
    for idx, row in df.iterrows():
        len_word = len(row) - (k - 1)
        # Extract the first k words from the 'combined_column'
        words = row["combined_column"][:len_word]
        unique_id = row["unique_id"]

        # Add the unique_id to the inverted index for each word in the list
        for word in words:
            if word not in inverted_index:
                inverted_index[word] = [unique_id]
            if unique_id not in inverted_index[word]:
                inverted_index[word].append(unique_id)

    return inverted_index


def prefix_index(df_list, blocking_attribute_set, overlapping_terms):
    combined_df_list = combine_columns(df_list, list(blocking_attribute_set))

    combined_inverted_index = create_combined_inverted_index(combined_df_list)

    sorted_key = sorted(combined_inverted_index.keys(), key=lambda key: len(combined_inverted_index[key]))

    combined_df_list = sort_combined_column_by_word_order(combined_df_list, sorted_key)

    # k = 2
    inverted_index_table_B = create_inverted_index_for_rest_tables(combined_df_list[1], overlapping_terms)

    return combined_df_list[0], inverted_index_table_B


def string_match(s1, s2, method="exact"):
    if pd.isna(s1) or pd.isna(s2):  # Handle NaN values
        return 0

    # Sequence-based methods
    if method == "exact":
        return 1 if s1 == s2 else 0
    elif method == "edit":
        max_len = max(len(s1), len(s2))
        return 1 - Levenshtein.distance(s1, s2) / max_len if max_len > 0 else 1
    elif method == "needleman_wunsch":
        return textdistance.needleman_wunsch.normalized_similarity(s1, s2)
    elif method == "affine_gap":
        return textdistance.affine_gap.normalized_similarity(s1, s2)
    elif method == "smith_waterman":
        return textdistance.smith_waterman.normalized_similarity(s1, s2)
    elif method == "jaro":
        return Jaro.similarity(s1, s2)
    elif method == "jaro_winkler":
        return textdistance.jaro_winkler(s1, s2)

    # Set-based methods
    elif method == "overlap":
        return textdistance.overlap.normalized_similarity(s1, s2)
    elif method == "jaccard":
        return textdistance.jaccard(s1, s2)
    elif method == "sorensen_dice":
        return textdistance.sorensen_dice(s1, s2)
    elif method == "tfidf":
        return textdistance.tfidf.normalized_similarity(s1, s2)

    # Similarity-based
    elif method == "ratcliff_obershelp":
        return SequenceMatcher(None, s1, s2).ratio()

    # Phonetic methods
    elif method == "soundex":
        return 1 if phonetics.soundex(s1) == phonetics.soundex(s2) else 0

    else:
        raise ValueError(f"Unsupported matching method: {method}")


def common_columns_alphabetical(row1, row2, list):
    # Find columns where the values match
    matching_columns = []

    for col1 in row1.index:
        for col2 in row2.index:
            if col1 == col2 and col1 != "unique_id" and col2 != "unique_id" and col1 in list and col2 in list:
                matching_columns.append(col1)
    # Sort the columns alphabetically and return as a string
    return '-'.join(sorted(matching_columns)), len(matching_columns)


def calculate_similarity_dynamic(row1, row2, combination, rules, num_attrs):
    weights = rules["weights"][num_attrs][combination]
    attributes = combination.split("-")
    score = 0


    for i, attr in enumerate(attributes):
        weight = weights[i]
        method = rules["methods"][attr]
        score += weight * string_match(row1.get(attr, ""), row2.get(attr, ""), method)
    return score


def match_rows_dynamic(X, Y, rules, list):
    combination, num_attrs = common_columns_alphabetical(X, Y, list)
    score = calculate_similarity_dynamic(X, Y, combination, rules, num_attrs)
    return score


def similarity(df_list, x, y, rules, list):
    table_x = df_list[int(x.split("_")[0]) - 1]
    table_y = df_list[int(y.split("_")[0]) - 1]
    X = table_x[table_x["unique_id"] == x].squeeze()
    Y = table_y[table_y["unique_id"] == y].squeeze()
    if X.empty or Y.empty:
        return 0

    score = match_rows_dynamic(X, Y, rules, list)

    return score


def send_post_request(row, url):
    headers = {
        'Content-Type': 'application/json'
    }
    if isinstance(row, pd.Series):
        # Convert Series to dictionary first, then to JSON
        row = json.dumps(row.to_dict(), indent=4)
    response = requests.post(url, json=row, headers=headers)
    if response.status_code == 200:
        print(f"Successfully sent data: {row}")
    else:
        print(row)
        print(f"Failed to send data. Status Code: {response.status_code}, Response: {response.text}")


# Function to fetch hospital IDs for a list of names
def get_hospital_ids_by_names(base_url, hospital_names):
    response = requests.get(f"{base_url}/hospital-name-id")
    response.raise_for_status()
    hospitals = response.json()

    # Create a dictionary for fast lookups
    hospital_lookup = {hospital["h_name"]: hospital["h_id"] for hospital in hospitals}

    # Map names to IDs
    return [hospital_lookup.get(name, None) for name in hospital_names]


# Transform the DataFrame's Hospitals field
def transform_hospitals_field(df, base_url):
    def map_hospital_ids(hospitals):
        # Split the hospital names and fetch their IDs
        hospital_names = [name.strip() for name in hospitals.split(",")]
        hospital_ids = get_hospital_ids_by_names(base_url, hospital_names)

        # Convert the list of IDs to a PostgreSQL array string format
        return "{" + "".join(str(hospital_ids))[1:len(str(hospital_ids)) - 1] + "}"


    df["h_name"] = df["h_name"].apply(map_hospital_ids)
    return df

def entity_matching(df_list, blocking_attribute_set, overlapping_terms, url,attribute_match_list, matching_rules):
    for i in range(0, len(df_list) - 1, 1):
        for j in range(i + 1, len(df_list), 1):
            A = df_list[i]
            B = df_list[j]
            temp_list = [A, B]
            A, inverted_index_B = prefix_index(temp_list, blocking_attribute_set, overlapping_terms)
            for index, row in A.iterrows():
                candidate_set = set()
                unique_id = row['unique_id']
                combine_column = row['combined_column']
                idx = len(combine_column) - (overlapping_terms - 1)
                combine_column = combine_column[:idx]
                for term in combine_column:
                    if term in inverted_index_B:
                        values = inverted_index_B[term]
                        for value in values:
                            candidate_set.add(value)
                for candidate in candidate_set:
                    score = similarity(df_list, row['unique_id'], candidate, matching_rules,
                                       attribute_match_list)
                    if score >= 0.8:
                        table1 = df_list[int(row['unique_id'].split("_")[0]) - 1]
                        idx1 = int(row['unique_id'].split("_")[1]) - 1
                        payload1 = table1[table1["unique_id"] == row['unique_id']].squeeze()
                        table2 = df_list[int(candidate.split("_")[0]) - 1]
                        idx2 = int(candidate.split("_")[1]) - 1
                        payload2 = table2[table2["unique_id"] == candidate].squeeze()
                        if len(payload1) > len(payload2):
                            payload = payload1
                        else:
                            payload = payload2
                        print("\n================Entity Matched==========================")
                        print("Matched Entity:", payload.to_dict())
                        print("Score:", score)
                        send_post_request(payload.to_dict(), url)
                        print("\n=========================================================")
                        df_list[int(row['unique_id'].split("_")[0]) - 1] = df_list[int(row['unique_id'].split("_")[0]) - 1][df_list[int(row['unique_id'].split("_")[0]) - 1]['unique_id'] != row['unique_id']]
                        df_list[int(candidate.split("_")[0]) - 1] = df_list[int(candidate.split("_")[0]) - 1][df_list[int(candidate.split("_")[0]) - 1]['unique_id'] != candidate]


        for index, row in df_list[i].iterrows():
            send_post_request(row.to_dict(), url)

    for index, row in df_list[len(df_list)-1].iterrows():
        send_post_request(row.to_dict(), url)


def get_h_id(api_base_url, h_name):
    try:
        response = requests.get(f"{api_base_url}/get-hid", params={"h_name": h_name})
        if response.status_code == 200:
            return {"h_id": response.json().get("h_id")}
        else:
            return {"error": response.json().get("error", "Unknown error")}
    except Exception as e:
        return {"error": str(e)}

def get_d_id(api_base_url, d_name, phone, email):
    try:
        response = requests.get(
            f"{api_base_url}/get-did",
            params={"phone": phone, "email": email},
        )
        if response.status_code == 200:
            return {"d_id": response.json().get("d_id")}
        else:
            return {"error": response.json().get("error", "Unknown error")}
    except Exception as e:
        return {"error": str(e)}

def get_t_id(api_base_url, t_name):
    try:
        response = requests.get(
            f"{api_base_url}/get-tid", params={"t_name": t_name}
        )
        if response.status_code == 200:
            return {"t_id": response.json().get("t_id")}
        else:
            return {"error": response.json().get("error", "Unknown error")}
    except Exception as e:
        return {"error": str(e)}



def add_appointment_doctor(df_list):
    for i in range(0, len(df_list), 1):
        df = df_list[i]
        # print(df)
        for index, row in df.iterrows():
            hid = get_h_id("http://localhost:5002", row["h_name"])["h_id"]
            did = get_d_id("http://localhost:5002", row["d_name"], row["phone"], row["email"])["d_id"]
            row['h_id'] = hid
            row['d_id'] = did
            # print(row)
            send_post_request(row.to_dict(), "http://localhost:5002/add-appointment-doctor")

def add_appointment_test(df_list):
    for i in range(0, len(df_list), 1):
        df = df_list[i]
        for index, row in df.iterrows():
            hid = get_h_id("http://localhost:5002", row["h_name"])["h_id"]
            tid = get_t_id("http://localhost:5002", row["t_name"])['t_id']
            row['h_id'] = hid
            row['t_id'] = tid
            send_post_request(row.to_dict(), "http://localhost:5002/add-appointment-test")



if __name__ == "__main__":
    df_list_hospital = []
    df_list_doctor = []
    df_list_test = []
    df_doctor_appointment = []
    df_test_appointment = []

    # ontology based matching of table columns
    hospital_col_mapping_db_satwik, doctor_col_mapping_db_satwik, test_col_mapping_db_satwik, appointment_doctor_col_mapping_db_satwik, appointment_test_col_mapping_db_satwik = call_db_satwik()
    print("Satwik DB mapping")
    print_mapping(hospital_col_mapping_db_satwik, doctor_col_mapping_db_satwik, test_col_mapping_db_satwik,
                  appointment_doctor_col_mapping_db_satwik, appointment_test_col_mapping_db_satwik)


    hospital_col_mapping_db_saurav, doctor_col_mapping_db_saurav, test_col_mapping_db_saurav, appointment_doctor_col_mapping_db_saurav, appointment_test_col_mapping_db_saurav = call_db_saurav()
    print("Saurav DB mapping")
    print_mapping(hospital_col_mapping_db_saurav, doctor_col_mapping_db_saurav, test_col_mapping_db_saurav,
                  appointment_doctor_col_mapping_db_saurav, appointment_test_col_mapping_db_saurav)


    # Satwik DB hospital
    hospital_satwik_response = fetch_data_from_api(api_url="http://127.0.0.1:5000/api/hospitals", params={})
    combined_address_data = merge_address(hospital_satwik_response)
    df_hospital_satwik = pd.DataFrame(combined_address_data)
    df_hospital_satwik = df_hospital_satwik.rename(columns=hospital_col_mapping_db_satwik)
    df_list_hospital.append(df_hospital_satwik)

    # Satwik db doctor
    doctor_satwik_response = fetch_data_from_api(api_url="http://127.0.0.1:5000/api/doctors", params={})
    processed_doctors_satwik_data = process_hospital_data(doctor_satwik_response)
    df_doctor_satwik = pd.DataFrame(processed_doctors_satwik_data)
    df_doctor_satwik = df_doctor_satwik.rename(columns=doctor_col_mapping_db_satwik)
    df_list_doctor.append(df_doctor_satwik)

    # Satwik db Test
    test_satwik_response = fetch_data_from_api(api_url="http://127.0.0.1:5000/api/tests", params={})
    df_test_satwik = pd.DataFrame(test_satwik_response.json())
    df_test_satwik = df_test_satwik.rename(columns=test_col_mapping_db_satwik)
    df_list_test.append(df_test_satwik)

    # Satwik doctor appointment
    appointment_doctor_response = fetch_data_from_api(api_url="http://127.0.0.1:5000//api/appointmentdoctor", params={})
    df_appointment_doctor_satwik = pd.DataFrame(appointment_doctor_response.json())
    df_appointment_doctor_satwik = df_appointment_doctor_satwik.rename(columns=appointment_doctor_col_mapping_db_satwik)
    df_doctor_appointment.append(df_appointment_doctor_satwik)

    # Satwik test appointment
    appointment_test_response = fetch_data_from_api(api_url="http://127.0.0.1:5000//api/appointmenttest", params={})
    df_appointment_test_satwik = pd.DataFrame(appointment_test_response.json())
    df_appointment_test_satwik = df_appointment_test_satwik.rename(columns=appointment_test_col_mapping_db_satwik)
    df_test_appointment.append(df_appointment_test_satwik)

    # Saurav db hospital
    hospital_saurav_response = fetch_data_from_api(api_url="http://127.0.0.1:5001/api/hospitals", params={})
    df_hospital_saurav = pd.DataFrame(hospital_saurav_response.json())
    df_hospital_saurav = df_hospital_saurav.rename(columns=hospital_col_mapping_db_saurav)
    df_list_hospital.append(df_hospital_saurav)

    # Saurav db doctor
    doctor_saurav_response = fetch_data_from_api(api_url="http://127.0.0.1:5001/api/doctors", params={})
    processed_doctor_saurav_data = process_hospital_data(doctor_saurav_response)
    df_doctor_saurav = pd.DataFrame(processed_doctor_saurav_data)
    df_doctor_saurav = df_doctor_saurav.rename(columns=doctor_col_mapping_db_saurav)
    df_list_doctor.append(df_doctor_saurav)

    # Saurav db test
    test_saurav_response = fetch_data_from_api(api_url="http://127.0.0.1:5001/api/tests", params={})
    df_test_saurav = pd.DataFrame(test_saurav_response.json())
    df_test_saurav = df_test_saurav.rename(columns=test_col_mapping_db_saurav)
    df_list_test.append(df_test_saurav)

    # appointment doctor saurav
    appointment_doctor_response = fetch_data_from_api(api_url="http://127.0.0.1:5001/api/appointments-doctor",params={})
    df_doctor_appointment_saurav = pd.DataFrame(appointment_doctor_response.json())
    df_doctor_appointment_saurav = df_doctor_appointment_saurav.rename(columns=appointment_doctor_col_mapping_db_saurav)
    df_doctor_appointment.append(df_doctor_appointment_saurav)

    # appointment test saurav
    appointment_test_response = fetch_data_from_api(api_url="http://127.0.0.1:5001/api/appointments-test",params={})
    df_appointment_test_saurav = pd.DataFrame(appointment_test_response.json())
    df_appointment_test_saurav = df_appointment_test_saurav.rename(columns=appointment_test_col_mapping_db_saurav)
    df_test_appointment.append(df_appointment_test_saurav)


    # Blocking attributes
    blocking_attribute_set_hospital = blocking_attribute_set(df_list_hospital)
    print("Blocking Attributes hospital:", blocking_attribute_set_hospital,'\n')
    blocking_attribute_set_doctor = blocking_attribute_set(df_list_doctor)
    print("Blocking Attributes Doctor:", blocking_attribute_set_doctor,'\n')
    blocking_attribute_set_test = blocking_attribute_set(df_list_test)
    print("Blocking Attributes Test:", blocking_attribute_set_test,'\n')

    overlapping_terms = 2

    # Hospital entity matching
    df_list_hospital = add_unique_identifier(df_list_hospital)
    entity_matching(df_list_hospital, blocking_attribute_set_hospital, overlapping_terms, "http://127.0.0.1:5002/add_hospital", hospital_attribute_match_list, matching_rules_hospital)

    for df in df_list_doctor:
        transform_hospitals_field(df, "http://127.0.0.1:5002")

    # Doctor entity matching
    df_list_doctor = add_unique_identifier(df_list_doctor)
    entity_matching(df_list_doctor, blocking_attribute_set_doctor, overlapping_terms, "http://127.0.0.1:5002/add_doctors", doctor_attribute_match_list, matching_rules_doctor)

    # Entity Matching tests
    df_list_test = add_unique_identifier(df_list_test)
    entity_matching(df_list_test, blocking_attribute_set_test, overlapping_terms, "http://127.0.0.1:5002/add_tests", test_attribute_match_list, matching_rules_tests)

    #     add doctor appointment
    add_appointment_doctor(df_doctor_appointment)

    #     add test appointment
    add_appointment_test(df_test_appointment)

