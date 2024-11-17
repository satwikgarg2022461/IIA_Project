from sqlalchemy import create_engine, text
from fastapi import FastAPI
from fastapi.encoders import jsonable_encoder
from datetime import datetime, date
import json

# Define the connection string
conn_string = "postgresql://hospitals_owner:39DypXfFaUNc@ep-square-poetry-a1lp3z2x.ap-southeast-1.aws.neon.tech/hospitals?sslmode=require"

# Create the SQLAlchemy engine
engine = create_engine(conn_string)

# Initialize FastAPI
app = FastAPI()

# Test the connection by executing a simple query
try:
    conn = engine.connect()
    print("Connected to the database")

    @app.get("/")
    async def root():
        query = text("SELECT table_name FROM information_schema.tables WHERE table_schema='public'")
        result = conn.execute(query)
        tables = [row[0] for row in result.fetchall()]
        return {"message": {"tables": tables}}
    
    @app.get("/patients")
    async def get_patients():
        query = text("SELECT * FROM patient")
        result = conn.execute(query)
        patients = result.fetchall()
        result_data = [tuple(record.strftime("%d-%m-%Y") if isinstance(record, (date, datetime)) else record for record in row) for row in patients]
        return {"message": {"schema": list(result.keys()), "data": list(result_data)}}
    
    @app.get("/specialty")
    async def get_specialty():
        query = text("SELECT * FROM specialty")
        result = conn.execute(query)
        specialty = [tuple(row) for row in result.fetchall()]
        result_data = [tuple(record.strftime("%d-%m-%Y") if isinstance(record, (date, datetime)) else record for record in row) for row in specialty]
        return {"message": {"schema": list(result.keys()), "data": list(result_data)}}
    
    @app.get("/room")
    async def get_room():
        query = text("SELECT * FROM room")
        result = conn.execute(query)
        room = [tuple(row) for row in result.fetchall()]
        result_data = [tuple(record.strftime("%d-%m-%Y") if isinstance(record, (date, datetime)) else record for record in row) for row in room]
        return {"message": {"schema": list(result.keys()), "data": list(result_data)}}
    
    @app.get("/staff")
    async def get_staff():
        query = text("SELECT * FROM staff")
        result = conn.execute(query)
        staff = [tuple(row) for row in result.fetchall()]
        result_data = [tuple(record.strftime("%d-%m-%Y") if isinstance(record, (date, datetime)) else record for record in row) for row in staff]
        return {"message": {"schema": list(result.keys()), "data": list(result_data)}}
    
    @app.get("/insurance")
    async def get_insurance():
        query = text("SELECT * FROM insurance")
        result = conn.execute(query)
        insurance = [tuple(row) for row in result.fetchall()]
        result_data = [tuple(record.strftime("%d-%m-%Y") if isinstance(record, (date, datetime)) else record for record in row) for row in insurance]
        return {"message": {"schema": list(result.keys()), "data": list(result_data)}}
    
    @app.get("/treatment_record")
    async def get_treatment_record():
        query = text("SELECT * FROM treatment_record")
        result = conn.execute(query)
        treatment_record = [tuple(row) for row in result.fetchall()]
        result_data = [tuple(record.strftime("%d-%m-%Y") if isinstance(record, (date, datetime)) else record for record in row) for row in treatment_record]
        return {"message": {"schema": list(result.keys()), "data": list(result_data)}}
    
    @app.get("/hospital_details")
    async def get_hospital_details():
        query = text("SELECT * FROM hospital_details")
        result = conn.execute(query)
        hospital_details = [tuple(row) for row in result.fetchall()]
        result_data = [tuple(record.strftime("%d-%m-%Y") if isinstance(record, (date, datetime)) else record for record in row) for row in hospital_details]
        return {"message": {"schema": list(result.keys()), "data": list(result_data)}}

    @app.get("/medical_equipment")
    async def get_medical_equipment():
        query = text("SELECT * FROM medical_equipment")
        result = conn.execute(query)
        medical_equipment = [tuple(row) for row in result.fetchall()]
        result_data = [tuple(record.strftime("%d-%m-%Y") if isinstance(record, (date, datetime)) else record for record in row) for row in medical_equipment]
        return {"message": {"schema": list(result.keys()), "data": list(result_data)}}

    @app.get("/test")
    async def get_test():
        query = text("SELECT * FROM test")
        result = conn.execute(query)
        test = [tuple(row) for row in result.fetchall()]
        result_data = [tuple(record.strftime("%d-%m-%Y") if isinstance(record, (date, datetime)) else record for record in row) for row in test]
        return {"message": {"schema": list(result.keys()), "data": list(result_data)}}

    @app.get("/doctor")
    async def get_doctor():
        query = text("SELECT * FROM doctor")
        result = conn.execute(query)
        doctor = [tuple(row) for row in result.fetchall()]
        result_data = [tuple(record.strftime("%d-%m-%Y") if isinstance(record, (date, datetime)) else record for record in row) for row in doctor]
        return {"message": {"schema": list(result.keys()), "data": list(result_data)}}

    @app.get("/appointment")
    async def get_appointment():
        query = text("SELECT * FROM appointment")
        result = conn.execute(query)
        appointment = [tuple(row) for row in result.fetchall()]
        result_data = [tuple(record.strftime("%d-%m-%Y") if isinstance(record, (date, datetime)) else record for record in row) for row in appointment]
        return {"message": {"schema": list(result.keys()), "data": list(result_data)}}
    
except Exception as e:
    print("Error connecting to the database:", e)
