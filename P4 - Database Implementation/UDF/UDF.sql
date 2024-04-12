
-- Function
CREATE FUNCTION dbo.CalculateTotalAmount (
    @HourlyRate DECIMAL(9,2),
    @PickupDate DATETIME,
    @ReturnDate DATETIME
)
RETURNS DECIMAL(9,2)
AS
BEGIN
    DECLARE @TotalAmount DECIMAL(9,2)
    
    -- Calculate the duration in hours between pickup and return dates
    DECLARE @Hours INT
    SET @Hours = DATEDIFF(HOUR, @PickupDate, @ReturnDate)
    
    -- Calculate the total amount based on the hourly rate and duration
    SET @TotalAmount = @HourlyRate * @Hours
    
    RETURN @TotalAmount
END;

-- Trigger

CREATE OR ALTER TRIGGER CalculateTotalAmountTrigger
ON Reservation
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Update the TotalAmount column for the inserted or updated rows
    UPDATE r
    SET TotalAmount = dbo.CalculateTotalAmount(cc.Hourly_Rate, r.Pickup_Date_and_Time, r.Return_Date_and_Time)
    FROM Reservation AS r
    INNER JOIN inserted AS i ON r.ReservationID = i.ReservationID
    INNER JOIN Car AS c ON r.CarID = c.CarID
    INNER JOIN Car_Category AS cc ON c.CategoryID = cc.CategoryID;
END;

CREATE TABLE ReservationAmount (
    reservation_id INT PRIMARY KEY,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (reservation_id) REFERENCES Reservation(ReservationID)
);