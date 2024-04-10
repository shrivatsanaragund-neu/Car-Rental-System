-- Create a master key for the database.
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'Admin@123';
GO

-- Create a certificate for encryption.
CREATE CERTIFICATE ColumnEncryptionCert
WITH SUBJECT = 'column encryption';
GO

-- Create a symmetric key with AES 256 algorithm using the certificate.
CREATE SYMMETRIC KEY ColumnEncryptionSymmetricKey
WITH ALGORITHM = AES_256
ENCRYPTION BY CERTIFICATE ColumnEncryptionCert;
GO

-- Open the symmetric key with which to encrypt the data.
OPEN SYMMETRIC KEY ColumnEncryptionSymmetricKey
DECRYPTION BY CERTIFICATE ColumnEncryptionCert;

-- Encrypt the existing values in the Driver_LicenseNo column.
UPDATE Customer
SET Driver_LicenseNo = EncryptByKey(Key_GUID('ColumnEncryptionSymmetricKey'), CONVERT(varbinary, Driver_LicenseNo));

-- Close the symmetric key.
CLOSE SYMMETRIC KEY ColumnEncryptionSymmetricKey;