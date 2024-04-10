-- CarInsuranceView
CREATE VIEW [CarInsuranceView] AS
SELECT r.ReservationID, r.CarID, i.Coverage_Type, i.Coverage_Amount
FROM Reservation r
JOIN Insurance i ON r.ReservationID = i.ReservationID;