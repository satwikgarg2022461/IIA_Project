-- Create the Doctor table
CREATE TABLE Doctor (
    d_id SERIAL PRIMARY KEY,
    d_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15),
    email VARCHAR(100),
    address TEXT,
    speciality VARCHAR(50),
    experience INT,
    education TEXT,
    h_id INTEGER[],
    counting INT,
    source TEXT[]
);

-- Create the Hospital table
CREATE TABLE Hospital (
    h_id SERIAL PRIMARY KEY,
    h_name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    address TEXT,
    speciality VARCHAR(50),
    counting INT,
    source TEXT[]
);

-- Create the Test table
CREATE TABLE Test (
    t_id SERIAL PRIMARY KEY,
    t_name VARCHAR(100) NOT NULL,
    description TEXT,
    cost INT,
    counting INT,
    source TEXT[]
);

-- Create the Appointment_doctor table
CREATE TABLE Appointment_doctor (
    ad_id SERIAL PRIMARY KEY,
    d_id INT REFERENCES Doctor(d_id) ON DELETE CASCADE,
    h_id INT REFERENCES Hospital(h_id) ON DELETE CASCADE,
    time TIME NOT NULL,
    date DATE NOT NULL,
    price INT,
    status INT,
    counting INT,
    source TEXT[]
);

-- Create the Appointment_test table
CREATE TABLE Appointment_test (
    at_id SERIAL PRIMARY KEY,
    t_id INT REFERENCES Test(t_id) ON DELETE CASCADE,
    h_id INT REFERENCES Hospital(h_id) ON DELETE CASCADE,
    time TIME NOT NULL,
    date DATE NOT NULL,
    status INT,
    counting INT,
    source TEXT[]
);
