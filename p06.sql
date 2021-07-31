CREATE OR REPLACE TRIGGER OfferConstraint
    BEFORE INSERT OR UPDATE OF OfferAmount
    ON Offers
    FOR EACH ROW
DECLARE
    vApprovalAmount PreApprovals.Amount%Type;
BEGIN
    SELECT amount
    INTO vApprovalAmount
    FROM ApprovalDetails
    WHERE ApprovalID = :NEW.ApprovalNo;

    IF :NEW.OfferAmount >  vApprovalAmount THEN
        raise_application_error(-20002, 'Offer amount can not be more than approval amount');
    END IF;

    EXCEPTION
    WHEN Too_Many_Rows THEN
        DBMS_OUTPUT.PUT_LINE('Too many rows found ' || sqlerrm);
    WHEN No_Data_Found THEN
        DBMS_OUTPUT.PUT_LINE('No data was found ' || sqlerrm);
    WHEN Others THEN
        DBMS_OUTPUT.PUT_LINE('Unknown error in trigger' || sqlerrm);
END;
/

CREATE OR REPLACE PROCEDURE CreateOffer(vListingID Listings.ListingID%Type,
                                        vApprovalID ApprovalDetails.ApprovalID%Type,
                                        vOfferAmount Offers.OfferAmount%Type,
                                        vExpDate Offers.ExpireDate%Type) AS

    vCustID Customers.CustID%TYPE;
    vOfferID NUMBER;

    CURSOR cCustomers IS
        SELECT CustID FROM Preapprovals
        WHERE PreapprovalID = vApprovalID;

BEGIN

    vOfferID := OFFER_SEQ.nextval;

    INSERT INTO Offers(OfferID, ListingID, OfferDate, ExpireDate, OfferAmount, ApprovalNo)
    VALUES (vOfferID, vListingID, SYSDATE, vExpDate, vOfferAmount, vApprovalID);
    
    OPEN cCustomers;
        LOOP
            FETCH cCustomers INTO vCustID;
            EXIT WHEN cCustomers%NOTFOUND;
            INSERT INTO OfferParticipants(OfferID, CustID) VALUES(vOfferID, vCustID);
        END LOOP;
    CLOSE cCustomers;
    COMMIT;
EXCEPTION
    WHEN Too_Many_Rows THEN
        DBMS_OUTPUT.PUT_LINE('Too many rows were selected ' || sqlerrm);
        ROLLBACK;
    WHEN No_Data_Found THEN
        DBMS_OUTPUT.PUT_LINE('No data was found ' || sqlerrm);
        ROLLBACK;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Unknown error ' || sqlerrm);
        ROLLBACK;
END;
/

BEGIN
    CreateOffer(10, 7, 350000, '19-Jul-2021');
END;
/
