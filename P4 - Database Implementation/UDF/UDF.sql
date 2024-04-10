CREATE FUNCTION dbo.CalculateTotalAmount (
    @HourlyRate DECIMAL(9,2),
    @PickupDate DATETIME,
    @ReturnDate DATETIME
)
RETURNS DECIMAL(9,2)
AS
BEGIN
    DECLARE @TotalAmount DECIMAL(9,2)
    
    SET @TotalAmount = @HourlyRate * DATEDIFF(HOUR, @PickupDate, @ReturnDate)
    
    RETURN @TotalAmount
END;