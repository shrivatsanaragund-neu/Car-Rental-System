CREATE NONCLUSTERED INDEX IDX_Store_Location ON Store(City, Country);
 
CREATE NONCLUSTERED INDEX IDX_Car_CategoryStore ON Car(CategoryID, StoreID);
 
CREATE NONCLUSTERED INDEX IDX_Maintenance_CarDate ON Maintenance(CarID, MaintenanceDate);
 
CREATE NONCLUSTERED INDEX IDX_Billing_StatusDate ON Billing(Payment_Status, Payment_Date);