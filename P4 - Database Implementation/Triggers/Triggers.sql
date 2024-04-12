-- CREATE TRIGGER EnsureValidReservationDates
-- ON Reservation
-- AFTER INSERT, UPDATE
-- AS
-- BEGIN
--     IF EXISTS (SELECT 1 FROM inserted WHERE Pickup_Date_and_Time >= Return_Date_and_Time)
--     BEGIN
--         RAISERROR('Pickup date must be before return date.', 16, 1);
--         ROLLBACK TRANSACTION;
--     END
-- END;
 
 
 
-- CREATE TRIGGER UpdateCarAvailability
-- ON Reservation
-- AFTER INSERT, UPDATE, DELETE
-- AS
-- BEGIN
--     UPDATE Car
--     SET Availability = CASE
--                             WHEN r.ReservationID IS NOT NULL THEN 'FALSE'
--                             ELSE 'TRUE'
--                        END
--     FROM Car AS c
--     LEFT JOIN inserted AS i ON c.CarID = i.CarID
--     LEFT JOIN Reservation AS r ON c.CarID = r.CarID
-- END;
 
 
-- CREATE TRIGGER UpdateBillingStatus
-- ON Billing
-- AFTER INSERT, UPDATE
-- AS
-- BEGIN
--     UPDATE b
--     SET Payment_Status =
--         CASE
--             WHEN i.Payment_Date IS NOT NULL AND i.Bill_Amount_Total >= i.Bill_Amount_Due THEN 'Success'
--             WHEN i.Payment_Date IS NULL THEN 'In Progress'
--             ELSE 'Failed'
--         END
--     FROM Billing b
--     INNER JOIN inserted i ON b.BillingID = i.BillingID
-- END;