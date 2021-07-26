-- Purchase Tests
--13
INSERT INTO Listings (ListingID, PropertyID, ListDate, AskingPrice, Status) VALUES (Listing_Seq.nextval, 1, '16-Mar-2021', 640150, 'open');
--8
INSERT INTO Preapprovals (PreapprovalID, CustID, Amount) VALUES (8, 7, 700000);
INSERT INTO ApprovalDetails (ApprovalID, ApprovalDate, ExpireDate, Lender, Amount) VALUES (8, '21-Apr-2021', '28-Apr-2021', 'Bank of America', 700000);
--4
INSERT INTO Offers (OfferID, ListingID, OfferDate, ExpireDate, OfferAmount, ApprovalNo) VALUES (Offer_Seq.nextval, 13, '22-Apr-2021', '29-Apr-2021', 640150, 8);

INSERT INTO OfferParticipants VALUES (4, 7);

BEGIN
    purchase(4);
END;

--14
INSERT INTO Listings (ListingID, PropertyID, ListDate, AskingPrice, Status) VALUES (Listing_Seq.nextval, 8, '16-Apr-2021', 350000, 'open');
--9
INSERT INTO Preapprovals (PreapprovalID, CustID, Amount) VALUES (9, 8, 500000);
INSERT INTO Preapprovals (PreapprovalID, CustID, Amount) VALUES (9, 9, 500000);

INSERT INTO ApprovalDetails (ApprovalID, ApprovalDate, ExpireDate, Lender, Amount) VALUES (9, '21-May-2021', '28-May-2021', 'Wells Fargo', 350000);
--5
INSERT INTO Offers (OfferID, ListingID, OfferDate, ExpireDate, OfferAmount, ApprovalNo) VALUES (Offer_Seq.nextval, 14, '22-May-2021', '29-May-2021', 350000, 9);

INSERT INTO OfferParticipants VALUES (5, 8);
INSERT INTO OfferParticipants VALUES (5, 9);

BEGIN
    purchase(5);
END;

--15
INSERT INTO Listings (ListingID, PropertyID, ListDate, AskingPrice, Status) VALUES (Listing_Seq.nextval, 16, '23-Apr-2021', 250000, 'open');
--10
INSERT INTO Preapprovals (PreapprovalID, CustID, Amount) VALUES (10, 10, 250000);
INSERT INTO Preapprovals (PreapprovalID, CustID, Amount) VALUES (10, 11, 250000);
INSERT INTO Preapprovals (PreapprovalID, CustID, Amount) VALUES (10, 12, 250000);
--10
INSERT INTO ApprovalDetails (ApprovalID, ApprovalDate, ExpireDate, Lender, Amount) VALUES (10, '21-May-2021', '28-May-2021', 'Wells Fargo', 250000);
--6
INSERT INTO Offers (OfferID, ListingID, OfferDate, ExpireDate, OfferAmount, ApprovalNo) VALUES (Offer_Seq.nextval, 15, '22-May-2021', '29-May-2021', 250000, 10);

INSERT INTO OfferParticipants VALUES (6, 10);
INSERT INTO OfferParticipants VALUES (6, 11);
INSERT INTO OfferParticipants VALUES (6, 12);

BEGIN
    purchase(6);
END;

-- Trade Tests

--16
INSERT INTO Listings (ListingID, PropertyID, ListDate, AskingPrice, Status) VALUES (Listing_Seq.nextval, 13, '23-Apr-2021', 450000, 'open');
--11
INSERT INTO Preapprovals (PreapprovalID, CustID, Amount) VALUES (11, 13, 450000);
INSERT INTO Preapprovals (PreapprovalID, CustID, Amount) VALUES (11, 14, 450000);
INSERT INTO Preapprovals (PreapprovalID, CustID, Amount) VALUES (11, 15, 450000);
--11
INSERT INTO ApprovalDetails (ApprovalID, ApprovalDate, ExpireDate, Lender, Amount) VALUES (11, '21-May-2021', '28-May-2021', 'Wells Fargo', 450000);
--7
INSERT INTO Offers (OfferID, ListingID, OfferDate, ExpireDate, OfferAmount, ApprovalNo) VALUES (Offer_Seq.nextval, 16, '22-May-2021', '29-May-2021', 450000, 11);

INSERT INTO OfferParticipants VALUES (7, 13);
INSERT INTO OfferParticipants VALUES (7, 14);
INSERT INTO OfferParticipants VALUES (7, 15);

BEGIN
    purchase(7);
END;

--17
INSERT INTO Listings (ListingID, PropertyID, ListDate, AskingPrice, Status) VALUES (Listing_Seq.nextval, 15, '23-Apr-2021', 250000, 'open');
--12
INSERT INTO Preapprovals (PreapprovalID, CustID, Amount) VALUES (12, 2, 250000);
INSERT INTO Preapprovals (PreapprovalID, CustID, Amount) VALUES (12, 3, 250000);
INSERT INTO Preapprovals (PreapprovalID, CustID, Amount) VALUES (12, 4, 250000);
--12
INSERT INTO ApprovalDetails (ApprovalID, ApprovalDate, ExpireDate, Lender, Amount) VALUES (12, '21-May-2021', '28-May-2021', 'Wells Fargo', 250000);
--8
INSERT INTO Offers (OfferID, ListingID, OfferDate, ExpireDate, OfferAmount, ApprovalNo) VALUES (Offer_Seq.nextval, 17, '22-May-2021', '29-May-2021', 250000, 12);

INSERT INTO OfferParticipants VALUES (8, 2);
INSERT INTO OfferParticipants VALUES (8, 3);
INSERT INTO OfferParticipants VALUES (8, 4);

BEGIN
    purchase(8);
END;

-- 13, 14, 15 Should have property 15
-- 2, 3, 4 Should have property 13

--18
INSERT INTO Listings (ListingID, PropertyID, ListDate, AskingPrice, Status) VALUES (Listing_Seq.nextval, 18, '23-Apr-2021', 450000, 'open');
--13
INSERT INTO Preapprovals (PreapprovalID, CustID, Amount) VALUES (13, 18, 450000);
INSERT INTO Preapprovals (PreapprovalID, CustID, Amount) VALUES (13, 19, 450000);
--13
INSERT INTO ApprovalDetails (ApprovalID, ApprovalDate, ExpireDate, Lender, Amount) VALUES (13, '21-May-2021', '28-May-2021', 'Wells Fargo', 450000);
--9
INSERT INTO Offers (OfferID, ListingID, OfferDate, ExpireDate, OfferAmount, ApprovalNo) VALUES (Offer_Seq.nextval, 18, '22-May-2021', '29-May-2021', 450000, 13);

INSERT INTO OfferParticipants VALUES (9, 18);
INSERT INTO OfferParticipants VALUES (9, 19);

BEGIN
    purchase(9);
END;

--19
INSERT INTO Listings (ListingID, PropertyID, ListDate, AskingPrice, Status) VALUES (Listing_Seq.nextval, 15, '23-Apr-2021', 250000, 'open');
--14
INSERT INTO Preapprovals (PreapprovalID, CustID, Amount) VALUES (14, 6, 250000);
INSERT INTO Preapprovals (PreapprovalID, CustID, Amount) VALUES (14, 7, 250000);
--14
INSERT INTO ApprovalDetails (ApprovalID, ApprovalDate, ExpireDate, Lender, Amount) VALUES (14, '21-May-2021', '28-May-2021', 'Wells Fargo', 250000);
--10
INSERT INTO Offers (OfferID, ListingID, OfferDate, ExpireDate, OfferAmount, ApprovalNo) VALUES (Offer_Seq.nextval, 19, '22-May-2021', '29-May-2021', 250000, 14);

INSERT INTO OfferParticipants VALUES (10, 6);
INSERT INTO OfferParticipants VALUES (10, 7);

BEGIN
    purchase(10);
END;


BEGIN
    trade(7, 8);
END;

BEGIN
    trade(9, 10);
END;

-- 18, 19 Should own property 15
-- 6, 7 Should own property 18