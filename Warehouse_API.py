from flask import Flask, request, jsonify
import psycopg2
from psycopg2.extras import Json

# Database connection
DB_HOST = "localhost"
DB_NAME = "IIA_Warehouse"
DB_USER = "postgres"
DB_PASSWORD = "Satwik@07"
PORT = "1234"

conn = psycopg2.connect(
    host=DB_HOST, dbname=DB_NAME, user=DB_USER, password=DB_PASSWORD, port=PORT
)
app = Flask(__name__)


# Helper to execute queries
def execute_query(query, values):
    with conn.cursor() as cur:
        try:
            cur.execute(query, values)
            conn.commit()
        except Exception as e:
            conn.rollback()
            return str(e)
    return None



# Routes
@app.route("/add_doctors", methods=["POST"])
def add_doctor():
    data = request.json
    query = """
        INSERT INTO Doctor (d_name, phone, email, address, speciality, experience, education, h_id)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
    """
    values = (
        data.get("d_name"),
        data.get("phone"),
        data.get("email"),
        data.get("address"),
        data.get("speciality"),
        data.get("experience"),
        data.get("education"),
        data.get("h_name")
    )
    error = execute_query(query, values)
    if error:
        return jsonify({"error": error}), 500
    return jsonify({"message": "Doctor added successfully"})


@app.route("/add_hospital", methods=["POST"])
def add_hospital():
    data = request.json
    print(data)
    query = """
        INSERT INTO Hospital (h_name, email, address, speciality)
        VALUES (%s, %s, %s, %s)
    """
    values = (
        data.get("h_name"),
        data.get("email"),
        data.get("address"),
        data.get("speciality"),
    )
    error = execute_query(query, values)
    if error:
        return jsonify({"error": error,"data":data}), 500
    return jsonify({"message": "Hospital added successfully"})


@app.route("/add_tests", methods=["POST"])
def add_test():
    data = request.json
    query = """
        INSERT INTO Test (t_name, description, cost)
        VALUES (%s, %s, %s)
    """
    values = (
        data.get("t_name"),
        data.get("description"),
        data.get("cost"),
    )
    error = execute_query(query, values)
    if error:
        return jsonify({"error": error}), 500
    return jsonify({"message": "Test added successfully"})


@app.route("/add-appointment-doctor", methods=["POST"])
def add_appointment_doctor():
    data = request.json
    query = """
        INSERT INTO Appointment_doctor (d_id, h_id, time, date, price, status)
        VALUES (%s, %s, %s, %s, %s, %s)
    """
    values = (
        data.get("d_id"),
        data.get("h_id"),
        data.get("time"),
        data.get("date"),
        data.get("price"),
        data.get("status"),
    )
    error = execute_query(query, values)
    if error:
        return jsonify({"error": error}), 500
    return jsonify({"message": "Appointment with doctor added successfully"})


@app.route("/add-appointment-test", methods=["POST"])
def add_appointment_test():
    data = request.json
    query = """
        INSERT INTO Appointment_test (t_id, h_id, time, date, status)
        VALUES (%s, %s, %s, %s, %s)
    """
    values = (
        data.get("t_id"),
        data.get("h_id"),
        data.get("time"),
        data.get("date"),
        data.get("status"),
    )
    error = execute_query(query, values)
    if error:
        return jsonify({"error": error}), 500
    return jsonify({"message": "Appointment with test added successfully"})

@app.route("/hospital-name-id", methods=["GET"])
def get_all_hospitals():
    query = "SELECT h_id, h_name FROM Hospital"
    try:
        with conn.cursor() as cur:
            cur.execute(query)
            results = cur.fetchall()
            # Create a list of dictionaries with h_id and h_name
            hospitals = [{"h_id": row[0], "h_name": row[1]} for row in results]
            return jsonify(hospitals)
    except Exception as e:
        return jsonify({"error": str(e)}), 500


@app.route("/get-hid", methods=["GET"])
def get_hid_by_hname():
    h_name = request.args.get("h_name")
    query = "SELECT h_id FROM Hospital WHERE h_name = %s"
    try:
        with conn.cursor() as cur:
            cur.execute(query, (h_name,))
            result = cur.fetchone()
            if result:
                return jsonify({"h_id": result[0]})
            else:
                return jsonify({"error": "Hospital not found"}), 404
    except Exception as e:
        return jsonify({"error": str(e)}), 500


@app.route("/get-did", methods=["GET"])
def get_did_by_details():
    phone = request.args.get("phone")
    email = request.args.get("email")
    query = """
        SELECT d_id FROM Doctor
        WHERE  phone = %s AND email = %s
    """
    try:
        with conn.cursor() as cur:
            cur.execute(query, (phone, email))
            result = cur.fetchone()
            if result:
                return jsonify({"d_id": result[0]})
            else:
                return jsonify({"error": "Doctor not found"}), 404
    except Exception as e:
        return jsonify({"error": str(e)}), 500


@app.route("/get-tid", methods=["GET"])
def get_tid_by_test_and_hospital():
    t_name = request.args.get("t_name")
    print(t_name)
    query = """
        SELECT Test.t_id FROM Test
        WHERE Test.t_name = %s
    """
    try:
        with conn.cursor() as cur:
            cur.execute(query, (t_name,))
            result = cur.fetchone()
            if result:
                return jsonify({"t_id": result[0]})
            else:
                return jsonify({"error": "Test or hospital not found"}), 404
    except Exception as e:
        return jsonify({"error": str(e)}), 500




# Main entry point
if __name__ == "__main__":
    app.run(debug=True, port=5002)