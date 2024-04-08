-- ReservationSupportView
CREATE VIEW [ReservationSupportView] AS
SELECT r.ReservationID, r.CustomerID, r.CarID, r.Pickup_Date_and_Time, r.Return_Date_and_Time,
       s.Support_Type, s.Support_Description, s.Support_Status
FROM Reservation r
LEFT JOIN Support s ON r.ReservationID = s.ReservationID;
