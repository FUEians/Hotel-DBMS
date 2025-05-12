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
(3, 'Golden Bloom Hotel - Chicago', 'chicago@goldenbloom.com', 4.6),
(4, 'Golden Bloom Hotel - Miami', 'miami@goldenbloom.com', 4.3),
(5, 'Golden Bloom Hotel - Seattle', 'seattle@goldenbloom.com', 4.4),
(6, 'Golden Bloom Hotel - Houston', 'houston@goldenbloom.com', 3.2),
(7, 'Golden Bloom Hotel - Boston', 'boston@goldenbloom.com', 4.6),
(8, 'Golden Bloom Hotel - Denver', 'denver@goldenbloom.com', 2.1),
(9, 'Golden Bloom Hotel - Orlando', 'orlando@goldenbloom.com', 1.5),
(10, 'Golden Bloom Hotel - Atlanta', 'atlanta@goldenbloom.com', 4.0);

INSERT INTO Hotel_Location VALUES
(1, 'New York', 'New York City', '123 Luxury Lane'),
(2, 'California', 'Los Angeles', '456 Ocean Ave'),
(3, 'Illinois', 'Chicago', '789 River Road'),
(4, 'Florida', 'Miami', '321 Beach Blvd'),
(5, 'Washington', 'Seattle', '654 Pine Street'),
(6, 'Texas', 'Houston', '789 Lone Star Road'),
(7, 'Massachusetts', 'Boston', '456 Freedom Trail'),
(8, 'Colorado', 'Denver', '888 Mountain View'),
(9, 'Florida', 'Orlando', '222 Theme Park Rd'),
(10, 'Georgia', 'Atlanta', '333 Peachtree St');

INSERT INTO Hotel_ContactNumber VALUES
('+1234567890', 1),
('+1234567891', 2),
('+1234567892', 3),
('+1234567893', 4),
('+1234567894', 5),
('+1234567895', 6),
('+1234567896', 7),
('+1234567897', 8),
('+1234567898', 9),
('+1234567899', 10);

INSERT INTO Employee VALUES
(101, 'john.doe@example.com', '+1987654321', 'Morning', 'Front Desk Manager', 50000.00, 1, 'John', 'Doe', NULL),
(102, 'jane.smith@example.com', '+1987654322', 'Afternoon', 'Receptionist', 35000.00, 2, 'Jane', 'Smith', 101),
(103, 'alice.johnson@example.com', '+1987654323', 'Night', 'Security Officer', 38000.00, 3, 'Alice', 'Johnson', 101),
(104, 'mark.lee@example.com', '+1987654324', 'Morning', 'Chef', 42000.00, 4, 'Mark', 'Lee', 101),
(105, 'susan.kim@example.com', '+1987654325', 'Afternoon', 'Concierge', 39000.00, 5, 'Susan', 'Kim', 102),
(106, 'eric.wilson@example.com', '+1987654326', 'Night', 'Housekeeper', 37000.00, 6, 'Eric', 'Wilson', 103),
(107, 'nina.patel@example.com', '+1987654327', 'Morning', 'Front Desk', 36000.00, 7, 'Nina', 'Patel', 101),
(108, 'leo.brown@example.com', '+1987654328', 'Afternoon', 'Bartender', 34000.00, 8, 'Leo', 'Brown', 102),
(109, 'ella.davis@example.com', '+1987654329', 'Night', 'Manager', 52000.00, 9, 'Ella', 'Davis', NULL),
(110, 'ryan.taylor@example.com', '+1987654330', 'Morning', 'Receptionist', 35500.00, 10, 'Ryan', 'Taylor', 109);

INSERT INTO Guest VALUES
(2001, 'anna.smith@example.com', '+1122334455', 'Anna', 'Marie', 'Smith'),
(2002, 'thomas.jones@example.com', '+1122334456', 'Thomas', 'A.', 'Jones'),
(2003, 'olivia.baker@example.com', '+1122334457', 'Olivia', '', 'Baker'),
(2004, 'michael.scott@example.com', '+1122334458', 'Michael', 'Gary', 'Scott'),
(2005, 'pam.beesly@example.com', '+1122334459', 'Pam', 'Morgan', 'Beesly'),
(2006, 'jim.halpert@example.com', '+1122334460', 'Jim', '', 'Halpert'),
(2007, 'dwight.schrute@example.com', '+1122334461', 'Dwight', '', 'Schrute'),
(2008, 'angela.martin@example.com', '+1122334462', 'Angela', '', 'Martin'),
(2009, 'kevin.malone@example.com', '+1122334463', 'Kevin', '', 'Malone'),
(2010, 'stanley.hudson@example.com', '+1122334464', 'Stanley', '', 'Hudson');

INSERT INTO Payment VALUES
(3001, '2025-04-01', 'Credit Card', 2001, 'Completed'),
(3002, '2025-04-02', 'Debit Card', 2002, 'Pending'),
(3003, '2025-04-03', 'PayPal', 2003, 'Completed'),
(3004, '2025-04-04', 'Credit Card', 2004, 'Completed'),
(3005, '2025-04-05', 'Debit Card', 2005, 'Pending'),
(3006, '2025-04-06', 'PayPal', 2006, 'Completed'),
(3007, '2025-04-07', 'Credit Card', 2007, 'Completed'),
(3008, '2025-04-08', 'Cash', 2008, 'Pending'),
(3009, '2025-04-09', 'Credit Card', 2009, 'Failed'),
(3010, '2025-04-10', 'PayPal', 2010, 'Completed');

INSERT INTO Service VALUES
(5001, 25.00, 'Room Service - Breakfast', 3001),
(5002, 15.00, 'Room Service - Lunch', 3002),
(5003, 50.00, 'Spa Package', 3003),
(5004, 30.00, 'Room Service - Dinner', 3004),
(5005, 20.00, 'Laundry Service', 3005),
(5006, 45.00, 'Massage Therapy', 3006),
(5007, 60.00, 'City Tour', 3007),
(5008, 10.00, 'Welcome Drink', 3008),
(5009, 70.00, 'Airport Pickup', 3009),
(5010, 55.00, 'Private Gym Session', 3010);

INSERT INTO Employee_Provides_Service  VALUES
(5001, 101),
(5002, 102),
(5003, 103),
(5004, 104),
(5005, 105),
(5006, 106),
(5007, 107),
(5008, 108),
(5009, 109),
(5010, 110);

INSERT INTO Guest_Receives_Services VALUES
(5001, 2001),
(5002, 2002),
(5003, 2003),
(5004, 2004),
(5005, 2005),
(5006, 2006),
(5007, 2007),
(5008, 2008),
(5009, 2009),
(5010, 2010);

INSERT INTO LoyaltyCard VALUES
(9001, '2024-01-15', '2025-01-15', 2001, 150),
(9002, '2024-02-10', '2025-02-10', 2002, 200),
(9003, '2024-03-05', '2025-03-05', 2003, 100),
(9004, '2024-04-10', '2025-04-10', 2004, 180),
(9005, '2024-05-01', '2025-05-01', 2005, 120),
(9006, '2024-05-10', '2025-05-10', 2006, 300),
(9007, '2024-06-01', '2025-06-01', 2007, 250),
(9008, '2024-06-15', '2025-06-15', 2008, 170),
(9009, '2024-07-01', '2025-07-01', 2009, 220),
(9010, '2024-07-10', '2025-07-10', 2010, 200);

INSERT INTO Room VALUES
(101, 'Standard', 'Good', 2, 150.00, 1),
(102, 'Deluxe', 'Excellent', 2, 200.00, 2),
(103, 'Suite', 'Excellent', 4, 300.00, 3),
(104, 'Deluxe', 'Good', 2, 180.00, 4),
(105, 'Suite', 'Excellent', 3, 250.00, 5),
(106, 'Standard', 'Fair', 1, 120.00, 6),
(107, 'Executive', 'Excellent', 2, 275.00, 7),
(108, 'Penthouse', 'Excellent', 4, 400.00, 8),
(109, 'Standard', 'Good', 2, 150.00, 9),
(110, 'Deluxe', 'Good', 2, 200.00, 10);

INSERT INTO Reservation VALUES
(4001, 'Confirmed', '2025-04-05', '2025-04-10', '14:00:00', '12:00:00', 'Non-smoking room', 3001, 2001, 101, 1),
(4002, 'Cancelled', '2025-04-06', '2025-04-11', '15:00:00', '11:00:00', 'King bed required', 3002, 2002, 102, 2),
(4003, 'Pending', '2025-04-07', '2025-04-12', '13:00:00', '10:00:00', 'Near elevator', 3003, 2003, 103, 3),
(4004, 'Confirmed', '2025-04-11', '2025-04-15', '14:00:00', '12:00:00', 'Late check-in', 3004, 2004, 104, 4),
(4005, 'Pending', '2025-04-12', '2025-04-16', '15:00:00', '11:00:00', 'Extra towels', 3005, 2005, 105, 5),
(4006, 'Cancelled', '2025-04-13', '2025-04-17', '13:00:00', '10:00:00', 'No room cleaning', 3006, 2006, 106, 6),
(4007, 'Confirmed', '2025-04-14', '2025-04-18', '14:00:00', '12:00:00', 'Sea-facing room', 3007, 2007, 107, 7),
(4008, 'Pending', '2025-04-15', '2025-04-19', '15:00:00', '11:00:00', 'Early check-in', 3008, 2008, 108, 8),
(4009, 'Cancelled', '2025-04-16', '2025-04-20', '13:00:00', '10:00:00', 'Quiet room', 3009, 2009, 109, 9),
(4010, 'Confirmed', '2025-04-17', '2025-04-21', '14:00:00', '12:00:00', 'High floor', 3010, 2010, 110, 10);

