DROP TABLE Purchases;
DROP TABLE Preapprovals;
DROP TABLE ApprovalDetails;
DROP TABLE OfferParticipants;
DROP TABLE Offers;
DROP TABLE Listings;
DROP TABLE Properties;
DROP TABLE Addresses;
DROP TABLE Customers;

DROP SEQUENCE Prop_Seq;
DROP SEQUENCE Address_Seq;
DROP SEQUENCE Cust_Seq;
DROP SEQUENCE PreApproval_Seq;
DROP SEQUENCE Approval_Seq;
DROP SEQUENCE Offer_Seq;
DROP SEQUENCE Listing_Seq;

CREATE TABLE Customers(
    CustID NUMBER,
    First VARCHAR2(25),
    Last VARCHAR2(25),
    DOB DATE,
    Gender CHAR(1),
    Phone CHAR(12),
    CONSTRAINT CustomerPK PRIMARY KEY (CustID)
);

CREATE TABLE Addresses(
    AddressID NUMBER,
    Street_Num VARCHAR2(7),
    Street_Name VARCHAR2(50),
    City VARCHAR2(25),
    State CHAR(2),
    Zip CHAR(5),
    CustID NUMBER,
    AddressType VARCHAR2(17),
    CONSTRAINT AddressPK PRIMARY KEY (AddressID),
    CONSTRAINT AddressCustFK FOREIGN KEY (CustID) REFERENCES Customers,
    CONSTRAINT AddressTypeCK CHECK (AddressType IN ('primary residence', 'billing', 'shipping', 'business'))
);

CREATE TABLE Properties(
    PropertyID NUMBER,
    AddressID NUMBER,
    Num_Bedrooms NUMBER,
    Num_Baths NUMBER(3,1),
    Sq_Feet NUMBER,
    CONSTRAINT PropertyPK PRIMARY KEY (PropertyID),
    CONSTRAINT PropertyAddressFK FOREIGN KEY (AddressID) REFERENCES Addresses
);

CREATE TABLE Purchases(
    CustID NUMBER,
    PropertyID NUMBER,
    PurchaseDate DATE,
    CONSTRAINT OwnerPK PRIMARY KEY (CustID, PropertyID, PurchaseDate),
    CONSTRAINT OwnerCustFK FOREIGN KEY (CustID) REFERENCES Customers,
    CONSTRAINT OwnerPropFK FOREIGN KEY (PropertyID) REFERENCES Properties
);

CREATE TABLE Listings(
    ListingID NUMBER,
    PropertyID NUMBER,
    ListDate DATE,
    AskingPrice NUMBER,
    Status VARCHAR2(8),
    CONSTRAINT ListingPK PRIMARY KEY (ListingID),
    CONSTRAINT ListingPropFK FOREIGN KEY (PropertyID) REFERENCES Properties,
    CONSTRAINT ListingStatusCK CHECK (Status IN ('open', 'pending', 'canceled', 'closed'))
);

CREATE TABLE Preapprovals(
    PreApprovalID NUMBER,
    CustID NUMBER,
    Amount NUMBER,
    CONSTRAINT PreapprovalPK PRIMARY KEY (PreApprovalID),
    CONSTRAINT PreapprovalCustFK FOREIGN KEY (CustID) REFERENCES Customers
);

CREATE TABLE ApprovalDetails(
    ApprovalID NUMBER,
    ApprovalDate DATE,
    ExpireDate DATE,
    Lender VARCHAR2(25),
    Amount NUMBER,
    CONSTRAINT ApprovalDetailPK PRIMARY KEY (ApprovalID)
);

CREATE TABLE Offers(
    OfferID NUMBER,
    ListingID NUMBER,
    OfferDate DATE,
    ExpireDate DATE,
    OfferAmount NUMBER,
    Status VARCHAR2(8),
    ApprovalNo NUMBER,
    CONSTRAINT OfferPK PRIMARY KEY (OfferID),
    CONSTRAINT OfferDetailsCK CHECK (Status IN ('accepted', 'counter', 'declined')),
    CONSTRAINT OfferListingFK FOREIGN KEY (ListingID) REFERENCES Listings
);

CREATE TABLE OfferParticipants(
    OfferID NUMBER,
    CustID NUMBER,
    CONSTRAINT OfferParticipantPK PRIMARY KEY (OfferID, CustID),
    CONSTRAINT OfferParticipantFK FOREIGN KEY (OfferID) REFERENCES Offers,
    CONSTRAINT OfferParticipantCustFK FOREIGN KEY (CustID) REFERENCES Customers
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

CREATE SEQUENCE PreApproval_Seq
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

INSERT INTO Customers (CustID, First, Last, DOB, Gender, Phone) VALUES (Cust_Seq.nextval, 'Richmound', 'Rosling', '30-Oct-1975', 'M', '680-720-7025');
INSERT INTO Customers (CustID, First, Last, DOB, Gender, Phone) VALUES (Cust_Seq.nextval, 'Willey', 'Yude', '01-Apr-1966', 'M', '165-334-7058');
INSERT INTO Customers (CustID, First, Last, DOB, Gender, Phone) VALUES (Cust_Seq.nextval, 'Kaspar', 'Bentsen', '31-Jul-1970', 'M', '320-681-0221');
INSERT INTO Customers (CustID, First, Last, DOB, Gender, Phone) VALUES (Cust_Seq.nextval, 'Ardene', 'Maus', '26-Jun-1980', 'F', '187-134-0298');
INSERT INTO Customers (CustID, First, Last, DOB, Gender, Phone) VALUES (Cust_Seq.nextval, 'Sauveur', 'Darracott', '05-Feb-1979', 'M', '486-179-7150');
INSERT INTO Customers (CustID, First, Last, DOB, Gender, Phone) VALUES (Cust_Seq.nextval, 'Zandra', 'Meigh', '30-Jul-1976', 'F', '437-988-9503');
INSERT INTO Customers (CustID, First, Last, DOB, Gender, Phone) VALUES (Cust_Seq.nextval, 'Dorey', 'Habin', '21-May-1956', 'F', '273-395-5394');
INSERT INTO Customers (CustID, First, Last, DOB, Gender, Phone) VALUES (Cust_Seq.nextval, 'Donetta', 'Wallwood', '19-Feb-1980', 'F', '851-907-0592');
INSERT INTO Customers (CustID, First, Last, DOB, Gender, Phone) VALUES (Cust_Seq.nextval, 'Aleta', 'Devonshire', '18-Jul-1985', 'F', '107-697-2400');
INSERT INTO Customers (CustID, First, Last, DOB, Gender, Phone) VALUES (Cust_Seq.nextval, 'Joseito', 'Ovise', '08-Jul-1963', 'M', '974-458-7500');
INSERT INTO Customers (CustID, First, Last, DOB, Gender, Phone) VALUES (Cust_Seq.nextval, 'Ashby', 'Minkin', '13-Aug-1994', 'M', '617-444-4461');
INSERT INTO Customers (CustID, First, Last, DOB, Gender, Phone) VALUES (Cust_Seq.nextval, 'Happy', 'Colbeck', '13-Jul-1957', 'F', '430-813-1485');
INSERT INTO Customers (CustID, First, Last, DOB, Gender, Phone) VALUES (Cust_Seq.nextval, 'Osborne', 'Danher', '12-Jun-2000', 'M', '763-450-8144');
INSERT INTO Customers (CustID, First, Last, DOB, Gender, Phone) VALUES (Cust_Seq.nextval, 'Danna', 'Klosser', '13-Mar-1959', 'F', '985-688-4036');
INSERT INTO Customers (CustID, First, Last, DOB, Gender, Phone) VALUES (Cust_Seq.nextval, 'Lynnea', 'Haddrill', '09-Oct-1985', 'F', '624-344-2926');
INSERT INTO Customers (CustID, First, Last, DOB, Gender, Phone) VALUES (Cust_Seq.nextval, 'Patten', 'Habert', '18-Aug-1992', 'M', '239-258-6288');
INSERT INTO Customers (CustID, First, Last, DOB, Gender, Phone) VALUES (Cust_Seq.nextval, 'Myles', 'Redgate', '19-Feb-1968', 'M', '499-428-7467');
INSERT INTO Customers (CustID, First, Last, DOB, Gender, Phone) VALUES (Cust_Seq.nextval, 'Adrea', 'Ockwell', '10-May-1980', 'F', '247-491-6989');
INSERT INTO Customers (CustID, First, Last, DOB, Gender, Phone) VALUES (Cust_Seq.nextval, 'Gavra', 'Woolfenden', '26-Oct-1978', 'F', '697-862-4053');
INSERT INTO Customers (CustID, First, Last, DOB, Gender, Phone) VALUES (Cust_Seq.nextval, 'Gwynne', 'Oldroyd', '08-Oct-1969', 'F', '525-641-2506');

INSERT INTO Addresses (AddressID, Street_Num, Street_Name, City, State, Zip, CustID, AddressType) values (Address_Seq.nextval, '43', 'Sunbrook', 'New York City', 'NY', '10275', 9, 'primary residence');
INSERT INTO Addresses (AddressID, Street_Num, Street_Name, City, State, Zip, CustID, AddressType) values (Address_Seq.nextval, '79', 'Springs', 'Madison', 'WI', '53716', 8, 'primary residence');
INSERT INTO Addresses (AddressID, Street_Num, Street_Name, City, State, Zip, CustID, AddressType) values (Address_Seq.nextval, '8007', 'Lyons', 'Macon', 'GA', '31205', 9, 'primary residence');
INSERT INTO Addresses (AddressID, Street_Num, Street_Name, City, State, Zip, CustID, AddressType) values (Address_Seq.nextval, '346', 'Veith', 'Fort Worth', 'TX', '76162', 2, 'primary residence');
INSERT INTO Addresses (AddressID, Street_Num, Street_Name, City, State, Zip, CustID, AddressType) values (Address_Seq.nextval, '38', 'Karstens', 'High Point', 'NC', '27264', 3, 'primary residence');
INSERT INTO Addresses (AddressID, Street_Num, Street_Name, City, State, Zip, CustID, AddressType) values (Address_Seq.nextval, '98134', 'Meadow Vale', 'Washington', 'DC', '20215', 8, 'primary residence');
INSERT INTO Addresses (AddressID, Street_Num, Street_Name, City, State, Zip, CustID, AddressType) values (Address_Seq.nextval, '2', 'Jenna', 'San Antonio', 'TX', '78235', 6, 'primary residence');
INSERT INTO Addresses (AddressID, Street_Num, Street_Name, City, State, Zip, CustID, AddressType) values (Address_Seq.nextval, '801', 'Prairieview', 'Spokane', 'WA', '99210', 8, 'primary residence');
INSERT INTO Addresses (AddressID, Street_Num, Street_Name, City, State, Zip, CustID, AddressType) values (Address_Seq.nextval, '01', 'Elka', 'Charlotte', 'NC', '28242', 2, 'primary residence');
INSERT INTO Addresses (AddressID, Street_Num, Street_Name, City, State, Zip, CustID, AddressType) values (Address_Seq.nextval, '80458', 'Hollow Ridge', 'Fort Wayne', 'IN', '46805', 8, 'primary residence');
INSERT INTO Addresses (AddressID, Street_Num, Street_Name, City, State, Zip, CustID, AddressType) values (Address_Seq.nextval, '19344', 'Spaight', 'Rochester', 'NY', '14683', 9, 'primary residence');
INSERT INTO Addresses (AddressID, Street_Num, Street_Name, City, State, Zip, CustID, AddressType) values (Address_Seq.nextval, '497', 'Homewood', 'Philadelphia', 'PA', '19178', 1, 'primary residence');
INSERT INTO Addresses (AddressID, Street_Num, Street_Name, City, State, Zip, CustID, AddressType) values (Address_Seq.nextval, '5788', 'David', 'Phoenix', 'AZ', '85045', 4, 'primary residence');
INSERT INTO Addresses (AddressID, Street_Num, Street_Name, City, State, Zip, CustID, AddressType) values (Address_Seq.nextval, '13', 'Northfield', 'Tampa', 'FL', '33661', 9, 'primary residence');
INSERT INTO Addresses (AddressID, Street_Num, Street_Name, City, State, Zip, CustID, AddressType) values (Address_Seq.nextval, '205', 'Artisan', 'Fort Worth', 'TX', '76134', 5, 'primary residence');
INSERT INTO Addresses (AddressID, Street_Num, Street_Name, City, State, Zip, CustID, AddressType) values (Address_Seq.nextval, '0362', 'Maple', 'Long Beach', 'CA', '90831', 6, 'primary residence');
INSERT INTO Addresses (AddressID, Street_Num, Street_Name, City, State, Zip, CustID, AddressType) values (Address_Seq.nextval, '3139', 'Fairfield', 'Duluth', 'GA', '30096', 7, 'primary residence');
INSERT INTO Addresses (AddressID, Street_Num, Street_Name, City, State, Zip, CustID, AddressType) values (Address_Seq.nextval, '223', 'Cherokee', 'Dallas', 'TX', '75210', 5, 'primary residence');
INSERT INTO Addresses (AddressID, Street_Num, Street_Name, City, State, Zip, CustID, AddressType) values (Address_Seq.nextval, '177', 'Banding', 'Colorado Springs', 'CO', '80920', 9, 'primary residence');
INSERT INTO Addresses (AddressID, Street_Num, Street_Name, City, State, Zip, CustID, AddressType) values (Address_Seq.nextval, '6430', 'Valley Edge', 'Tulsa', 'OK', '74149', 8, 'primary residence');

INSERT INTO Properties (PropertyID, AddressID, Num_Bedrooms, Num_Baths, Sq_Feet) values (Prop_Seq.nextval, 1, 3, 1.5, 3656);
INSERT INTO Properties (PropertyID, AddressID, Num_Bedrooms, Num_Baths, Sq_Feet) values (Prop_Seq.nextval, 2, 1, 3.5, 6096);
INSERT INTO Properties (PropertyID, AddressID, Num_Bedrooms, Num_Baths, Sq_Feet) values (Prop_Seq.nextval, 3, 4, 1.5, 5639);
INSERT INTO Properties (PropertyID, AddressID, Num_Bedrooms, Num_Baths, Sq_Feet) values (Prop_Seq.nextval, 4, 1, 3.5, 3128);
INSERT INTO Properties (PropertyID, AddressID, Num_Bedrooms, Num_Baths, Sq_Feet) values (Prop_Seq.nextval, 5, 3, 1, 4646);
INSERT INTO Properties (PropertyID, AddressID, Num_Bedrooms, Num_Baths, Sq_Feet) values (Prop_Seq.nextval, 6, 2, 1.5, 7143);
INSERT INTO Properties (PropertyID, AddressID, Num_Bedrooms, Num_Baths, Sq_Feet) values (Prop_Seq.nextval, 7, 4, 1.5, 5682);
INSERT INTO Properties (PropertyID, AddressID, Num_Bedrooms, Num_Baths, Sq_Feet) values (Prop_Seq.nextval, 8, 4, 1, 7391);
INSERT INTO Properties (PropertyID, AddressID, Num_Bedrooms, Num_Baths, Sq_Feet) values (Prop_Seq.nextval, 9, 3, 1, 3759);
INSERT INTO Properties (PropertyID, AddressID, Num_Bedrooms, Num_Baths, Sq_Feet) values (Prop_Seq.nextval, 10, 4, 2, 5057);
INSERT INTO Properties (PropertyID, AddressID, Num_Bedrooms, Num_Baths, Sq_Feet) values (Prop_Seq.nextval, 11, 2, 3.5, 6077);
INSERT INTO Properties (PropertyID, AddressID, Num_Bedrooms, Num_Baths, Sq_Feet) values (Prop_Seq.nextval, 12, 2, 3.5, 5096);
INSERT INTO Properties (PropertyID, AddressID, Num_Bedrooms, Num_Baths, Sq_Feet) values (Prop_Seq.nextval, 13, 3, 2.5, 4332);
INSERT INTO Properties (PropertyID, AddressID, Num_Bedrooms, Num_Baths, Sq_Feet) values (Prop_Seq.nextval, 14, 4, 3, 6932);
INSERT INTO Properties (PropertyID, AddressID, Num_Bedrooms, Num_Baths, Sq_Feet) values (Prop_Seq.nextval, 15, 1, 3.5, 5800);
INSERT INTO Properties (PropertyID, AddressID, Num_Bedrooms, Num_Baths, Sq_Feet) values (Prop_Seq.nextval, 16, 1, 3, 5204);
INSERT INTO Properties (PropertyID, AddressID, Num_Bedrooms, Num_Baths, Sq_Feet) values (Prop_Seq.nextval, 17, 3, 3, 5530);
INSERT INTO Properties (PropertyID, AddressID, Num_Bedrooms, Num_Baths, Sq_Feet) values (Prop_Seq.nextval, 18, 1, 2.5, 6702);
INSERT INTO Properties (PropertyID, AddressID, Num_Bedrooms, Num_Baths, Sq_Feet) values (Prop_Seq.nextval, 19, 4, 1, 7045);
INSERT INTO Properties (PropertyID, AddressID, Num_Bedrooms, Num_Baths, Sq_Feet) values (Prop_Seq.nextval, 20, 3, 3, 6372);

INSERT INTO Purchases (CustID, PropertyID, PurchaseDate) VALUES (1, 1, '21-Jan-2002');
INSERT INTO Purchases (CustID, PropertyID, PurchaseDate) VALUES (2, 1, '21-Jan-2002');
INSERT INTO Purchases (CustID, PropertyID, PurchaseDate) VALUES (3, 1, '21-Jan-2002');
INSERT INTO Purchases (CustID, PropertyID, PurchaseDate) VALUES (4, 1, '21-Jan-2002');
INSERT INTO Purchases (CustID, PropertyID, PurchaseDate) VALUES (5, 3, '30-Dec-2005');
INSERT INTO Purchases (CustID, PropertyID, PurchaseDate) VALUES (6, 3, '30-Dec-2005');
INSERT INTO Purchases (CustID, PropertyID, PurchaseDate) VALUES (7, 3, '30-Dec-2005');
INSERT INTO Purchases (CustID, PropertyID, PurchaseDate) VALUES (8, 7, '29-Dec-2011');
INSERT INTO Purchases (CustID, PropertyID, PurchaseDate) VALUES (9, 7, '29-Dec-2011');
INSERT INTO Purchases (CustID, PropertyID, PurchaseDate) VALUES (10, 9, '01-May-2013');
INSERT INTO Purchases (CustID, PropertyID, PurchaseDate) VALUES (11, 10, '08-Dec-2013');
INSERT INTO Purchases (CustID, PropertyID, PurchaseDate) VALUES (12, 11, '18-Oct-2014');
INSERT INTO Purchases (CustID, PropertyID, PurchaseDate) VALUES (13, 12, '30-Nov-2015');
INSERT INTO Purchases (CustID, PropertyID, PurchaseDate) VALUES (14, 2, '27-Jan-2017');
INSERT INTO Purchases (CustID, PropertyID, PurchaseDate) VALUES (15, 2, '20-Apr-2017');
INSERT INTO Purchases (CustID, PropertyID, PurchaseDate) VALUES (16, 7, '02-Jul-2018');
INSERT INTO Purchases (CustID, PropertyID, PurchaseDate) VALUES (17, 7, '02-Jul-2018');
INSERT INTO Purchases (CustID, PropertyID, PurchaseDate) VALUES (18, 1, '29-Dec-2019');
INSERT INTO Purchases (CustID, PropertyID, PurchaseDate) VALUES (19, 1, '29-Dec-2019');

INSERT INTO Listings (ListingID, PropertyID, ListDate, AskingPrice, Status) VALUES (Listing_Seq.nextval, 1, '15-Dec-2001', 295150, 'closed');
INSERT INTO Listings (ListingID, PropertyID, ListDate, AskingPrice, Status) VALUES (Listing_Seq.nextval, 3, '12-Oct-2004', 345275, 'closed');
INSERT INTO Listings (ListingID, PropertyID, ListDate, AskingPrice, Status) VALUES (Listing_Seq.nextval, 7, '07-Jul-2008', 450350, 'canceled');
INSERT INTO Listings (ListingID, PropertyID, ListDate, AskingPrice, Status) VALUES (Listing_Seq.nextval, 9, '28-Aug-2008', 400000, 'canceled');
INSERT INTO Listings (ListingID, PropertyID, ListDate, AskingPrice, Status) VALUES (Listing_Seq.nextval, 7, '15-Oct-2011', 350000, 'closed');
INSERT INTO Listings (ListingID, PropertyID, ListDate, AskingPrice, Status) VALUES (Listing_Seq.nextval, 9, '07-Aug-2011', 250000, 'closed');
INSERT INTO Listings (ListingID, PropertyID, ListDate, AskingPrice, Status) VALUES (Listing_Seq.nextval, 10, '12-Nov-2012', 150150, 'closed');
INSERT INTO Listings (ListingID, PropertyID, ListDate, AskingPrice, Status) VALUES (Listing_Seq.nextval, 11, '09-Jan-2013', 600000, 'closed');
INSERT INTO Listings (ListingID, PropertyID, ListDate, AskingPrice, Status) VALUES (Listing_Seq.nextval, 12, '17-May-2014', 425000, 'closed');
INSERT INTO Listings (ListingID, PropertyID, ListDate, AskingPrice, Status) VALUES (Listing_Seq.nextval, 2, '23-Apr-2021', 350000, 'open');
INSERT INTO Listings (ListingID, PropertyID, ListDate, AskingPrice, Status) VALUES (Listing_Seq.nextval, 7, '25-Mar-2021', 150000, 'pending');
INSERT INTO Listings (ListingID, PropertyID, ListDate, AskingPrice, Status) VALUES (Listing_Seq.nextval, 1, '29-Nov-2020', 1250000, 'open');

INSERT INTO Preapprovals (PreApprovalID, CustID, Amount) VALUES (PreApproval_Seq.nextval, 17, 350000);
INSERT INTO Preapprovals (PreApprovalID, CustID, Amount) VALUES (PreApproval_Seq.nextval, 18, 1350000);
INSERT INTO Preapprovals (PreApprovalID, CustID, Amount) VALUES (PreApproval_Seq.nextval, 18, 1500000);
INSERT INTO Preapprovals (PreApprovalID, CustID, Amount) VALUES (PreApproval_Seq.nextval, 19, 1400000);
INSERT INTO Preapprovals (PreApprovalID, CustID, Amount) VALUES (PreApproval_Seq.nextval, 19, 1450000);
INSERT INTO Preapprovals (PreApprovalID, CustID, Amount) VALUES (PreApproval_Seq.nextval, 19, 1500000);

INSERT INTO ApprovalDetails (ApprovalID, ApprovalDate, ExpireDate, Lender, Amount) VALUES (Approval_Seq.nextval, '25-Apr-2021', '25-May-2021', 'Bank of America', 350000);
INSERT INTO ApprovalDetails (ApprovalID, ApprovalDate, ExpireDate, Lender, Amount) VALUES (Approval_Seq.nextval, '18-Mar-2021', '18-Apr-2021', 'Capital One', 1350000);
INSERT INTO ApprovalDetails (ApprovalID, ApprovalDate, ExpireDate, Lender, Amount) VALUES (Approval_Seq.nextval, '18-Mar-2021', '18-Apr-2021', 'Bank of America', 1500000);
INSERT INTO ApprovalDetails (ApprovalID, ApprovalDate, ExpireDate, Lender, Amount) VALUES (Approval_Seq.nextval, '20-Mar-2020', '20-Apr-2020', 'Capital One', 15000000);
INSERT INTO ApprovalDetails (ApprovalID, ApprovalDate, ExpireDate, Lender, Amount) VALUES (Approval_Seq.nextval, '20-Mar-2020', '20-Apr-2020', 'Wells Fargo', 14000000);
INSERT INTO ApprovalDetails (ApprovalID, ApprovalDate, ExpireDate, Lender, Amount) VALUES (Approval_Seq.nextval, '20-Mar-2020', '20-Apr-2020', 'Bank of America', 14500000);

INSERT INTO Offers (OfferID, ListingID, OfferDate, ExpireDate, OfferAmount, Status, ApprovalNo) VALUES (Offer_Seq.nextval, 10, '21-Apr-2021', '18-Apr-2021', 295150, 'accepted', 1);
INSERT INTO Offers (OfferID, ListingID, OfferDate, ExpireDate, OfferAmount, Status, ApprovalNo) VALUES (Offer_Seq.nextval, 12, '22-Apr-2021', '29-Apr-2021', 1250000, 'accepted', 2);
INSERT INTO Offers (OfferID, ListingID, OfferDate, ExpireDate, OfferAmount, Status, ApprovalNo) VALUES (Offer_Seq.nextval, 12, '22-Apr-2021', '29-Apr-2021', 1150000, 'declined', 4);

INSERT INTO OfferParticipants (OfferID, CustID) VALUES (1, 17);
INSERT INTO OfferParticipants (OfferID, CustID) VALUES (2, 18);
INSERT INTO OfferParticipants (OfferID, CustID) VALUES (3, 19);

COMMIT;