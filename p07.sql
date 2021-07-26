CREATE OR REPLACE PROCEDURE Purchase(pOfferID Offers.OfferID%TYPE) AS

    vCustID     Customers.CustID%TYPE;
    vPropertyID Properties.PropertyID%TYPE;
    vOffer      Offers%ROWTYPE;
    CURSOR cCustomers IS
        SELECT CustID
        FROM OfferParticipants
        WHERE OfferID = pOfferID;

BEGIN

    SELECT OfferID, ListingID INTO
        vOffer.OfferID, vOffer.ListingID
    FROM Offers
        WHERE OfferID = pOfferID;

    SELECT propertyID
    INTO vPropertyID
    FROM Listings
    WHERE ListingID = vOffer.ListingID;

    OPEN cCustomers;
        LOOP
            FETCH cCustomers INTO vCustID;
            EXIT WHEN cCustomers%NOTFOUND;
            INSERT INTO Purchases VALUES (vCustID, vPropertyID, sysdate);
        END LOOP;
    CLOSE cCustomers;

    UPDATE Listings SET Status = 'closed' WHERE ListingID = vOffer.ListingID;
    UPDATE Offers SET Status = 'accepted' WHERE OfferID = vOffer.OfferID;

EXCEPTION
    WHEN Too_Many_Rows THEN
        DBMS_OUTPUT.PUT_LINE('Too many rows found ' || sqlerrm);
        ROLLBACK;
    WHEN No_Data_Found THEN
        DBMS_OUTPUT.PUT_LINE('No data found ' || sqlerrm);
        ROLLBACK;
    WHEN Others THEN
        DBMS_OUTPUT.PUT_LINE('Unknown Error ' || sqlerrm);
        ROLLBACK;
END;
/

CREATE OR REPLACE PROCEDURE Trade (pOffer1 Offers.OfferID%TYPE, pOffer2 Offers.OfferID%TYPE) AS

BEGIN
    purchase(pOffer1);
    purchase(pOffer2);
    COMMIT;
END;
/

