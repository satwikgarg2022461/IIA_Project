import mysql.connector
from flask import Flask, jsonify, request
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


@app.route('/api/doctors', methods=['GET'])
def get_all_doctors():
    connection = get_db_connection()
    cursor = connection.cursor(dictionary=True)

    query = """
        SELECT Doctors.name AS DoctorName, Doctors.phone_number, Doctors.email, Doctors.specialty, Doctors.qualifications,
               Hospitals.name AS HospitalName, Doctors.experience_years 
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
                "Name": f"{doctor['DoctorName']}",
                "ContactNumber": doctor['phone_number'],
                "Email": doctor['email'],
                "Specialization": doctor['specialty'],
                "Education": doctor['qualifications'],
                "experience_years": doctor['experience_years'],
                "Hospitals": set()
            }

        # Add hospital name to the set
        results[doctor_name]["Hospitals"].add(doctor['HospitalName'])

    # Convert the set of hospitals to a list for the final output
    for doctor in results.values():
        doctor["Hospitals"] = list(doctor["Hospitals"])

    return jsonify(list(results.values()))



@app.route('/api/tests', methods=['GET'])
def get_all_tests():
    connection = get_db_connection()
    cursor = connection.cursor(dictionary=True)

    query = """
        SELECT name AS TestName, description, cost FROM Tests
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



# Route to get doctor appointments with hospital names
@app.route('/api/appointments-doctor', methods=['GET'])
def get_appointments_doctor():
    connection = get_db_connection()
    cursor = connection.cursor(dictionary=True)

    query = """
        SELECT 
            d.name AS doctor_name,
            d.phone_number AS doctor_phone,
            d.email AS doctor_email,
            h.name AS hospital_name,
            dh.appointment_date,
            dh.appointment_time,
            dh.status,
            dh.price
        FROM 
            Doctor_Hospital dh
        JOIN 
            Doctors d ON dh.doctor_id = d.doctor_id
        JOIN 
            Hospitals h ON dh.hospital_id = h.hospital_id
    """
    cursor.execute(query)
    appointments = cursor.fetchall()
    cursor.close()
    connection.close()

    results = [
        {
            "DoctorName": appointment['doctor_name'],
            "DoctorPhone": appointment['doctor_phone'],
            "DoctorEmail": appointment['doctor_email'],
            "HospitalName": appointment['hospital_name'],
            "AppointmentDate": appointment['appointment_date'],
            "AppointmentTime": format_time(appointment['appointment_time']),
            "Status": appointment['status'],
            "Price": float(appointment['price'])
        }
        for appointment in appointments
    ]

    return jsonify(results)

# Route to get test appointments with hospital names
@app.route('/api/appointments-test', methods=['GET'])
def get_appointments_test():
    connection = get_db_connection()
    cursor = connection.cursor(dictionary=True)

    query = """
        SELECT 
            h.name AS hospital_name,
            t.name AS test_name,
            t.description AS test_description,
            t.cost AS test_cost,
            ht.appointment_date,
            ht.appointment_time,
            ht.status
        FROM 
            Hospital_Tests ht
        JOIN 
            Hospitals h ON ht.hospital_id = h.hospital_id
        JOIN 
            Tests t ON ht.test_id = t.test_id
    """
    cursor.execute(query)
    test_appointments = cursor.fetchall()
    cursor.close()
    connection.close()

    results = [
        {
            "HospitalName": appointment['hospital_name'],
            "TestName": appointment['test_name'],
            "TestDescription": appointment['test_description'],
            "TestCost": float(appointment['test_cost']),
            "AppointmentDate": appointment['appointment_date'],
            "AppointmentTime": format_time(appointment['appointment_time']),
            "Status": appointment['status']
        }
        for appointment in test_appointments
    ]

    return jsonify(results)


# Route to get appointment time and date for a doctor
@app.route('/api/doctor-appointment', methods=['POST'])
def get_doctor_appointment():
    doctor_name = request.args.get('doctor_name')
    email = request.args.get('email')
    contact_no = request.args.get('contactno')
    hospital_name = request.args.get('hospital_name')

    if not (doctor_name and email and contact_no and hospital_name):
        return jsonify({"error": "Missing required parameters"}), 400

    connection = get_db_connection()
    cursor = connection.cursor(dictionary=True)

    query = """
        SELECT 
            dh.appointment_date,
            dh.appointment_time
        FROM 
            Doctor_Hospital dh
        JOIN 
            Doctors d ON dh.doctor_id = d.doctor_id
        JOIN 
            Hospitals h ON dh.hospital_id = h.hospital_id
        WHERE 
            d.name = %s AND d.email = %s AND d.phone_number = %s AND h.name = %s
    """
    cursor.execute(query, (doctor_name, email, contact_no, hospital_name))
    appointment = cursor.fetchone()
    cursor.close()
    connection.close()

    if not appointment:
        return jsonify({"error": "No appointment found"}), 404

    return jsonify({
        "AppointmentDate": appointment['appointment_date'],
        "AppointmentTime": format_time(appointment['appointment_time'])
    })


# Route to get appointment time and date for a test
@app.route('/api/test-appointment', methods=['POST'])
def get_test_appointment():
    test_name = request.args.get('test_name')
    hospital_name = request.args.get('hospital_name')

    if not (test_name and hospital_name):
        return jsonify({"error": "Missing required parameters"}), 400

    connection = get_db_connection()
    cursor = connection.cursor(dictionary=True)

    query = """
        SELECT 
            ht.appointment_date,
            ht.appointment_time
        FROM 
            Hospital_Tests ht
        JOIN 
            Hospitals h ON ht.hospital_id = h.hospital_id
        JOIN 
            Tests t ON ht.test_id = t.test_id
        WHERE 
            t.name = %s AND h.name = %s
    """
    cursor.execute(query, (test_name, hospital_name))
    appointment = cursor.fetchone()
    cursor.close()
    connection.close()

    if not appointment:
        return jsonify({"error": "No appointment found"}), 404

    return jsonify({
        "AppointmentDate": appointment['appointment_date'],
        "AppointmentTime": format_time(appointment['appointment_time'])
    })

@app.route('/api/test', methods=['GET'])
def get_test():
    return jsonify({"message": "Hello World"}), 200

if __name__ == '__main__':
    app.run(debug=True, port=5001)