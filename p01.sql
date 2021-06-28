-- 
-- Database I (ITEC 340)
-- Summer 2021
-- Initial Real Estate project schema. 
--

-- Clean Up Database Objects 
DROP TABLE Properties;
DROP TABLE Customers;

DROP SEQUENCE Cust_ID_Seq;
DROP SEQUENCE Property_Seq;


CREATE TABLE Customers
(
        Cust_ID         NUMBER
,       First           VARCHAR2(15)
,       Last            VARCHAR2(15)
,       DOB             DATE
,       Gender          CHAR(1)
,       Street_Address  VARCHAR2(20)
,       City            VARCHAR2(15)
,       State           CHAR(2) CHECK (State IN('NY','NJ','PA'))
,       Zipcode        VARCHAR2(5)   NOT NULL
,       Phone    VARCHAR2(12)
,       CONSTRAINT PK_Customer PRIMARY KEY (Cust_ID)
);

CREATE TABLE Properties
(
        Listing_ID         NUMBER
,       Cust_ID         NUMBER
,       Listing_Date       DATE
,       Price           NUMBER    NOT NULL
,       Num_Bedrooms    NUMBER(4)
,       Num_Baths       NUMBER(4,1)
,       Square_Feet     NUMBER
,       Street_Address  VARCHAR2(20)
,       City            VARCHAR2(15)
,       State           CHAR(2)
,       Zipcode        CHAR(5)  NOT NULL
,       CONSTRAINT PK_Property  PRIMARY KEY (Listing_ID)
,       CONSTRAINT FK_Prop_Cust FOREIGN KEY (Cust_ID) REFERENCES Customers
,       CONSTRAINT UK_Property  UNIQUE  (Street_Address, City, State, Zipcode)
);


-- Create Sequences
CREATE SEQUENCE Cust_ID_Seq
        START WITH 705
        INCREMENT BY 1;

CREATE SEQUENCE Property_Seq
        START WITH 1007
        INCREMENT BY 1;

--
-- Load Customers
--
INSERT INTO Customers (Cust_ID, first, last, DOB, Gender, Street_Address, City, State, Zipcode, Phone)
VALUES(Cust_ID_Seq.nextval, 'Mike', 'Logan', '13-NOVEMBER-1954', 'M', '901 Main St', 'New York', 'NY', '10029', '212-555-1212');

INSERT INTO Customers (Cust_ID, first, last, DOB, Gender, Street_Address, City, State, Zipcode, Phone)
VALUES(Cust_ID_Seq.nextval, 'Lenny', 'Brisco', '20-OCTOBER-1935', 'M', '1212 9th St', 'New York', 'NY', '10037', '212-345-8957');

INSERT INTO Customers (Cust_ID, first, last, DOB, Gender, Street_Address, City, State, Zipcode, Phone)
VALUES(Cust_ID_Seq.nextval, 'Claire', 'Kincaid', '25-NOVEMBER-1968', 'F', '116 Cedar St', 'Millville', 'NJ', '08332', '856-327-0847');

INSERT INTO Customers (Cust_ID, first, last, DOB, Gender, Street_Address, City, State, Zipcode, Phone)
VALUES(Cust_ID_Seq.nextval, 'Jack', 'McCoy', '15-NOVEMBER-1940', 'M', '366 Orange Rd', 'Albany', 'NY', '12206', '518-432-4599');

INSERT INTO Customers (Cust_ID, first, last, DOB, Gender, Street_Address, City, State, Zipcode, Phone)
VALUES(Cust_ID_Seq.nextval, 'Nora', 'Lewin', '28-MARCH-1948', 'F', '1158 Kennedy Blvd', 'Bayonne', 'NJ', '07002', '856-339-0873');


-- 
-- Load Properties
-- 
INSERT INTO Properties (Listing_ID, Cust_ID, Listing_Date, Price, Num_Bedrooms, Num_Baths, Square_Feet, Street_Address, City, State, Zipcode)
VALUES(Property_Seq.nextval, 706, '03-MAY-2021', 1299000, 5, 4, '3700', '1212 9th St', 'New York', 'NY', '10037');

INSERT INTO Properties (Listing_ID, Cust_ID, Listing_Date, Price, Num_Bedrooms, Num_Baths, Square_Feet, Street_Address, City, State, Zipcode)
VALUES(Property_Seq.nextval, 708, '27-APRIL-2021', 749000, 5, 2.5, '2200', '366 Orange Rd', 'Albany', 'NY', '12206');

INSERT INTO Properties (Listing_ID, Cust_ID, Listing_Date, Price, Num_Bedrooms, Num_Baths, Square_Feet, Street_Address, City, State, Zipcode)
VALUES(Property_Seq.nextval, 705, '21-MAY-2021', 299000, 3, 2, '1750', '901 Main St', 'New York', 'NY', '10029');


