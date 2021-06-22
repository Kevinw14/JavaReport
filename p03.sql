INSERT INTO Customers(Cust_ID, First, Last, DOB, Gender, Street_Address, City, State, Zipcode, Phone) VALUES(Cust_ID_Seq.nextval, 'Pam', 'Landy', '5-May-1985', 'F', '322 Hamburg Rd', 'Greenville', 'PA', '16125', '330-628-8197')
INSERT INTO Customers(Cust_ID, First, Last, DOB, Gender, Street_Address, City, State, Zipcode, Phone) VALUES(Cust_ID_Seq.nextval, 'Mike', 'Holmes', '25-Feb-1989', 'M', '802 Willopenn Dr', 'Mansfield', 'PA', '16934', '607-565-9759')
INSERT INTO Customers(Cust_ID, First, Last, DOB, Gender, Street_Address, City, State, Zipcode, Phone) VALUES(Cust_ID_Seq.nextval, 'Wendy', 'Landy', '19-Aug-1965', 'F', '459 Chestnut St', 'Nutley', 'NJ', '07110', '718-364-1619')


INSERT INTO Properties(Listing_ID, Cust_ID, Listing_Date, Price, Num_Bedrooms, Num_Baths, Square_Feet, Street_Address, City, State, Zipcode) VALUES(Property_Seq.nextval, 707, '21-Sep-1989', 149750, 2, 2, 1550, '53 S Main St', 'Towanda', 'PA', '18848'); 
INSERT INTO Properties(Listing_ID, Cust_ID, Listing_Date, Price, Num_Bedrooms, Num_Baths, Square_Feet, Street_Address, City, State, Zipcode) VALUES(Property_Seq.nextval, 705, '15-Nov-1992', 225000, 3, 2, 1980, '104 Matthew Ln', 'Gilbertsville', 'PA', '19525');
INSERT INTO Properties(Listing_ID, Cust_ID, Listing_Date, Price, Num_Bedrooms, Num_Baths, Square_Feet, Street_Address, City, State, Zipcode) VALUES(Property_Seq.nextval, 710, '21-Jun-2021', 447500, 3, 2.5, 2200, '322 Hamburg Rd', 'Greenville', 'PA', '16125');
INSERT INTO Properties(Listing_ID, Cust_ID, Listing_Date, Price, Num_Bedrooms, Num_Baths, Square_Feet, Street_Address, City, State, Zipcode) VALUES(Property_Seq.nextval, 711, '5-Jun-2021', 575000, 4, 3, 2950, '802 Willopenn Dr', 'Mansfield', 'PA', '16934');
INSERT INTO Properties(Listing_ID, Cust_ID, Listing_Date, Price, Num_Bedrooms, Num_Baths, Square_Feet, Street_Address, City, State, Zipcode) VALUES(Property_Seq.nextval, 705, '7-Nov-2006', 445900, 3, 3, 2750, '2303 Peach St', 'Erie', 'PA', '16502');
INSERT INTO Properties(Listing_ID, Cust_ID, Listing_Date, Price, Num_Bedrooms, Num_Baths, Square_Feet, Street_Address, City, State, Zipcode) VALUES(Property_Seq.nextval, 705, '1-Aug-1972', 95000, 2, 1.5, 1400, '510 Hansen Ave', 'Erie', 'PA', '16502');
INSERT INTO Properties(Listing_ID, Cust_ID, Listing_Date, Price, Num_Bedrooms, Num_Baths, Square_Feet, Street_Address, City, State, Zipcode) VALUES(Property_Seq.nextval, 709, '17-Jul-1974', 125000, 3, 2, 1875, '730 E. Mill St', 'Little Falls', 'NY', '13365');
INSERT INTO Properties(Listing_ID, Cust_ID, Listing_Date, Price, Num_Bedrooms, Num_Baths, Square_Feet, Street_Address, City, State, Zipcode) VALUES(Property_Seq.nextval, 708, '24-Feb-1978', 195000, 3, 2, 1750, '3006 Amen Cor', 'Riverhead', 'NY', '11901');
INSERT INTO Properties(Listing_ID, Cust_ID, Listing_Date, Price, Num_Bedrooms, Num_Baths, Square_Feet, Street_Address, City, State, Zipcode) VALUES(Property_Seq.nextval, 706, '14-Oct-1975', 220500, 3, 1.5, 2100, '135 Hillcrest Ave', 'Little Falls', 'NY', '13365');
INSERT INTO Properties(Listing_ID, Cust_ID, Listing_Date, Price, Num_Bedrooms, Num_Baths, Square_Feet, Street_Address, City, State, Zipcode) VALUES(Property_Seq.nextval, 707, '25-May-2021', 325000, 4, 3, 3200, '70 Broad St', 'Carlstadt', 'NJ', '07072');
INSERT INTO Properties(Listing_ID, Cust_ID, Listing_Date, Price, Num_Bedrooms, Num_Baths, Square_Feet, Street_Address, City, State, Zipcode) VALUES(Property_Seq.nextval, 709, '12-Apr-1987', 389900, 3, 2.5, 2700, '101 Columbia Rd', 'Sparta', 'NJ', '07871');
INSERT INTO Properties(Listing_ID, Cust_ID, Listing_Date, Price, Num_Bedrooms, Num_Baths, Square_Feet, Street_Address, City, State, Zipcode) VALUES(Property_Seq.nextval, 712, '3-May-2021', 412500, 4, 2, 2350, '459 Chestnut St', 'Nutley', 'NJ', '07110');

ALTER TABLE Properties ADD (Active CHAR(1) CONSTRAINT ActiveCk CHECK (Active IN ('Y', 'N')));

UPDATE Properties SET Active = 'Y' WHERE Listing_ID = 1007;
UPDATE Properties SET Active = 'Y' WHERE Listing_ID = 1008;
UPDATE Properties SET Active = 'Y' WHERE Listing_ID = 1009;
UPDATE Properties SET Active = 'N' WHERE Listing_ID = 1010;
UPDATE Properties SET Active = 'N' WHERE Listing_ID = 1011;
UPDATE Properties SET Active = 'Y' WHERE Listing_ID = 1012;
UPDATE Properties SET Active = 'Y' WHERE Listing_ID = 1013;
UPDATE Properties SET Active = 'N' WHERE Listing_ID = 1014;
UPDATE Properties SET Active = 'N' WHERE Listing_ID = 1015;
UPDATE Properties SET Active = 'N' WHERE Listing_ID = 1016;
UPDATE Properties SET Active = 'N' WHERE Listing_ID = 1017;
UPDATE Properties SET Active = 'N' WHERE Listing_ID = 1018;
UPDATE Properties SET Active = 'Y' WHERE Listing_ID = 1019;
UPDATE Properties SET Active = 'N' WHERE Listing_ID = 1020;
UPDATE Properties SET Active = 'Y' WHERE Listing_ID = 1021;


CREATE OR REPLACE VIEW active_properties AS
    SELECT Listing_ID, 
    P.Cust_ID, 
    Listing_Date, 
    Price, 
    Num_Bedrooms, 
    Num_Baths, 
    Square_Feet, 
    P.Street_Address,
    P.City, 
    P.State, 
    P.Zipcode, 
    Phone 
    FROM PROPERTIES P
INNER JOIN CUSTOMERS C ON C.CUST_ID = P.CUST_ID
WHERE ACTIVE = 'Y'
ORDER BY STATE;

COMMIT;