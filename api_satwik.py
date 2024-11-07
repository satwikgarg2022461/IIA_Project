from flask import Flask, jsonify
import mysql.connector
import datetime

app = Flask(__name__)

# Database connection function
def get_db_connection():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="Satwik@07",
        database="iia_satwik"
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


@app.route('/api/doctors', methods=['GET'])
def get_all_doctors():
    connection = get_db_connection()
    cursor = connection.cursor(dictionary=True)

    query = """
        SELECT Doctor.Name AS DoctorName, Doctor.ContactNumber, Doctor.Email, Doctor.Specialization, 
               Doctor.Education, Hospital.Name AS HospitalName, AppointmentDoctor.Date, AppointmentDoctor.Time
        FROM Doctor
        JOIN DoctorMapHospital ON Doctor.DID = DoctorMapHospital.DID
        JOIN Hospital ON DoctorMapHospital.HID = Hospital.HID
        LEFT JOIN AppointmentDoctor ON Doctor.DID = AppointmentDoctor.DID AND Hospital.HID = AppointmentDoctor.HID
    """
    cursor.execute(query)
    doctors = cursor.fetchall()
    cursor.close()
    connection.close()

    results = {}
    for doctor in doctors:
        doctor_id = doctor['DoctorName']
        if doctor_id not in results:
            results[doctor_id] = {
                "Name": doctor['DoctorName'],
                "ContactNumber": doctor['ContactNumber'],
                "Email": doctor['Email'],
                "Specialization": doctor['Specialization'],
                "Education": doctor['Education'],
                "Hospitals": []
            }

        # Convert Date and Time to string format to ensure JSON serialization
        appointment_date = doctor['Date'].isoformat() if doctor['Date'] else None
        appointment_time = format_time(doctor['Time']) if doctor['Time'] else None

        results[doctor_id]["Hospitals"].append({
            "HospitalName": doctor['HospitalName'],
            "AppointmentDetails": {
                "Date": appointment_date,
                "Time": appointment_time
            }
        })
    return jsonify(list(results.values()))


@app.route('/api/tests', methods=['GET'])
def get_all_tests():
    connection = get_db_connection()
    cursor = connection.cursor(dictionary=True)

    query = """
        SELECT Test.Name AS TestName, Test.Description, AppointmentTest.Price, 
               Hospital.Name AS HospitalName, Hospital.Street, Hospital.State, 
               Hospital.Country, Hospital.Pincode, AppointmentTest.Date, AppointmentTest.Time
        FROM Test
        JOIN AppointmentTest ON Test.TID = AppointmentTest.TID
        JOIN Hospital ON AppointmentTest.HID = Hospital.HID
    """
    cursor.execute(query)
    tests = cursor.fetchall()
    cursor.close()
    connection.close()

    results = []
    for test in tests:
        # Convert Date and Time to string format to ensure JSON serialization
        appointment_date = test['Date'].isoformat() if test['Date'] else None
        appointment_time = format_time(test['Time']) if test['Time'] else None

        test_info = {
            "TestName": test['TestName'],
            "Description": test['Description'],
            "Price": test['Price'],
            "Hospital": {
                "Name": test['HospitalName'],
                "Address": {
                    "Street": test['Street'],
                    "State": test['State'],
                    "Country": test['Country'],
                    "Pincode": test['Pincode']
                }
            },
            "AppointmentDetails": {
                "Date": appointment_date,
                "Time": appointment_time
            }
        }
        results.append(test_info)

    return jsonify(results)


@app.route('/api/hospitals', methods=['GET'])
def get_all_hospitals():
    connection = get_db_connection()
    cursor = connection.cursor(dictionary=True)

    query = """
        SELECT Name, Street, State, Country, Pincode
        FROM Hospital
    """
    cursor.execute(query)
    hospitals = cursor.fetchall()
    cursor.close()
    connection.close()

    results = [
        {
            "Name": hospital['Name'],
            "Address": {
                "Street": hospital['Street'],
                "State": hospital['State'],
                "Country": hospital['Country'],
                "Pincode": hospital['Pincode']
            }
        }
        for hospital in hospitals
    ]

    return jsonify(results)


if __name__ == '__main__':
    app.run(debug=True)