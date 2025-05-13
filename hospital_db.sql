
// Hospital Database Management System
// Author:   Lynn Jemosop Cheptumo
// Description: SQL script to create and define hospital DB


// Drop tables if they already exist (for re-runs)
DROP TABLE IF EXISTS Appointment_Doctor;
DROP TABLE IF EXISTS Appointments;
DROP TABLE IF EXISTS Doctors;
DROP TABLE IF EXISTS Patients;
DROP TABLE IF EXISTS Departments;
DROP TABLE IF EXISTS Rooms;


// Table: Departments
// One department has many doctors
  
CREATE TABLE Departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE
);

// Table: Rooms
// One-to-One: Each room assigned to one patient

CREATE TABLE Rooms (
    room_id INT AUTO_INCREMENT PRIMARY KEY,
    room_number VARCHAR(10) NOT NULL UNIQUE,
    room_type VARCHAR(50) NOT NULL,
    is_available BOOLEAN DEFAULT TRUE
);


// Table: Patients
// Each patient may have a room (1-1)
CREATE TABLE Patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    phone VARCHAR(20) UNIQUE,
    email VARCHAR(100) UNIQUE,
    room_id INT UNIQUE,
    FOREIGN KEY (room_id) REFERENCES Rooms(room_id)
);

// Table: Doctors
// Many doctors belong to one department
// One doctor can have many appointments

CREATE TABLE Doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    specialization VARCHAR(100),
    department_id INT NOT NULL,
    phone VARCHAR(20) UNIQUE,
    email VARCHAR(100) UNIQUE,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

// Table: Appointments
// One patient can have many appointments
// One appointment can involve multiple doctors (M:M)

CREATE TABLE Appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_date DATETIME NOT NULL,
    patient_id INT NOT NULL,
    reason TEXT,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);


// Table: Appointment_Doctor (Join Table for M:M)
// Many-to-Many: Appointments <-> Doctors

CREATE TABLE Appointment_Doctor (
    appointment_id INT,
    doctor_id INT,
    PRIMARY KEY (appointment_id, doctor_id),
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

