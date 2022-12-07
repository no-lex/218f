# Drop existing tables

DROP TABLE IF EXISTS Room;
DROP TABLE IF EXISTS RoomRates;
DROP TABLE IF EXISTS Booking;
DROP TABLE IF EXISTS Loyalty;
DROP TABLE IF EXISTS Payment;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Hotel;

SHOW TABLES;
# create hotel table

CREATE TABLE Hotel
(
    HotelCode   INT UNSIGNED NOT NULL,
    Address     VARCHAR(100) NOT NULL,
    City        VARCHAR(100) NOT NULL,
    StateCode   CHAR(2) NOT NULL,
    ZIPCode     VARCHAR(10) NOT NULL,
    PhoneNumber CHAR(12) NOT NULL,
    NumRooms    INT UNSIGNED NOT NULL,

    PRIMARY KEY (hotelCode)
) ENGINE = InnoDB;

INSERT INTO Hotel VALUES ('1','1234 5th St', 'Des Moines', 'WA', '98198-0004', '012531234567', '69');
INSERT INTO Hotel VALUES ('2','1234 6th St', 'Federal Way', 'WA', '98003-0004', '012061234567', '70');

# create employee table

CREATE TABLE Employee
(
    EmployeeID  INT UNSIGNED NOT NULL,
    FirstName   VARCHAR(40) NOT NULL,
    LastName    VARCHAR(40) NOT NULL,
    Salary      INT UNSIGNED NOT NULL,
    JobTitle    VARCHAR(100) NOT NULL,
    Details     VARCHAR(100),
    HotelCode   INT UNSIGNED NOT NULL,
    
    PRIMARY KEY (EmployeeID),
    FOREIGN KEY (HotelCode) REFERENCES Hotel (HotelCode)
) ENGINE = InnoDB;

INSERT INTO Employee VALUES ('1', 'Joe', 'Joeseon', '42069', 'Executive Janitor', 'Senior Executive', '1');

# create customer table

CREATE TABLE Customer
(
    CustomerID  INT UNSIGNED NOT NULL,
    FirstName   VARCHAR(40) NOT NULL,
    LastName    VARCHAR(40) NOT NULL,
    Address     VARCHAR(100) NOT NULL,
    City        VARCHAR(100) NOT NULL,
    StateCode   CHAR(2) NOT NULL,
    ZIPCode     VARCHAR(10) NOT NULL,
    Country     CHAR(2) NOT NULL,
    
    PRIMARY KEY (CustomerID)
) ENGINE = InnoDB;

INSERT INTO Customer VALUES('123', 'Robert', 'Robertson', '5432 1st St', 'Des Moines', 'WA', '98198', 'US');

# create loyalty table

CREATE TABLE Loyalty
(
    LoyaltyID       INT UNSIGNED NOT NULL,
    LoyaltyLevel    VARCHAR(100) NOT NULL,
    Points          INT UNSIGNED NOT NULL,
    MemberSince     DATE NOT NULL,
    CustomerID      INT UNSIGNED NOT NULL,
    
    PRIMARY KEY (LoyaltyID),
    FOREIGN KEY (CustomerID) REFERENCES Customer (CustomerID)
    
) ENGINE = InnoDB;

INSERT INTO Loyalty VALUES('1', 'Gold', '100', '2022-12-01', '123');

# create payment table

CREATE TABLE Payment
(
    PaymentID       INT UNSIGNED NOT NULL,
    RoomCharge      FLOAT UNSIGNED NOT NULL,
    RoomService     VARCHAR(100) NOT NULL,
    PaymentDate     DATE NOT NULL,
    PaymentMode     VARCHAR(100) NOT NULL,
    CreditCardNo    CHAR(16),
    CreditCardCVC   CHAR(3),
    CardExpireDate  DATE,
    CustomerID      INT UNSIGNED NOT NULL,
    
    PRIMARY KEY (PaymentID),
    FOREIGN KEY (CustomerID) REFERENCES Customer (CustomerID)

) ENGINE = InnoDB;

INSERT INTO Payment VALUES ('2', '137.99', 'Breakfast', '2022-12-01', 'Credit', '1234123412341234', '123', '2022-12-02', '123');

# create booking table

CREATE TABLE Booking
(
    BookingID   INT UNSIGNED NOT NULL,
    CheckIn     DATE NOT NULL,
    CheckOut    DATE NOT NULL,
    SpecialReq  VARCHAR(100),
    HotelCode   INT UNSIGNED NOT NULL,
    CustomerID  INT UNSIGNED NOT NULL,
    EmployeeID  INT UNSIGNED NOT NULL,
    PaymentID   INT UNSIGNED NOT NULL,
    
    PRIMARY KEY (BookingID),
    FOREIGN KEY (HotelCode) REFERENCES Hotel (HotelCode),
    FOREIGN KEY (CustomerID) REFERENCES Customer (CustomerID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee (EmployeeID),
    FOREIGN KEY (PaymentID) REFERENCES Payment (PaymentID)
) ENGINE = InnoDB;

INSERT INTO Booking VALUES ('124', '2022-12-01', '2022-12-02', 'Pet', '1', '123', '1', '2');

# create roomprice table

CREATE TABLE RoomRates
(
    RoomRateID      INT UNSIGNED NOT NULL,
    RoomPrice       FLOAT UNSIGNED NOT NULL,
    DefaultPrice    FLOAT UNSIGNED NOT NULL,
    
    PRIMARY KEY (RoomRateID)
) ENGINE = InnoDB;

INSERT INTO RoomRates VALUES ('0', '102.5', '96.0');

# create room table

CREATE TABLE Room
(
    RoomNo      INT UNSIGNED NOT NULL,
    RoomName    VARCHAR(100),
    RoomDesc    VARCHAR(200),
    Occupation  BOOL NOT NULL,
    RoomRateID  INT UNSIGNED NOT NULL,
    BookingID   INT UNSIGNED NOT NULL,
    EmployeeID  INT UNSIGNED NOT NULL,
    
    PRIMARY KEY (RoomNo),
    FOREIGN KEY (RoomRateID) REFERENCES RoomRates (RoomRateID),
    FOREIGN KEY (BookingID) REFERENCES Booking (BookingID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee (EmployeeID)
) ENGINE = InnoDB;

INSERT INTO Room VALUES ('101', NULL, '2 Queen', FALSE, '0', '124', '1');
