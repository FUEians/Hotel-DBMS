CREATE DATABASE Hotel_Management;
USE Hotel_Management;

DROP TABLE IF EXISTS Guest_Receives_Services;
DROP TABLE IF EXISTS Employee_Provides_Service;
DROP TABLE IF EXISTS Reservation;
DROP TABLE IF EXISTS LoyaltyCard;
DROP TABLE IF EXISTS Payment;
DROP TABLE IF EXISTS Room;
DROP TABLE IF EXISTS Hotel_ContactNumber;
DROP TABLE IF EXISTS Hotel_Location;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Guest;
DROP TABLE IF EXISTS Service;
DROP TABLE IF EXISTS Hotel;

-- Table: Hotel
CREATE TABLE Hotel (
    Hotel_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100) unique,
    Rating DECIMAL(2,1) CHECK (Rating BETWEEN 0 AND 5)
);

-- Table: Hotel_Location
CREATE TABLE Hotel_Location (
     Hotel_ID INT NOT NULL,
    state VARCHAR(50),
    city VARCHAR(50),
    street VARCHAR(100),
	PRIMARY KEY (Hotel_id, city, street),
    FOREIGN KEY ( Hotel_ID) REFERENCES hotel( Hotel_ID)
);
-- Table: Hotel_ContactNumber
CREATE TABLE Hotel_ContactNumber (
    Contact_number VARCHAR(15),
    Hotel_ID INT,
    PRIMARY KEY (Contact_number, Hotel_ID),
    FOREIGN KEY (Hotel_ID) REFERENCES Hotel(Hotel_ID)
);

-- Table: Employee
CREATE TABLE Employee (
    Employee_ID INT PRIMARY KEY,
    Email VARCHAR(100),
    Phone_number VARCHAR(15),
    Shift VARCHAR(20),
    Position VARCHAR(50),
    Salary DECIMAL(10,2),
    Hotel_ID INT,
    First_name VARCHAR(50),
    Last_name VARCHAR(50),
    Manager_ID INT,
    FOREIGN KEY (Hotel_ID) REFERENCES Hotel(Hotel_ID),
    FOREIGN KEY (Manager_ID) REFERENCES Employee(Employee_ID)
);

-- Table: Service
CREATE TABLE Service (
    Service_number INT PRIMARY KEY,
    Price DECIMAL(10,2),
    Description TEXT,
    Payment_code INT
);

-- Table: Employee_Provides_Service
CREATE TABLE Employee_Provides_Service (
    Service_number INT,
    Employee_ID INT,
    PRIMARY KEY (Service_number, Employee_ID),
    FOREIGN KEY (Service_number) REFERENCES Service(Service_number),
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID)
);

-- Table: Guest
CREATE TABLE Guest (
    Guest_ID INT PRIMARY KEY,
    Email VARCHAR(100) unique ,
    Phone_number VARCHAR(15),
    First_name VARCHAR(50),
    Middle_name VARCHAR(50),
    Last_name VARCHAR(50)
);

-- Table: Guest_Receives_Services
CREATE TABLE Guest_Receives_Services (
    Service_number INT,
    Guest_ID INT,
    PRIMARY KEY (Service_number, Guest_ID),
    FOREIGN KEY (Service_number) REFERENCES Service(Service_number),
    FOREIGN KEY (Guest_ID) REFERENCES Guest(Guest_ID)
);

-- Table: LoyaltyCard
CREATE TABLE LoyaltyCard (
    LoyaltyCard_num INT PRIMARY KEY,
    Issue_date DATE,
    Expiration_date DATE,
    Guest_ID INT,
    Points INT,
    FOREIGN KEY (Guest_ID) REFERENCES Guest(Guest_ID)
);

-- Table: Payment
CREATE TABLE Payment (
    Payment_code INT PRIMARY KEY,
    Payment_date DATE,
    Method VARCHAR(50),
    Guest_ID INT,
    Payment_Status VARCHAR(50) CHECK (Payment_Status IN ('Completed', 'Pending', 'Failed')),
    FOREIGN KEY (Guest_ID) REFERENCES Guest(Guest_ID)
);

-- Table: Room
CREATE TABLE Room (
    Room_number INT,
    Type VARCHAR(50),
    Condition VARCHAR(50),
    Capacity INT,
    Price_per_night DECIMAL(10,2),
    Hotel_ID INT,
    PRIMARY KEY (Room_number, Hotel_ID),
    FOREIGN KEY (Hotel_ID) REFERENCES Hotel(Hotel_ID)
);

-- Table: Reservation
CREATE TABLE Reservation (
    Reservation_code INT PRIMARY KEY,
    Status VARCHAR(50) CHECK (Status IN ('Confirmed', 'Pending', 'Cancelled')),
    Check_in_date DATE,
    Check_out_date DATE,
    Check_in_time TIME,
    Check_out_time TIME,
    Special_requests TEXT,
    Payment_code INT,
    Guest_ID INT,
    Room_number INT,
    Hotel_ID INT,
    FOREIGN KEY (Payment_code) REFERENCES Payment(Payment_code),
    FOREIGN KEY (Guest_ID) REFERENCES Guest(Guest_ID),
    FOREIGN KEY (Room_number, Hotel_ID) REFERENCES Room(Room_number, Hotel_ID)
);

INSERT INTO Hotel VALUES
(1, 'Golden Bloom Hotel - New York', 'nyc@goldenbloom.com', 4.7),
(2, 'Golden Bloom Hotel - Los Angeles', 'la@goldenbloom.com', 4.5),
(3, 'Golden Bloom Hotel - Chicago', 'chicago@goldenbloom.com', 4.6),
(4, 'Golden Bloom Hotel - Miami', 'miami@goldenbloom.com', 4.4),
(5, 'Golden Bloom Hotel - Dallas', 'dallas@goldenbloom.com', 4.3),
(6, 'Golden Bloom Hotel - Seattle', 'seattle@goldenbloom.com', 4.5),
(7, 'Golden Bloom Hotel - Denver', 'denver@goldenbloom.com', 4.6),
(8, 'Golden Bloom Hotel - Boston', 'boston@goldenbloom.com', 4.7),
(9, 'Golden Bloom Hotel - Atlanta', 'atlanta@goldenbloom.com', 4.4),
(10, 'Golden Bloom Hotel - San Francisco', 'sf@goldenbloom.com', 4.6);
