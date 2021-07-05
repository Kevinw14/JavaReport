DROP TABLE Offer_Details;
DROP TABLE Offer;
DROP TABLE Listing;
DROP TABLE Owner;
DROP TABLE Property;
DROP TABLE Approval_Details;
DROP TABLE Preapproval;
DROP TABLE Customer;
DROP TABLE Address;

DROP SEQUENCE Prop_Seq;
DROP SEQUENCE Address_Seq;
DROP SEQUENCE Cust_Seq;
DROP SEQUENCE Approval_Seq;
DROP SEQUENCE Offer_Seq;
DROP SEQUENCE Listing_Seq;

CREATE TABLE Address(
    Address_No NUMBER,
    Street_Num VARCHAR2(7),
    Street_Name VARCHAR2(50),
    City VARCHAR2(25),
    State CHAR(2),
    Zipcode CHAR(5),
    CONSTRAINT AddressPK PRIMARY KEY (Address_No)
);

CREATE TABLE Property(
    Prop_ID NUMBER,
    Address NUMBER NOT NULL,
    Num_Bedrooms NUMBER,
    Num_Baths NUMBER(3,1),
    Sq_Feet NUMBER,
    CONSTRAINT PropertyPK PRIMARY KEY (Prop_ID),
    CONSTRAINT PropertyAddressFK FOREIGN KEY (Address) REFERENCES Address
);

CREATE TABLE Customer(
    Cust_ID NUMBER,
    First VARCHAR2(25),
    Last VARCHAR2(25),
    DOB DATE,
    Gender CHAR(1),
    Phone CHAR(12),
    Residence NUMBER,
    CONSTRAINT CustomerPK PRIMARY KEY (Cust_ID),
    CONSTRAINT CustomerAddressFK FOREIGN KEY (Residence) REFERENCES Address
);

CREATE TABLE Owner(
    Cust_ID NUMBER,
    Prop_ID NUMBER,
    Purchase_Date DATE,
    CONSTRAINT OwnerPK PRIMARY KEY (Cust_ID, Prop_ID, Purchase_Date),
    CONSTRAINT OwnerCustFK FOREIGN KEY (Cust_ID) REFERENCES Customer,
    CONSTRAINT OwnerPropFK FOREIGN KEY (Prop_ID) REFERENCES Property
);

CREATE TABLE Listing(
    Listing_ID NUMBER,
    Prop_ID NUMBER,
    List_Date DATE,
    Price NUMBER,
    Status VARCHAR2(6),
    CONSTRAINT ListingPK PRIMARY KEY (Listing_ID),
    CONSTRAINT ListingPropFK FOREIGN KEY (Prop_ID) REFERENCES Property,
    CONSTRAINT ListingStatusCK CHECK (Status IN ('open', 'pending', 'canceled', 'closed'))
);

CREATE TABLE Offer(
    Offer_No NUMBER,
    Cust_ID NUMBER,
    Listing_ID NUMBER,
    CONSTRAINT OfferPK PRIMARY KEY (Offer_No, Cust_ID),
    CONSTRAINT OfferCustFK FOREIGN KEY (Cust_ID) REFERENCES Customer,
    CONSTRAINT OfferListingFK FOREIGN KEY (Listing_ID) REFERENCES Listing
);

CREATE TABLE Preapproval(
    Approval_No NUMBER,
    Cust_ID NUMBER,
    CONSTRAINT PreapprovalPK PRIMARY KEY (Approval_No),
    CONSTRAINT PreapprovalCustFK FOREIGN KEY (Cust_ID) REFERENCES Customer
);

CREATE TABLE Offer_Details(
    Offer_No NUMBER,
    Offer_Date DATE,
    Exp_Date DATE,
    Amount NUMBER,
    Status VARCHAR2(8),
    Approval_No NUMBER,
    CONSTRAINT OfferDetailPK PRIMARY KEY (Offer_No),
    CONSTRAINT OfferDetailFK FOREIGN KEY (Offer_No) REFERENCES Offer,
    CONSTRAINT OfferApprovalFK FOREIGN KEY (Approval_No) REFERENCES Preapproval,
    CONSTRAINT OfferDetailsCK CHECK (Status IN ('accepted', 'counter', 'declined'))
);


CREATE TABLE Approval_Details(
    Approval_No NUMBER,
    Approval_Date DATE,
    Exp_Date DATE,
    Lender VARCHAR2(25),
    Amount NUMBER,
    CONSTRAINT ApprovalDetailPK PRIMARY KEY (Approval_No),
    CONSTRAINT ApprovalDetailFK FOREIGN KEY (Approval_No) REFERENCES Preapproval
);


CREATE SEQUENCE Cust_Seq
    START WITH 1
    INCREMENT BY 1
;

CREATE SEQUENCE Prop_Seq
    START WITH 1
    INCREMENT BY 1
;

CREATE SEQUENCE Address_Seq
    START WITH 1
    INCREMENT BY 1
;

CREATE SEQUENCE Offer_Seq
    START WITH 1
    INCREMENT BY 1
;

CREATE SEQUENCE Approval_Seq
    START WITH 1
    INCREMENT BY 1
;

CREATE SEQUENCE Listing_Seq
    START WITH 1
    INCREMENT BY 1
;

INSERT INTO Address(Address_No, Street_Num, Street_Name, City, State, Zipcode) VALUES(Address_Seq.nextval, '901', 'Main St', 'New York', 'NY', '10029');
INSERT INTO Address(Address_No, Street_Num, Street_Name, City, State, Zipcode) VALUES(Address_Seq.nextval, '459', 'Chestnut St', 'Nutley', 'NJ', '07110');
INSERT INTO Address(Address_No, Street_Num, Street_Name, City, State, Zipcode) VALUES(Address_Seq.nextval, '2303', 'Peach St', 'Erie', 'PA', '16502');
INSERT INTO Address(Address_No, Street_Num, Street_Name, City, State, Zipcode) VALUES(Address_Seq.nextval, '34338', 'Stoughton Drive', 'Brooklyn', 'NY', '11225');
INSERT INTO Address(Address_No, Street_Num, Street_Name, City, State, Zipcode) VALUES(Address_Seq.nextval, '0', 'Hoepker Hill', 'Trenton', 'NJ', '08603');
INSERT INTO Address(Address_No, Street_Num, Street_Name, City, State, Zipcode) VALUES(Address_Seq.nextval, '8602', '4th Parkway', 'Philadelphia', 'PA', '19160');
INSERT INTO Address(Address_No, Street_Num, Street_Name, City, State, Zipcode) VALUES(Address_Seq.nextval, '2126', 'Summit Street', 'Syracuse', 'NY', '13217');

INSERT INTO Customer(Cust_ID, First, Last, DOB, Gender, Residence, Phone) VALUES(Cust_Seq.nextval, 'Josee', 'Sawney', '13-Nov-1954', 'F', 1, '119-732-2819');
INSERT INTO Customer(Cust_ID, First, Last, DOB, Gender, Residence, Phone) VALUES(Cust_Seq.nextval, 'Barnaby', 'Hawkings', '20-Oct-1935', 'M', 2, '473-946-3922');
INSERT INTO Customer(Cust_ID, First, Last, DOB, Gender, Residence, Phone) VALUES(Cust_Seq.nextval, 'Darda', 'Alliot', '15-Nov-1940', 'F', 2, '183-636-1456');
INSERT INTO Customer(Cust_ID, First, Last, DOB, Gender, Residence, Phone) VALUES(Cust_Seq.nextval, 'Lyon', 'Lawdham', '5-May-1985', 'M', 3, '775-335-5644')
INSERT INTO Customer(Cust_ID, First, Last, DOB, Gender, Residence, Phone) VALUES(Cust_Seq.nextval, 'Gunther', 'Laffoley-Lane', '25-Feb-1989', 'M', 3, '751-883-1771')
INSERT INTO Customer(Cust_ID, First, Last, DOB, Gender, Residence, Phone) VALUES(Cust_Seq.nextval, 'Bianca', 'Ebanks', '19-Aug-1965', 'F', 3, '985-713-1017')
INSERT INTO Customer(Cust_ID, First, Last, DOB, Gender, Residence, Phone) VALUES(Cust_Seq.nextval, 'Rozina', 'Boken', '01-Dec-1964', 'F', 4, '540-442-3971')
INSERT INTO Customer(Cust_ID, First, Last, DOB, Gender, Residence, Phone) VALUES(Cust_Seq.nextval, 'Beaufort', 'Ordish', '29-Jan-1983', 'M', 5, '940-155-9681')
INSERT INTO Customer(Cust_ID, First, Last, DOB, Gender, Residence, Phone) VALUES(Cust_Seq.nextval, 'Jodi', 'Spurr', '26-Jun-1984', 'M', 6, '375-257-2993')

INSERT INTO Property(Prop_ID, Address, Num_Bedrooms, Num_Baths, Sq_Feet) VALUES(Prop_Seq.nextval, 1, 4, 3, 3200);
INSERT INTO Property(Prop_ID, Address, Num_Bedrooms, Num_Baths, Sq_Feet) VALUES(Prop_Seq.nextval, 2, 3, 2, 1750);
INSERT INTO Property(Prop_ID, Address, Num_Bedrooms, Num_Baths, Sq_Feet) VALUES(Prop_Seq.nextval, 3, 5, 2.5, 2200);

INSERT INTO Owner(Cust_ID, Prop_ID, Purchase_Date) VALUES(1, 1, '23-May-2005');
INSERT INTO Owner(Cust_ID, Prop_ID, Purchase_Date) VALUES(2, 2, '4-Apr-1993');
INSERT INTO Owner(Cust_ID, Prop_ID, Purchase_Date) VALUES(3, 2, '4-Apr-1993');
INSERT INTO Owner(Cust_ID, Prop_ID, Purchase_Date) VALUES(4, 3, '13-Oct-2013');
INSERT INTO Owner(Cust_ID, Prop_ID, Purchase_Date) VALUES(5, 3, '13-Oct-2013');
INSERT INTO Owner(Cust_ID, Prop_ID, Purchase_Date) VALUES(6, 3, '13-Oct-2013');

INSERT INTO Listing(Listing_ID, Prop_ID, List_Date, Price, Status) VALUES(Listing_Seq.nextval, 1, '07-Feb-2021', 295150, 'open');
INSERT INTO Listing(Listing_ID, Prop_ID, List_Date, Price, Status) VALUES(Listing_Seq.nextval, 2, '15-May-2021', 599000, 'open');
INSERT INTO Listing(Listing_ID, Prop_ID, List_Date, Price, Status) VALUES(Listing_Seq.nextval, 3, '19-May-2020', 1250000, 'closed');

INSERT INTO Preapproval(Approval_No, Cust_ID) VALUES(Approval_Seq.nextval, 4);
INSERT INTO Preapproval(Approval_No, Cust_ID) VALUES(Approval_Seq.nextval, 5);
INSERT INTO Preapproval(Approval_No, Cust_ID) VALUES(Approval_Seq.nextval, 6);
INSERT INTO Preapproval(Approval_No, Cust_ID) VALUES(Approval_Seq.nextval, 6);

INSERT INTO Approval_Details(Approval_No, Approval_Date, Exp_Date, Lender, Amount) VALUES(1, '09-Feb-2021', '09-Mar-2021', 'Bank of America', 350000);
INSERT INTO Approval_Details(Approval_No, Approval_Date, Exp_Date, Lender, Amount) VALUES(2, '18-May-2021', '18-Jun-2021', 'Capital One', 650000);
INSERT INTO Approval_Details(Approval_No, Approval_Date, Exp_Date, Lender, Amount) VALUES(3, '20-Jun-2020', '20-Jul-2020', 'Capital One', 15000000);
INSERT INTO Approval_Details(Approval_No, Approval_Date, Exp_Date, Lender, Amount) VALUES(4, '20-Jun-2020', '20-Jul-2020', 'Wells Fargo', 14000000);

INSERT INTO Offer(Offer_No, Cust_ID, Listing_ID) VALUES(Offer_Seq.nextval, 4, 1);
INSERT INTO Offer(Offer_No, Cust_ID, Listing_ID) VALUES(Offer_Seq.nextval, 5, 2);
INSERT INTO Offer(Offer_No, Cust_ID, Listing_ID) VALUES(Offer_Seq.nextval, 6, 3);

INSERT INTO Offer_Details(Offer_No, Offer_Date, Exp_Date, Amount, Status, Approval_No) VALUES(1, '10-Feb-2021', '17-Feb-2021', 295000, 'accepted', 1);
INSERT INTO Offer_Details(Offer_No, Offer_Date, Exp_Date, Amount, Status, Approval_No) VALUES(2, '19-May-2021', '26-May-2021', 600000, 'declined', 2);
INSERT INTO Offer_Details(Offer_No, Offer_Date, Exp_Date, Amount, Status, Approval_No) VALUES(3, '02-Jul-2020', '09-Jul-2020', 1230000, 'accepted', 3);

COMMIT;