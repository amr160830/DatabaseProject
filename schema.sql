-- Removed vehicles covered in Insurance_Policy

-- Changed condition in Vehicle to one VARCHAR description
    
-- Changed vehicle catalog in Facility
    -- Added Facility FK to vehicle to account for this

-- Removed rental location and return location

-- Changed size of Insurance_Company

CREATE TABLE Insurance_Policy (
    Policy_ID VARCHAR(8) NOT NULL,
    Insurance_Company VARCHAR(50) NOT NULL,
    Insurance_Type VARCHAR(30) NOT NULL,
    PRIMARY KEY (Policy_ID)
);

CREATE TABLE Facility (
    Facility_ID VARCHAR(5) NOT NULL,
    Hours_of_Operation VARCHAR(11) NOT NULL,
    Vehicle_Capacity INT NOT NULL,
    Fac_City VARCHAR(20) NOT NULL,
    Fac_State VARCHAR(20) NOT NULL,
    Fac_Street_Address VARCHAR(30) NOT NULL,
    PRIMARY KEY (Facility_ID)
);

CREATE TABLE Vehicle (
    VIN VARCHAR(17) NOT NULL,
    Facility_ID VARCHAR(5) NOT NULL,
    Year VARCHAR(4) NOT NULL,
    Color VARCHAR(20),
    Current_Mileage DECIMAL(7, 2) NOT NULL,
    Availability_Status BOOLEAN NOT NULL,
    Rental_Rate DECIMAL(5, 2) NOT NULL,
    Gas_Level DECIMAL(2, 2) NOT NULL,
    Make VARCHAR(20) NOT NULL,
    Model VARCHAR(20) NOT NULL,
    Number_of_Seats INT NOT NULL,
    Vehicle_Condition VARCHAR(200),
    MPG INT,
    PRIMARY KEY (VIN),
    FOREIGN KEY (Facility_ID) REFERENCES Facility(Facility_ID)
);

CREATE TABLE Customer (
    Drivers_license_number VARCHAR(8) NOT NULL, 
    City VARCHAR(20) NOT NULL,
    Cust_State VARCHAR(20) NOT NULL,
    Cust_Street_Address VARCHAR(30) NOT NULL,
    Cust_Name VARCHAR(30) NOT NULL,
    Phone_Number VARCHAR(10) NOT NULL,
    Insurance_ID VARCHAR(8),
    Rental_ID VARCHAR(17),
    PRIMARY KEY (Drivers_license_number),
    FOREIGN KEY (Insurance_ID) REFERENCES Insurance_Policy(Policy_ID),
    FOREIGN KEY (Rental_ID) REFERENCES Vehicle(VIN)
);

CREATE TABLE Employee (
    SSN VARCHAR(9) NOT NULL,
    DOB DATE NOT NULL,
    Name VARCHAR(30) NOT NULL,
    Job_Title VARCHAR(20) NOT NULL,
    Phone_Number VARCHAR(10) NOT NULL,
    Salary DECIMAL(7, 2) NOT NULL,
    Employment_Date DATE NOT NULL,
    Emp_City VARCHAR(20) NOT NULL,
    Emp_State VARCHAR(20) NOT NULL,
    Emp_Street_Address VARCHAR(30) NOT NULL,
    Facility_ID VARCHAR(5) NOT NULL,
    PRIMARY KEY (SSN),
    FOREIGN KEY (Facility_ID) REFERENCES Facility(Facility_ID)
);

CREATE TABLE Rents (
    Vehicle_ID VARCHAR(17) NOT NULL,
    Customer_DL VARCHAR(8) NOT NULL,
    Rate DECIMAL(5, 2) NOT NULL,
    Start_Date DATE NOT NULL,
    End_Date DATE NOT NULL,
    Initial_Gas_Level DECIMAL(2, 2) NOT NULL,
    FOREIGN KEY (Vehicle_ID) REFERENCES Vehicle(VIN),
    FOREIGN KEY (Customer_DL) REFERENCES Customer(Drivers_license_number)
);

CREATE TABLE Holds (
    Vehicle_ID VARCHAR(17) NOT NULL,
    Facility_ID VARCHAR(5) NOT NULL,
    FOREIGN KEY (Vehicle_ID) REFERENCES Vehicle(VIN),
    FOREIGN KEY (Facility_ID) REFERENCES Facility(Facility_ID)
);  