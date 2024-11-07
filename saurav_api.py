import mysql.connector
from flask import Flask, jsonify
import datetime

app = Flask(__name__)

# Database connection function
def get_db_connection():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="Saurav@2022464",
        database="doctors"
    )



@app.route('/api/doctors', methods=['GET'])
def get_all_doctors():
    connection = get_db_connection()
    cursor = connection.cursor(dictionary=True)

    query = """
        SELECT d.name AS DoctorName, d.phone_number, d.email, d.specialty, d.experience_years, d.qualifications,
               h.name AS HospitalName, dh.available_day, dh.available_time
        FROM Doctors d
        JOIN Doctor_Hospital dh ON d.doctor_id = dh.doctor_id
        JOIN Hospitals h ON dh.hospital_id = h.hospital_id
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
            "Availability": {
                "Day": doctor['available_day'],
                "Time": doctor['available_time']
            }
        })

    return jsonify(list(results.values()))


@app.route('/api/tests', methods=['GET'])
def get_all_tests():
    connection = get_db_connection()
    cursor = connection.cursor(dictionary=True)

    query = """
        SELECT t.name AS TestName, t.description, t.cost, h.name AS HospitalName, ht.available_day, ht.available_time
        FROM Tests t
        JOIN Hospital_Tests ht ON t.test_id = ht.test_id
        JOIN Hospitals h ON ht.hospital_id = h.hospital_id
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
            "Availability": {
                "Day": test['available_day'],
                "Time": test['available_time']
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

if __name__ == '__main__':
    app.run(debug=True)
