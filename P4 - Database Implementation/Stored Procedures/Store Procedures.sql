CREATE PROCEDURE GetCarByCategory @CategorID INT
AS
BEGIN
	SELECT c.*
	FROM Car_Category cc
	LEFT JOIN Car c ON cc.CategoryID = c.CategoryID
	WHERE cc.CategoryID = @CategorID
END

EXEC GetCarByCategory 2

CREATE PROCEDURE GetCarByMake @Make VARCHAR(100)
AS
BEGIN
	SELECT c.*
	FROM Car c
	WHERE c.Make = @Make
END

EXEC GetCarByMake 'Honda'

CREATE PROCEDURE GetEmployeeInStore @StoreID INT
AS
BEGIN
	SELECT e.*
	FROM Store s
	LEFT JOIN Employee e ON s.StoreID = e.StoreID
	WHERE s.StoreID = @StoreID
END

EXEC GetEmployeeInStore 2

CREATE PROCEDURE GetReservationFromCustomer @CustomerID INT
AS
BEGIN
	SELECT r.*
	FROM Customer c
	LEFT JOIN Reservation r ON c.CustomerID = r.CustomerID
	WHERE c.CustomerID = @CustomerID
END

EXEC GetReservationFromCustomer 1

CREATE PROCEDURE GetSupportFromCustomer @CustomerID INT
AS
BEGIN
	SELECT s.*
	FROM Customer c
	LEFT JOIN Support s ON c.CustomerID = s.CustomerID
	WHERE c.CustomerID = @CustomerID
END

EXEC GetSupportFromCustomer 2

CREATE PROCEDURE GetSupportFromEmployee @EmployeeID INT
AS
BEGIN
	SELECT s.*
	FROM Employee e
	LEFT JOIN Support s ON e.EmployeeID = s.EmployeeID
	WHERE e.EmployeeID = @EmployeeID
END

EXEC GetSupportFromEmployee 2