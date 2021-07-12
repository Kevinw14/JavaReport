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

    EXCEPTION
    WHEN Too_Many_Rows THEN
        DBMS_OUTPUT.PUT_LINE('Too many rows found');
        DBMS_OUTPUT.PUT_LINE('Error ' || sqlerrm);
END;

CREATE OR REPLACE PACKAGE pCustomers AS
    TYPE VARRAY_CUSTOMERS IS VARRAY(10) OF Customers.CUSTID%TYPE;
END pCustomers;

CREATE OR REPLACE PROCEDURE CreateOffer(vListingID Listings.ListingID%Type,
                                        vCustomers pCustomers.VARRAY_CUSTOMERS,
                                        vApprovalID ApprovalDetails.ApprovalID%Type,
                                        vOfferAmount Offers.OfferAmount%Type,
                                        vExpDate Offers.ExpireDate%Type) AS
    Wrong_Approval_Buyer_Exception EXCEPTION;
    PRAGMA EXCEPTION_INIT (Wrong_Approval_Buyer_Exception, -20001);
    vOfferID NUMBER;

BEGIN

    vOfferID := OFFER_SEQ.nextval;

    INSERT INTO Offers(OfferID, ListingID, OfferDate, ExpireDate, OfferAmount, ApprovalNo)
    VALUES (vOfferID, vListingID, SYSDATE, vExpDate, vOfferAmount, vApprovalID);

    FOR i IN 1..vCustomers.count
        LOOP
            INSERT INTO OfferParticipants(OFFERID, CUSTID) VALUES (vOfferID, vCustomers(i));
        END LOOP;

EXCEPTION
    WHEN Too_Many_Rows THEN
        DBMS_OUTPUT.PUT_LINE('Too Many Rows were selected ' || sqlerrm);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(sqlerrm);
END;

BEGIN
    CreateOffer(1, pCustomers.VARRAY_CUSTOMERS(1, 2, 3), 1, 250000, '11-Jul-2021');
    COMMIT;
END;