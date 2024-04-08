-- CarMaintenanceView
CREATE VIEW [CarMaintenanceView] AS
SELECT c.CarID, c.Make, c.Model, m.MaintenanceID, m.MaintenanceDate, m.MaintenanceDetails
FROM Car c
JOIN Maintenance m ON c.CarID = m.CarID;
