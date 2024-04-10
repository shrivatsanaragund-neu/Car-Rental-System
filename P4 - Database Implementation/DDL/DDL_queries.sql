CREATE TABLE Store
(
    StoreID INT IDENTITY(1,1) PRIMARY KEY,
    StreetAddress VARCHAR(255) NOT NULL,
    City VARCHAR(100) NOT NULL,
    [State] VARCHAR(100) NOT NULL,
    Country VARCHAR(100) NOT NULL,
    Contact_No BIGINT UNIQUE NOT NULL,
    Email_Address VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE Employee
(
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    StoreID INT NOT NULL,
    Supervisor_ID INT NOT NULL,
    First_Name VARCHAR(255) NOT NULL,
    Last_Name VARCHAR(255) NOT NULL,
    Contact_No BIGINT UNIQUE NOT NULL,
    Email_Address VARCHAR(255) UNIQUE NOT NULL,
    City VARCHAR(100) NOT NULL,
    [State] VARCHAR(100) NOT NULL,
    Country VARCHAR(100) NOT NULL,

    CONSTRAINT EmpFK1 FOREIGN KEY(StoreID) REFERENCES Store(StoreID),
    CONSTRAINT EmpFK2 FOREIGN KEY(Supervisor_ID) REFERENCES Employee(EmployeeID)
);

CREATE TABLE Car_Category
(
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    Category_Name VARCHAR(100) CONSTRAINT Category_Name_CHK CHECK (Category_Name IN ('SUV', 'Sedan', 'Hatchback', 'Van', 'Sports Car', 'Mini Van')) NOT NULL,
    Hourly_Rate DECIMAL(9,2) NOT NULL,
    Weekly_Rate DECIMAL(9,2) NULL,
    Monthly_Rate DECIMAL(9,2) NULL
);

CREATE TABLE Car
(
    CarID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryID INT NOT NULL,
    StoreID INT NOT NULL,
    Make VARCHAR(100) NOT NULL,
    Model VARCHAR(100) NOT NULL,
    Fuel_Type VARCHAR(100) CONSTRAINT Fuel__Type_CHK CHECK (Fuel_Type IN ('EV', 'Petrol', 'Diesel')) NOT NULL,
    YearOfManufacturing INT NOT NULL,
    Condition VARCHAR(100) NULL,
    License_Plate_Number VARCHAR(20) UNIQUE NOT NULL,
    Color VARCHAR(50),
    [Availability] VARCHAR(10) CONSTRAINT Availability_CHK CHECK ([Availability] IN ('TRUE', 'FALSE')) NOT NULL,
    Transmission_Type VARCHAR(50) CONSTRAINT Transmission_Type_CHK CHECK (Transmission_Type IN ('Manual', 'Automatic')) NOT NULL,

    CONSTRAINT CarFK1 FOREIGN KEY(CategoryID) REFERENCES Car_Category(CategoryID),
    CONSTRAINT CarFK2 FOREIGN KEY(StoreID) REFERENCES Store(StoreID)
);

CREATE TABLE Maintenance
(
    MaintenanceID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeID INT NOT NULL,
    CarID INT NOT NULL,
    MaintenanceDate DATE NOT NULL,
    MaintenanceDetails VARCHAR(1500) NOT NULL,
    CONSTRAINT MaintenanceFK1 FOREIGN KEY(EmployeeID) REFERENCES Employee(EmployeeID),
    CONSTRAINT MaintenanceFK2 FOREIGN KEY(CarID) REFERENCES Car(CarID)
);

CREATE TABLE Customer
(
    CustomerID INT NOT NULL,
    Driver_LicenseNo VARBINARY(MAX) NOT NULL,
    FirstName VARCHAR(255) NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    ContactNo BIGINT UNIQUE NOT NULL,
    Email_Address varchar(50) unique NOT NULL,

    CONSTRAINT CustomerPK PRIMARY KEY(CustomerID)
);


CREATE TABLE Reservation
(
    ReservationID INT NOT NULL IDENTITY(1,1),
    CustomerID INT NOT NULL,
    CarID INT NOT NULL,
    Pickup_Date_and_Time DATETIME NOT NULL,
    Return_Date_and_Time DATETIME NOT NULL,
    Opt_Insurance VARCHAR(10) NOT NULL CONSTRAINT OPT_INSURANCE_CHK CHECK (Opt_Insurance IN ('TRUE', 'FALSE')),

    CONSTRAINT ReservationsPK PRIMARY KEY(ReservationID),
    CONSTRAINT ReservationsFK1 FOREIGN KEY(CustomerID) REFERENCES Customer(CustomerID),
    CONSTRAINT ReservationsFK2 FOREIGN KEY(CarID) REFERENCES Car(CarID),
    CONSTRAINT PickupBeforeReturn CHECK (Pickup_Date_and_Time < Return_Date_and_Time)
);

CREATE TABLE Support
(
    RequestID INT IDENTITY(1,1) PRIMARY KEY,
    ReservationID INT NOT NULL,
    CustomerID INT NOT NULL,
    EmployeeID INT NOT NULL,
    Support_Type VARCHAR(255) NOT NULL,
    Support_Description VARCHAR(2000) NULL,
    Support_Status VARCHAR(10) CONSTRAINT Support_Status_CHECK CHECK (Support_Status IN ('Open', 'Closed', 'Pending')) NOT NULL,
    CONSTRAINT SupportsFK1 FOREIGN KEY(ReservationID) REFERENCES Reservation(ReservationID),
    CONSTRAINT SupportsFK2 FOREIGN KEY(CustomerID) REFERENCES Customer(CustomerID),
    CONSTRAINT SupportsFK3 FOREIGN KEY(EmployeeID) REFERENCES Employee(EmployeeID)
);

CREATE TABLE Insurance
(
    InsuranceID INT IDENTITY(1,1) NOT NULL,
    ReservationID INT NOT NULL,
    Coverage_Type VARCHAR(100) NOT NULL,
    Coverage_Amount DECIMAL(9,2) NOT NULL,

    CONSTRAINT InsurancesPK PRIMARY KEY(InsuranceID),
    CONSTRAINT InsurancesFK1 FOREIGN KEY(ReservationID) REFERENCES Reservation(ReservationID)
);
GO

CREATE TABLE Return_and_Inspection
(
    InspectionID INT IDENTITY(1,1) NOT NULL,
    -- Adding IDENTITY for auto-increment
    ReservationID INT NOT NULL,
    EmployeeID INT NOT NULL,
    InspectionDate DATETIME NOT NULL,
    InspectionOutcome VARCHAR(100) NOT NULL,
    Damage_Details VARCHAR(2000) NOT NULL,
    Feedback VARCHAR(1000) NULL,

    CONSTRAINT Return_InspectionsPK PRIMARY KEY(InspectionID),
    CONSTRAINT Return_InspectionsFK1 FOREIGN KEY(ReservationID) REFERENCES Reservation(ReservationID),
    CONSTRAINT Return_InspectionsFK2 FOREIGN KEY(EmployeeID) REFERENCES Employee(EmployeeID)
);
GO

CREATE TABLE Billing
(
    BillingID INT IDENTITY(1,1) PRIMARY KEY,
    ReservationID INT NOT NULL,
    InspectionID INT NOT NULL,
    Bill_Amount_Total DECIMAL(9,2) NOT NULL,
    Bill_Amount_Due DECIMAL(9,2) NOT NULL,
    Payment_Date DATETIME NOT NULL,
    Payment_Status VARCHAR(20) CONSTRAINT Payment_Status_CHECK CHECK (Payment_Status IN ('Success', 'Failed', 'In Progress')) NOT NULL,
    Payment_Mode VARCHAR(20) CONSTRAINT Payment_Mode_CHECK CHECK (Payment_Mode IN ('Cash', 'Credit/Debit Card', 'Google Pay', 'Apple Pay')) NOT NULL,
    Billing_Statement VARCHAR(8000) NOT NULL,

    CONSTRAINT BillingsFK1 FOREIGN KEY(ReservationID) REFERENCES Reservation(ReservationID),
    CONSTRAINT BillingsFK2 FOREIGN KEY(InspectionID) REFERENCES Return_and_Inspection(InspectionID)
);