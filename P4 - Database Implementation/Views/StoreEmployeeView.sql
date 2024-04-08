-- StoreEmployeeView
CREATE VIEW [StoreEmployeeView] AS
SELECT DISTINCT s.StoreID, s.StreetAddress, s.City, s.State, s.Country, s.Contact_No, s.Email_Address,
       e.EmployeeID, e.First_Name, e.Last_Name, e.Supervisor_ID
FROM Store s
JOIN Employee e ON s.StoreID = e.StoreID;
