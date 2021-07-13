CREATE OR REPLACE TRIGGER OfferConstraint
    BEFORE INSERT
    ON Offers
    FOR EACH ROW
DECLARE
    vApprovalAmount PreApprovals.Amount%Type;
    Invalid_Offer_Amount EXCEPTION;
    PRAGMA EXCEPTION_INIT ( Invalid_Offer_Amount, -20002 );
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
        DBMS_OUTPUT.PUT_LINE('Too many rows found');
        DBMS_OUTPUT.PUT_LINE('Error ' || sqlerrm);
    WHEN No_Data_Found THEN
        DBMS_OUTPUT.PUT_LINE('No data was found');
        DBMS_OUTPUT.PUT_LINE('Error ' || sqlerrm);
END;


CREATE OR REPLACE PROCEDURE CreateOffer(vListingID Listings.ListingID%Type,
                                        vApprovalID ApprovalDetails.ApprovalID%Type,
                                        vOfferAmount Offers.OfferAmount%Type,
                                        vExpDate Offers.ExpireDate%Type) AS

    cCustID Customers.CustID%TYPE;

    CURSOR cCustomers IS
        SELECT CustID FROM Preapprovals
        WHERE PreapprovalID = vApprovalID;
    vOfferID NUMBER;

BEGIN

    vOfferID := OFFER_SEQ.nextval;

    INSERT INTO Offers(OfferID, ListingID, OfferDate, ExpireDate, OfferAmount, ApprovalNo)
    VALUES (vOfferID, vListingID, SYSDATE, vExpDate, vOfferAmount, vApprovalID);

    OPEN cCustomers;
        LOOP
            FETCH cCustomers INTO cCustID;
            EXIT WHEN cCustomers%NOTFOUND;
            INSERT INTO OfferParticipants(OfferID, CustID) VALUES(vOfferID, cCustID);
        END LOOP;
    CLOSE cCustomers;

EXCEPTION
    WHEN Too_Many_Rows THEN
        DBMS_OUTPUT.PUT_LINE('Too many rows were selected ' || sqlerrm);
        ROLLBACK;
    WHEN No_Data_Found THEN
        DBMS_OUTPUT.PUT_LINE('No data was found ' || sqlerrm);
        ROLLBACK;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(sqlerrm);
        ROLLBACK;
END;

BEGIN
    CreateOffer(10, 7, 350000, '19-Jul-2021');
    COMMIT;
END;