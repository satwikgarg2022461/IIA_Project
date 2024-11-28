from flask import Flask, request, jsonify
import psycopg2
from nltk.sem.chat80 import sql_query
from psycopg2.extras import Json
from psycopg2.extras import RealDictCursor
import datetime
import requests
import random
from flask_cors import CORS


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
CORS(app)


@app.after_request
def add_cors_headers(response):
    response.headers.add("Access-Control-Allow-Origin", "http://localhost:5173")
    response.headers.add("Access-Control-Allow-Headers", "Content-Type,Authorization")
    response.headers.add("Access-Control-Allow-Methods", "GET,POST,OPTIONS")
    response.headers.add("Access-Control-Allow-Credentials", "true")
    return response

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


@app.route("/test", methods=["GET"])
def test():
    query = """SELECT * FROM doctor"""
    try:
        with conn.cursor() as cur:
            cur.execute(query)
            result = cur.fetchall()  # Use fetchall() to get all rows, not just one
            if result:
                # Convert the result to a list of dictionaries
                columns = [desc[0] for desc in cur.description]  # Get column names
                result_list = [dict(zip(columns, row)) for row in result]
                return jsonify(result_list)  # Return the result as a JSON response
            else:
                return jsonify({"error": "Test or hospital not found"}), 404
    except Exception as e:
        return jsonify({"error": str(e)}), 500
import time
import time
@app.route("/get-doctor-info", methods=["POST"])
def get_doctor_info():
    doctor_base = """
        SELECT 
            d.d_name, d.phone, d.email, d.speciality, d.experience, d.education,
            h.h_name AS hospital_name, ad.time, ad.date, ad.price, ad.status
        FROM Doctor d
        LEFT JOIN Appointment_doctor ad ON d.d_id = ad.d_id
        LEFT JOIN Hospital h ON ad.h_id = h.h_id
    """
    data = request.get_json()
    doctor_name = data.get("name")
    speciality = data.get("speciality")

    filters = []
    values = []

    if doctor_name:
        filters.append("d.d_name LIKE %s")
        values.append(f"%{doctor_name}%")

    if speciality:
        filters.append("d.speciality LIKE %s")
        values.append(f"%{speciality}%")

    where_clause = f"WHERE {' AND '.join(filters)}" if filters else ""
    query = f"{doctor_base} {where_clause}"

    def call_api(url, params=None, retries=0):
        """Try to call an API with retries."""
        attempts = 0
        while attempts <= retries:
            try:
                response = requests.get(url, params=params)
                if response.status_code == 200:
                    return response.json()
            except Exception as e:
                print(f"Error calling API at {url} on attempt {attempts + 1}: {e}")
            attempts += 1
            time.sleep(2)  # Wait for 2 seconds before retrying
        return None  # Return None if all attempts fail

    # Check test API endpoints before processing results
    api_5000_status = call_api("http://localhost:5000/api/test")
    api_5001_status = call_api("http://localhost:5001/api/test")

    if api_5000_status is None or api_5001_status is None:
        with conn.cursor(cursor_factory=RealDictCursor) as cur:
            cur.execute(query, tuple(values))
            results = cur.fetchall()
            for result in results:
                result["time"] = format_time(result["time"])
            return jsonify(results)


    try:
        with conn.cursor(cursor_factory=RealDictCursor) as cur:
            cur.execute(query, tuple(values))
            results = cur.fetchall()

            for result in results:
                params = {
                    "doctor_name": result["d_name"],
                    "email": result["email"],
                    "contactno": result["phone"],
                    "hospital_name": result["hospital_name"]
                }
                responses = []

                # Call the first API with retry mechanism
                api_data_5000 = call_api("http://localhost:5000/api/appointmentdoctor", params)
                if api_data_5000:
                    responses.append(api_data_5000[0])  # Add the first record from API 5000

                # Call the second API with retry mechanism
                api_data_5001 = call_api("http://localhost:5001/api/appointments-doctor", params)
                if api_data_5001:
                    responses.append(api_data_5001[0])  # Add the first record from API 5001

                # If we got responses from any API
                if responses:
                    selected_response = random.choice(responses)
                    result["date"] = selected_response.get("AppointmentDate", result["date"])
                    result["time"] = format_time(selected_response.get("AppointmentTime", result["time"]))
                else:
                    # Fall back to the existing data
                    result["time"] = format_time(result["time"])

            return jsonify(results)

    except Exception as e:
        return jsonify({"error": str(e)}), 500





@app.route("/get-test-info", methods=["POST"])
def get_test_info():
    test_base = """
        SELECT 
            t.t_name, t.description, t.cost, h.h_name AS hospital_name, 
            at.time, at.date, at.status
        FROM Test t
        LEFT JOIN Appointment_test at ON t.t_id = at.t_id
        LEFT JOIN Hospital h ON at.h_id = h.h_id
    """

    data = request.get_json()
    # Get query parameters
    test_name = data.get("t_name")
    hospital_name = data.get("h_name")

    # Apply filters using LIKE for partial matching
    filters = []
    if test_name:
        filters.append("t.t_name LIKE %s")
    if hospital_name:
        filters.append("h.h_name LIKE %s")

    where_clause = f"WHERE {' AND '.join(filters)}" if filters else ""
    query = f"{test_base} {where_clause}"

    # Values for the query placeholders with wildcard for LIKE
    values = tuple(filter(None, [f"%{test_name}%" if test_name else None,
                                 f"%{hospital_name}%" if hospital_name else None]))

    def call_api(url, params=None, retries=0):
        """Try to call an API with retries."""
        attempts = 0
        while attempts <= retries:
            try:
                response = requests.get(url, params=params)
                if response.status_code == 200:
                    return response.json()
            except Exception as e:
                print(f"Error calling API at {url} on attempt {attempts + 1}: {e}")
            attempts += 1
            time.sleep(2)  # Wait for 2 seconds before retrying
        return None

    api_5000_status = call_api("http://localhost:5000/api/test")
    api_5001_status = call_api("http://localhost:5001/api/test")

    if api_5000_status is None or api_5001_status is None:
        try:
            with conn.cursor(cursor_factory=RealDictCursor) as cur:
                cur.execute(query, values)
                results = cur.fetchall()
                for result in results:
                    result["time"] = format_time(result["time"])
                return jsonify(results)
        except Exception as e:
            return jsonify({"error": str(e)}), 500

    try:
        with conn.cursor(cursor_factory=RealDictCursor) as cur:
            cur.execute(query, values)
            results = cur.fetchall()

            for result in results:
                # Prepare data for the external API calls
                params = {
                    "test_name": result["t_name"],
                    "hospital_name": result["hospital_name"]
                }
                responses = []

                # Query the first API
                try:
                    response_5000 = requests.get("http://localhost:5000/api/appointmenttest", params=params)
                    if response_5000.status_code == 200:
                        api_data_5000 = response_5000.json()
                        if api_data_5000:  # Ensure the list is not empty
                            responses.append(api_data_5000[0])  # Take the first record
                except Exception as e:
                    print(f"Error calling API on port 5000: {e}")

                # Query the second API
                try:
                    response_5001 = requests.get("http://localhost:5001/api/appointments-test", params=params)
                    if response_5001.status_code == 200:
                        api_data_5001 = response_5001.json()
                        if api_data_5001:  # Ensure the list is not empty
                            responses.append(api_data_5001[0])  # Take the first record
                except Exception as e:
                    print(f"Error calling API on port 5001: {e}")

                # Use a response if available
                if responses:
                    # Choose one response (e.g., randomly or by priority)
                    selected_response = random.choice(responses)
                    result["date"] = selected_response.get("AppointmentDate", result["date"])
                    result["time"] = format_time(selected_response.get("AppointmentTime", result["time"]))
                else:
                    # Fall back to the existing data
                    result["time"] = format_time(result["time"])

            return jsonify(results)
    except Exception as e:
        return jsonify({"error": str(e)}), 500



@app.route("/get-hospital-info", methods=["POST"])
def get_hospital_info():

    hospital_base = """
        SELECT 
            h_name AS hospital_name, 
            email AS hospital_email, 
            address AS hospital_address, 
            speciality AS hospital_speciality
        FROM hospital
    """

    data = request.get_json()

    # Get query parameters
    hospital_name = data.get('name')
    speciality = data.get('specialty')

    # Apply filters based on provided parameters
    filters = []
    values = []

    if hospital_name:
        filters.append("h_name = %s")
        values.append(hospital_name)

    if speciality:
        # Use SQL LIKE to search within the comma-separated speciality column
        filters.append("speciality LIKE %s")
        values.append(f"%{speciality}%")

    where_clause = f"WHERE {' AND '.join(filters)}" if filters else ""
    query = f"{hospital_base} {where_clause}"

    try:
        with conn.cursor(cursor_factory=RealDictCursor) as cur:
            cur.execute(query, tuple(values))
            results = cur.fetchall()
            return jsonify(results)
    except Exception as e:
        return jsonify({"error": str(e)}), 500


# import openai

# client = OpenAI()

# Set up OpenAI API Key (replace with your key)
# OpenAI.api_key = "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"




@app.route("/LLM", methods=["POST"])
def generate_and_execute_query():
    try:
        data = request.get_json()
        query = data.get("query")
        import os
        import google.generativeai as genai

        genai.configure(api_key="AIzaSyADuAM_NP8YBkKiNu45wKopqpOVetl4lXY")

        # Create the model
        generation_config = {
            "temperature": 1,
            "top_p": 0.95,
            "top_k": 40,
            "max_output_tokens": 8192,
            "response_mime_type": "text/plain",
        }

        model = genai.GenerativeModel(
            model_name="gemini-1.5-flash",
            generation_config=generation_config,
        )

        chat_session = model.start_chat(
            history=[
            ]
        )

        prompt = f"""
        Database Schema:
    doctor table: d_id, d_name, phone, email, address, speciality, experience, education, h_id[]
    appointment_doctor table: ad_id, d_id, h_id, time, date, price, status
    hospital table: h_id, h_name, email, address, speciality
    test table: t_id, t_name, description, cost
    appointment_test table: at_id, t_id, h_id, time, date, status
    SQL Query Rules:
    The schema is a postgresql schema
    Only use the schema provided above and take no other assumption for schema
    Start with SELECT as all queries are for fetching data.
    Queries must align with the given database schema and reference the correct tables and columns.
    Avoid placeholders (like ? or $1). Use explicit conditions or fixed values where necessary.
    Queries should be deterministic—producing the same result for the same input.
    Write a single SQL query unless explicitly required otherwise.
    Ensure the query retrieves all necessary fields as requested in the prompt.
    Queries should be case-insensitive (use lowercase SQL syntax).
    If the prompt mentions a specific limit (e.g., "top 5"), ensure the query uses the LIMIT clause to restrict results.
    Understand the natural language query before constructing the SQL.
    If you cannot generate a query than don't generate any code to create a new table but if you can answer the query by just not showing some attributes do it
    Prompts:
    Top 5 doctors based on experience
    "Write an SQL query to fetch the top 5 doctors with the highest experience from the doctor table. Include the columns d_id, d_name, and experience, and sort the results in descending order of experience. Limit the output to 5 rows."
    
    Find doctors associated with a specific hospital
    "Write an SQL query to list all doctors associated with a specific hospital. Use the doctor table and retrieve the columns d_id, d_name, and speciality. Filter results where the provided hospital ID is present in the h_id array column."
    
    List all appointments for a specific doctor on a given date
    "Write an SQL query to fetch all appointments for a doctor on a specific date from the appointment_doctor table. Include ad_id, h_id, time, price, and status. Filter by the given doctor’s d_id and the specified date in the date column."
    
    Find hospitals offering a specific speciality
    "Write an SQL query to find all hospitals offering a specific speciality. Use the hospital table and retrieve the columns h_id, h_name, and address. Filter by the provided speciality in the speciality column."
    
    List all tests and their costs
    "Write an SQL query to fetch the details of all tests from the test table. Include the columns t_id, t_name, and cost, and sort the results alphabetically by t_name."
    
    Find all tests scheduled at a hospital on a specific date
    "Write an SQL query to retrieve all scheduled tests at a specific hospital on a given date from the appointment_test table. Include the columns at_id, t_id, time, and status. Filter results by the hospital ID (h_id) and date in the date column."
    
    Count of appointments per doctor
    "Write an SQL query to count the total number of appointments for each doctor from the appointment_doctor table and doctor table. Group the results by d_id and include the columns d_id, d_name and total_appointments. Sort the results by total_appointments in descending order."
    
    Find the total revenue from doctor appointments
    "Write an SQL query to calculate the total revenue generated from doctor appointments in the appointment_doctor table. Sum the price column and return the result as total_revenue."
    
    Fetch hospital details with most scheduled tests
    "Write an SQL query to identify the hospital with the highest number of scheduled tests. Use the appointment_test table to count the appointments per h_id, and join with the hospital table to retrieve the hospital’s h_id, h_name, and address. Sort by the count in descending order and limit the output to 1 row."
    
    Fetch details of doctors with no hospital associations
    "Write an SQL query to find all doctors who are not associated with any hospital. Use the doctor table and retrieve the columns d_id and d_name. Filter results where the h_id array column is null or empty."
    
    
    
        User query: "{query}"
    
        Generate the SQL query in PostgreSQL syntax.
        """

        response = chat_session.send_message(f'{prompt}')

        print(response.text)
        sql_query = response.text

        sql_query = sql_query[6:-4].strip()
        print("Generated SQL Query:", sql_query)

        with conn.cursor() as cur:
            try:
                cur.execute(sql_query)
                if cur.description:  # If the query returns results
                    results = cur.fetchall()
                    columns = [desc[0] for desc in cur.description]
                    data = [dict(zip(columns, row)) for row in results]
                    return jsonify({"query": sql_query, "results": data})
                else:  # If the query doesn't return results (e.g., UPDATE, DELETE)
                    conn.commit()
                    return jsonify({"query": sql_query, "message": "Query executed successfully"})
            except Exception as e:
                conn.rollback()  # Rollback the transaction
                return jsonify({"error": "Transaction failed and has been rolled back", "details": str(e)}), 400

    except Exception as e:
        return jsonify({"error": "An error occurred", "details": str(e)}), 500




# Main entry point
if __name__ == "__main__":
    app.run(debug=True, port=5002)