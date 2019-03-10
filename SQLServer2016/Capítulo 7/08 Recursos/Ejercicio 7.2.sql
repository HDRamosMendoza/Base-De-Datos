--Inicios de Sesión y Usuarios
USE master;

CREATE LOGIN MailAdmin
WITH Password = 'Pa$$W0rd';
GO

CREATE LOGIN MailUser
WITH Password = 'Pa$$W0rd';
GO

USE WideWorldImporters;
GO

CREATE USER MailAdmin FOR LOGIN MailAdmin;
GO

CREATE USER MailUser FOR LOGIN MailUser
GO

--Preparar tabla para mantener con encriptación
SELECT PersonID, FullName, LogonName, EmailAddress 
INTO dbo.PeopleInfo
FROM Application.People

GRANT SELECT, INSERT, UPDATE ON dbo.PeopleInfo
TO MailAdmin, MailUser

Use master;
GO

--Objetos para encriptación
CREATE MASTER KEY  
ENCRYPTION BY PASSWORD = 'Pa$$w0rd';
GO

CREATE CERTIFICATE MailAdminCert 
AUTHORIZATION MailAdmin
WITH SUBJECT = 'Certificado para cuentas de correo';
GO

CREATE SYMMETRIC KEY MailKey 
AUTHORIZATION MAilAdmin 
WITH ALGORITHM = AES_256 
ENCRYPTION BY CERTIFICATE MailAdminCert;
GO

--Mantenimiento de información
EXECUTE AS USER = 'MailAdmin';
GO

OPEN SYMMETRIC KEY MailKey
DECRYPTION BY CERTIFICATE MailAdminCert;

INSERT INTO dbo.PeopleInfo (PersonID, FullName, LogonName, EmailAddress) 
	VALUES (
	5000, 
	'Persona de Prueba 1',
	'PerPru1',
	EncryptByKey(Key_GUID('MailKey'),'Perpru1@outlook.com'));

	CLOSE ALL SYMMETRIC KEYS;

select * from dbo.PeopleInfo WHERE PersonID = 5000;

REVERT

--Consulta de información
EXECUTE AS USER = 'MailAdmin';
GO

OPEN SYMMETRIC KEY MailKey DECRYPTION BY CERTIFICATE MailAdminCert
SELECT PersonID, FullName, LogonName, 
       CAST(DecryptByKey(EmailAddress) AS varchar(100)) AS EmailAddress
	FROM dbo.PeopleInfo
	ORDER BY 1 DESC
CLOSE ALL SYMMETRIC KEYS

REVERT

SELECT 
PersonID, 
FullName, 
LogonName,
EmailAddress
FROM dbo.PeopleInfo 
ORDER BY 1 DESC

--Consulta de información
EXECUTE AS USER = 'MailUser';
GO

OPEN SYMMETRIC KEY MailKey DECRYPTION BY CERTIFICATE MailAdminCert
SELECT PersonID, FullName, LogonName, 
       CAST(DecryptByKey(EmailAddress) AS varchar(100)) AS EmailAddress
	FROM dbo.PeopleInfo
	ORDER BY 1 DESC
CLOSE ALL SYMMETRIC KEYS

REVERT

--Limpieza
DROP SYMMETRIC KEY MailKey;
DROP CERTIFICATE MailAdminCert;
DROP MASTER KEY;
GO