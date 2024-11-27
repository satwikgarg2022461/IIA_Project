import datetime

import mysql.connector
from flask import Flask, jsonify, request

app = Flask(__name__)

# Database connection configuration
DB_CONFIG = {
    'user': 'root',
    'password': 'Satwik@07',
    'host': 'localhost',  # or the appropriate host
    'database': 'iia_satwik'
}

def format_time(time_value):
    if isinstance(time_value, datetime.timedelta):
        # Convert timedelta to a string in "HH:MM" format
        total_minutes = int(time_value.total_seconds() // 60)
        hours, minutes = divmod(total_minutes, 60)
        return f"{hours:02}:{minutes:02}"
    elif isinstance(time_value, datetime.time):
        return time_value.strftime('%H:%M:%S')
    return None

# Helper function to execute queries
def execute_query(query, params=None, fetchall=True):
    conn = mysql.connector.connect(**DB_CONFIG)
    cursor = conn.cursor()
    cursor.execute(query, params if params else ())
    if fetchall:
        result = cursor.fetchall()
    else:
        result = cursor.fetchone()
    conn.commit()
    cursor.close()
    conn.close()
    return result

# API Endpoints

@app.route('/api/hospitals', methods=['GET'])
def get_hospitals():
    query = "SELECT Name, Street, State, Country, Pincode FROM Hospital;"
    hospitals = execute_query(query)
    return jsonify([{
        'Name': hospital[0],
        'Street': hospital[1],
        'State': hospital[2],
        'Country': hospital[3],
        'Pincode': hospital[4]
    } for hospital in hospitals])

@app.route('/api/doctors', methods=['GET'])
def get_doctors():
    doctor_query = "SELECT DID, Name, ContactNumber, Email, Specialization, Education  FROM Doctor;"
    hospital_query = """
        SELECT H.Name 
        FROM DoctorMapHospital DMH
        JOIN Hospital H ON DMH.HID = H.HID
        WHERE DMH.DID = %s;
    """
    doctors = execute_query(doctor_query)
    result = []
    for doctor in doctors:
        hospitals = execute_query(hospital_query, (doctor[0],))
        hospital_list = [hospital[0] for hospital in hospitals]
        result.append({
            'Name': doctor[1],
            'ContactNumber': doctor[2],
            'Email': doctor[3],
            'Specialization': doctor[4],
            'Education': doctor[5],
            'Hospitals': hospital_list
        })
    return jsonify(result)

@app.route('/api/tests', methods=['GET'])
def get_tests():
    query = "SELECT Name, Description, Price FROM Test;"
    tests = execute_query(query)
    return jsonify([{
        'Name': test[0],
        'Description': test[1],
        'Price' : test[2]
    } for test in tests])


@app.route('/api/appointmentdoctor', methods=['GET'])
def get_appointment_doctor():
    query = """
        SELECT D.Name, D.ContactNumber, D.Email, H.Name, H.Street, H.State, H.Country, H.Pincode, AD.Date, AD.Time, AD.Price
        FROM AppointmentDoctor AD
        JOIN Doctor D ON AD.DID = D.DID
        JOIN Hospital H ON AD.HID = H.HID;
    """
    appointments = execute_query(query)
    return jsonify([{
        'DoctorName': appt[0],
        'ContactNumber': appt[1],
        'Email': appt[2],
        'HospitalName': appt[3],
        'Address': f"{appt[4]}, {appt[5]}, {appt[6]}, {appt[7]}",
        'Date': appt[8],
        'Time': str(appt[9]),
        'Price': appt[10]
    } for appt in appointments])

@app.route('/api/appointmenttest', methods=['GET'])
def get_appointment_test():
    query = """
        SELECT T.Name, T.Description, H.Name, H.Street, H.State, H.Country, H.Pincode, AT.Date, AT.Time
        FROM AppointmentTest AT
        JOIN Test T ON AT.TID = T.TID
        JOIN Hospital H ON AT.HID = H.HID;
    """
    appointments = execute_query(query)
    return jsonify([{
        'TestName': appt[0],
        'Description': appt[1],
        'HospitalName': appt[2],
        'Address': f"{appt[3]}, {appt[4]}, {appt[5]}, {appt[6]}",
        'Date': appt[7],
        'Time': str(appt[8]),
    } for appt in appointments])


# Route to get appointment details for a doctor
@app.route('/api/doctor-appointment', methods=['POST'])
def get_doctor_appointment():
    doctor_name = request.args.get('doctor_name')
    email = request.args.get('email')
    contact_number = request.args.get('contact_number')
    hospital_name = request.args.get('hospital_name')

    if not (doctor_name and email and contact_number and hospital_name):
        return jsonify({"error": "Missing required parameters"}), 400

    query = """
        SELECT AD.Date, AD.Time
        FROM AppointmentDoctor AD
        JOIN Doctor D ON AD.DID = D.DID
        JOIN Hospital H ON AD.HID = H.HID
        WHERE D.Name = %s AND D.Email = %s AND D.ContactNumber = %s AND H.Name = %s;
    """
    appointment = execute_query(query, (doctor_name, email, contact_number, hospital_name), fetchall=False)

    if not appointment:
        return jsonify({"error": "No appointment found"}), 404

    return jsonify({
        "AppointmentDate": appointment[0],
        "AppointmentTime": str(appointment[1])
    })


# Route to get appointment details for a test
@app.route('/api/test-appointment', methods=['POST'])
def get_test_appointment():
    test_name = request.args.get('test_name')
    hospital_name = request.args.get('hospital_name')

    if not (test_name and hospital_name):
        return jsonify({"error": "Missing required parameters"}), 400

    query = """
        SELECT AT.Date, AT.Time
        FROM AppointmentTest AT
        JOIN Test T ON AT.TID = T.TID
        JOIN Hospital H ON AT.HID = H.HID
        WHERE T.Name = %s AND H.Name = %s;
    """
    appointment = execute_query(query, (test_name, hospital_name), fetchall=False)

    if not appointment:
        return jsonify({"error": "No appointment found"}), 404

    return jsonify({
        "AppointmentDate": appointment[0],
        "AppointmentTime": str(appointment[1])
    })

@app.route('/api/test', methods=['GET'])
def get_test():
    return jsonify({"message": "Hello World"}), 200

if __name__ == '__main__':
    app.run(debug=True, port=5000)
