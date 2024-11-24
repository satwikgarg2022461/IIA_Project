import mysql.connector
from flask import Flask, jsonify
import datetime

app = Flask(__name__)

# Database connection function
def get_db_connection():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="Satwik@07",
        database="iia_saurav"
    )

# Helper function to format time
def format_time(time_value):
    if isinstance(time_value, datetime.timedelta):
        # Convert timedelta to a string in "HH:MM" format
        total_minutes = int(time_value.total_seconds() // 60)
        hours, minutes = divmod(total_minutes, 60)
        return f"{hours:02}:{minutes:02}"
    elif isinstance(time_value, datetime.time):
        return time_value.strftime('%H:%M:%S')
    return None

# Helper function to serialize rows
def serialize_row(row, column_names):
    serialized_row = []
    for col_name, value in zip(column_names, row):
        if value is None:
            # Convert NULL values to string "NULL"
            serialized_row.append("NULL")
        elif isinstance(value, (datetime.date, datetime.datetime)):
            serialized_row.append(value.isoformat())
        elif isinstance(value, datetime.time):
            serialized_row.append(format_time(value))
        elif isinstance(value, datetime.timedelta):
            serialized_row.append(format_time(value))
        else:
            serialized_row.append(value)
    return serialized_row


# --- Existing Routes ---
@app.route('/api/doctors', methods=['GET'])
def get_all_doctors():
    connection = get_db_connection()
    cursor = connection.cursor(dictionary=True)

    query = """
        SELECT Doctors.name AS DoctorName, Doctors.phone_number, Doctors.email, Doctors.specialty, Doctors.experience_years, Doctors.qualifications,
               Hospitals.name AS HospitalName, Doctor_Hospital.appointment_date, Doctor_Hospital.appointment_time, Doctor_Hospital.status
        FROM Doctors
        JOIN Doctor_Hospital ON Doctors.doctor_id = Doctor_Hospital.doctor_id
        JOIN Hospitals ON Doctor_Hospital.hospital_id = Hospitals.hospital_id
    """
    cursor.execute(query)
    doctors = cursor.fetchall()
    cursor.close()
    connection.close()

    results = {}
    for doctor in doctors:
        doctor_name = doctor['DoctorName']
        if doctor_name not in results:
            results[doctor_name] = {
                "Name": doctor['DoctorName'],
                "PhoneNumber": doctor['phone_number'],
                "Email": doctor['email'],
                "Specialty": doctor['specialty'],
                "ExperienceYears": doctor['experience_years'],
                "Qualifications": doctor['qualifications'],
                "Hospitals": []
            }

        results[doctor_name]["Hospitals"].append({
            "HospitalName": doctor['HospitalName'],
            "AppointmentDetails": {
                "Date": doctor['appointment_date'],
                "Time": format_time(doctor['appointment_time']),
                "Status": doctor['status']
            }
        })

    return jsonify(list(results.values()))


@app.route('/api/tests', methods=['GET'])
def get_all_tests():
    connection = get_db_connection()
    cursor = connection.cursor(dictionary=True)

    query = """
        SELECT Tests.name AS TestName, Tests.description, Tests.cost,
               Hospitals.name AS HospitalName, Hospital_Tests.appointment_date, Hospital_Tests.appointment_time, Hospital_Tests.status
        FROM Tests
        JOIN Hospital_Tests ON Tests.test_id = Hospital_Tests.test_id
        JOIN Hospitals ON Hospital_Tests.hospital_id = Hospitals.hospital_id
    """
    cursor.execute(query)
    tests = cursor.fetchall()
    cursor.close()
    connection.close()

    results = []
    for test in tests:
        test_info = {
            "TestName": test['TestName'],
            "Description": test['description'],
            "Cost": float(test['cost']),
            "Hospital": {
                "Name": test['HospitalName']
            },
            "AppointmentDetails": {
                "Date": test['appointment_date'],
                "Time": format_time(test['appointment_time']),
                "Status": test['status']
            }
        }
        results.append(test_info)

    return jsonify(results)


@app.route('/api/hospitals', methods=['GET'])
def get_all_hospitals():
    connection = get_db_connection()
    cursor = connection.cursor(dictionary=True)

    query = """
        SELECT hospital_id, name, location, specialties, contact_info
        FROM Hospitals
    """
    cursor.execute(query)
    hospitals = cursor.fetchall()
    cursor.close()
    connection.close()

    results = [
        {
            "Name": hospital['name'],
            "Location": hospital['location'],
            "Specialties": hospital['specialties'],
            "ContactInfo": hospital['contact_info']
        }
        for hospital in hospitals
    ]

    return jsonify(results)


# --- New Routes ---
@app.route('/api/doctors_schema_and_data', methods=['GET'])
def get_all_doctors_with_schema():
    connection = get_db_connection()
    cursor = connection.cursor()

    query = """
        SELECT Doctors.name AS DoctorName, Doctors.phone_number, Doctors.email, Doctors.specialty, Doctors.experience_years, Doctors.qualifications,
               Hospitals.name AS HospitalName, Doctor_Hospital.appointment_date, Doctor_Hospital.appointment_time, Doctor_Hospital.status
        FROM Doctors
        JOIN Doctor_Hospital ON Doctors.doctor_id = Doctor_Hospital.doctor_id
        JOIN Hospitals ON Doctor_Hospital.hospital_id = Hospitals.hospital_id
    """
    cursor.execute(query)
    columns = [desc[0] for desc in cursor.description]
    data = [tuple(serialize_row(row, columns)) for row in cursor.fetchall()]

    cursor.close()
    connection.close()

    result = {
        "schema": columns,
        "data": data
    }

    return jsonify(result)


@app.route('/api/tests_schema_and_data', methods=['GET'])
def get_all_tests_with_schema():
    connection = get_db_connection()
    cursor = connection.cursor()

    query = """
        SELECT Tests.name AS TestName, Tests.description, Tests.cost,
               Hospitals.name AS HospitalName, Hospital_Tests.appointment_date, Hospital_Tests.appointment_time, Hospital_Tests.status
        FROM Tests
        JOIN Hospital_Tests ON Tests.test_id = Hospital_Tests.test_id
        JOIN Hospitals ON Hospital_Tests.hospital_id = Hospitals.hospital_id
    """
    cursor.execute(query)
    columns = [desc[0] for desc in cursor.description]
    data = [tuple(serialize_row(row, columns)) for row in cursor.fetchall()]

    cursor.close()
    connection.close()

    result = {
        "schema": columns,
        "data": data
    }

    return jsonify(result)


@app.route('/api/hospitals_schema_and_data', methods=['GET'])
def get_all_hospitals_with_schema():
    connection = get_db_connection()
    cursor = connection.cursor()

    query = """
        SELECT hospital_id, name, location, specialties, contact_info
        FROM Hospitals
    """
    cursor.execute(query)
    columns = [desc[0] for desc in cursor.description]
    data = [tuple(serialize_row(row, columns)) for row in cursor.fetchall()]

    cursor.close()
    connection.close()

    result = {
        "schema": columns,
        "data": data
    }

    return jsonify(result)


if __name__ == '__main__':
    app.run(debug=True, port=5001)
