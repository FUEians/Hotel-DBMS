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
    PRIMARY KEY (Hotel_ID),
    FOREIGN KEY (Hotel_ID) REFERENCES hotel(Hotel_ID)
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

-- Table: Guest
CREATE TABLE Guest (
    Guest_ID INT PRIMARY KEY,
    Email VARCHAR(100) unique ,
    Phone_number VARCHAR(15),
    First_name VARCHAR(50),
    Middle_name VARCHAR(50),
    Last_name VARCHAR(50)
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
(3, 'Golden Bloom Hotel - Chicago', 'chicago@goldenbloom.com', 4.6);

INSERT INTO Hotel_Location VALUES
(1, 'New York', 'New York City', '123 Luxury Lane'),
(2, 'California', 'Los Angeles', '456 Ocean Ave'),
(3, 'Illinois', 'Chicago', '789 River Road');

INSERT INTO Hotel_ContactNumber VALUES
('+1234567890', 1),
('+1234567891', 2),
('+1234567892', 3);

INSERT INTO Employee VALUES
(101, 'john.doe@example.com', '+1987654321', 'Morning', 'Front Desk Manager', 50000.00, 1, 'John', 'Doe', NULL),
(102, 'jane.smith@example.com', '+1987654322', 'Afternoon', 'Receptionist', 35000.00, 2, 'Jane', 'Smith', 101),
(103, 'alice.johnson@example.com', '+1987654323', 'Night', 'Security Officer', 38000.00, 3, 'Alice', 'Johnson', 101);

INSERT INTO Guest VALUES
(2001, 'anna.smith@example.com', '+1122334455', 'Anna', 'Marie', 'Smith'),
(2002, 'thomas.jones@example.com', '+1122334456', 'Thomas', 'A.', 'Jones'),
(2003, 'olivia.baker@example.com', '+1122334457', 'Olivia', '', 'Baker');

INSERT INTO Payment VALUES
(3001, '2025-04-01', 'Credit Card', 2001, 'Completed'),
(3002, '2025-04-02', 'Debit Card', 2002, 'Pending'),
(3003, '2025-04-03', 'PayPal', 2003, 'Completed');

INSERT INTO Service VALUES
(5001, 25.00, 'Room Service - Breakfast', 3001),
(5002, 15.00, 'Room Service - Lunch', 3002),
(5003, 50.00, 'Spa Package', 3003);

INSERT INTO Employee_Provides_Service  VALUES
(5001, 101),
(5002, 102),
(5003, 103);

INSERT INTO Guest_Receives_Services VALUES
(5001, 2001),
(5002, 2002),
(5003, 2003);

INSERT INTO LoyaltyCard VALUES
(9001, '2024-01-15', '2025-01-15', 2001, 150),
(9002, '2024-02-10', '2025-02-10', 2002, 200),
(9003, '2024-03-05', '2025-03-05', 2003, 100);

INSERT INTO Room VALUES
(101, 'Standard', 'Good', 2, 150.00, 1),
(102, 'Deluxe', 'Excellent', 2, 200.00, 2),
(103, 'Suite', 'Excellent', 4, 300.00, 3);

INSERT INTO Reservation VALUES
(4001, 'Confirmed', '2025-04-05', '2025-04-10', '14:00:00', '12:00:00', 'Non-smoking room', 3001, 2001, 101, 1),
(4002, 'Cancelled', '2025-04-06', '2025-04-11', '15:00:00', '11:00:00', 'King bed required', 3002, 2002, 102, 2),
(4003, 'Pending', '2025-04-07', '2025-04-12', '13:00:00', '10:00:00', 'Near elevator', 3003, 2003, 103, 3);

