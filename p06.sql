CREATE PACKAGE pCustomers AS
    TYPE VARRAY_CUSTOMERS IS VARRAY(10) OF Customers.CUSTID%TYPE;
END pCustomers;

CREATE OR REPLACE PROCEDURE CreateOffer(vListingID Listings.ListingID%Type,
                                        vCustomers pCustomers.VARRAY_CUSTOMERS,
                                        vApprovalID ApprovalDetails.ApprovalID%Type,
                                        vOfferAmount Offers.OfferAmount%Type,
                                        vExpDate Offers.ExpireDate%Type) AS
    Excessive_Offer_Exception EXCEPTION;
    Past_Expiration_Date_Exception EXCEPTION;
    Wrong_Approval_Buyer_Exception EXCEPTION;
    PRAGMA EXCEPTION_INIT (Excessive_Offer_Exception, -2000);
    PRAGMA EXCEPTION_INIT (Past_Expiration_Date_Exception, -2001);
    PRAGMA EXCEPTION_INIT (Wrong_Approval_Buyer_Exception, -2002);
    
    vApprovalAmount PreApprovals.Amount%Type;
    vOfferID        NUMBER;

BEGIN

    SELECT amount
    INTO vApprovalAmount
    FROM Preapprovals
    WHERE PreApprovalID = vApprovalID;

    IF vOfferAmount > vApprovalAmount THEN
        RAISE Excessive_Offer_Exception;
    END IF;
    IF vExpDate < SYSDATE THEN
        RAISE Past_Expiration_Date_Exception;
    END IF;

    vOfferID := OFFER_SEQ.nextval;

    INSERT INTO Offers(OfferID, ListingID, OfferDate, ExpireDate, OfferAmount, ApprovalNo)
    VALUES (vOfferID, vListingID, SYSDATE, vExpDate, vOfferAmount, vApprovalID);

    FOR i IN 1..vCustomers.count
        LOOP
            INSERT INTO OfferParticipants(OFFERID, CUSTID) VALUES (vOfferID, vCustomers(i));
        END LOOP;

EXCEPTION
    WHEN Excessive_Offer_Exception THEN
        DBMS_OUTPUT.PUT_LINE('Offer Amount cannot exceed approval amount.');
    WHEN Past_Expiration_Date_Exception THEN
        DBMS_OUTPUT.PUT_LINE('Expiration Date cannot be before the offer date');
    WHEN Too_Many_Rows THEN
        DBMS_OUTPUT.PUT_LINE('Too Many Rows were selected ' || sqlerrm);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Unknown error occured ' || sqlerrm);
END;

BEGIN
    CreateOffer(1, pCustomers.VARRAY_CUSTOMERS(1, 2, 3), 1, 350000, '12-Jul-2021');
END;