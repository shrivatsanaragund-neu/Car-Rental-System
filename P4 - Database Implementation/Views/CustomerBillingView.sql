-- CustomerBillingView
CREATE VIEW [CustomerBillingView] AS
SELECT c.CustomerID, b.ReservationID, b.Bill_Amount_Total, b.Bill_Amount_Due, b.Payment_Date, 
       b.Payment_Status, b.Payment_Mode
FROM Customer c
JOIN Reservation r ON c.CustomerID = r.CustomerID
JOIN Billing b ON r.ReservationID = b.ReservationID;
