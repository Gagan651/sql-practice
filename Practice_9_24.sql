-- Create the patients table
use 
CREATE TABLE patients (
    patient_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    gender CHAR(1),
    birth_date DATE,
    contact_number VARCHAR(15)
);

-- Create the doctors table
CREATE TABLE doctors (
    doctor_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    specialty VARCHAR(100),
    department_id INT,
    contact_number VARCHAR(15)
);

-- Create the departments table
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

-- Create the appointments table
CREATE TABLE appointments (
    appointment_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATE,
    diagnosis VARCHAR(255),
    treatment_id INT,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id),
    FOREIGN KEY (treatment_id) REFERENCES treatments(treatment_id)
);

-- Create the treatments table
CREATE TABLE treatments (
    treatment_id INT PRIMARY KEY,
    treatment_name VARCHAR(100),
    cost DECIMAL(10, 2)
);

-- Insert sample patients
INSERT INTO patients (patient_id, first_name, last_name, gender, birth_date, contact_number) 
VALUES
(1, 'John', 'Doe', 'M', '1985-06-15', '555-1234'),
(2, 'Jane', 'Smith', 'F', '1990-02-20', '555-5678'),
(3, 'Alice', 'Johnson', 'F', '1975-12-10', '555-8765');

-- Insert sample doctors
INSERT INTO doctors (doctor_id, first_name, last_name, specialty, department_id, contact_number)
VALUES
(1, 'David', 'Miller', 'Cardiologist', 1, '555-2345'),
(2, 'Emily', 'Clark', 'Neurologist', 2, '555-3456'),
(3, 'Michael', 'Brown', 'Pediatrician', 3, '555-4567');

-- Insert sample departments
INSERT INTO departments (department_id, department_name) 
VALUES
(1, 'Cardiology'),
(2, 'Neurology'),
(3, 'Pediatrics');

-- Insert sample treatments
INSERT INTO treatments (treatment_id, treatment_name, cost)
VALUES
(1, 'Heart Surgery', 25000.00),
(2, 'MRI Scan', 500.00),
(3, 'Vaccination', 50.00);

-- Insert sample appointments
INSERT INTO appointments (appointment_id, patient_id, doctor_id, appointment_date, diagnosis, treatment_id)
VALUES
(1, 1, 1, '2024-09-15', 'Heart Disease', 1),
(2, 2, 2, '2024-09-17', 'Migraine', 2),
(3, 3, 3, '2024-09-19', 'Flu', 3);

INSERT INTO appointments (appointment_id, patient_id, doctor_id, appointment_date, diagnosis, treatment_id)
VALUES
(4, 1, 1, '2024-09-30', 'Hypertension', 1),
(5, 2, 3, '2024-09-30', 'Fever', 3);


select * from patients;
select * from doctors;
select * from departments;
select * from appointments;
select * from treatments;


#Find all appointments scheduled for the current date.

select * from appointments where appointment_date=curdate();

#List all doctors and their corresponding department names.

select * from doctors s join departments d on s.department_id=d.department_id;

#Find the total number of appointments for each doctor.

select doctor_id,count(appointment_id) from appointments group by doctor_id;

#Get the total cost of treatments given to each patient.
with cte as
(select patient_id,sum(cost) from appointments a join treatments t on a.treatment_id=t.treatment_id group by patient_id)
select first_name,c.* from patients p join cte c on p.patient_id=c.patient_id;
