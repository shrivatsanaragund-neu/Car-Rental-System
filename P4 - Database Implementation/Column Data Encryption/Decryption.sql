OPEN SYMMETRIC KEY ColumnEncryptionSymmetricKey
DECRYPTION BY CERTIFICATE ColumnEncryptionCert;


SELECT 
    CustomerID,
    convert(varchar(max), DecryptByKey(Driver_LicenseNo)) as decrypted_DL,
    FirstName,
    LastName,
    ContactNo,
    Email_Address
FROM 
    Customer;



CLOSE SYMMETRIC KEY ColumnEncryptionSymmetricKey;