Use master;
GO

--Copia de seguridad
BACKUP DATABASE WideWorldImporters
TO DISK = 'D:\SQLBackups\WideWorldImporters_SinTDE.bak'
WITH INIT,
NAME = 'Full Backup WideWorldImporters antes de activar TDE';
GO

--Objetos de encriptado
CREATE MASTER KEY
ENCRYPTION BY PASSWORD = 'Tr@nsparentD@t@Encypti0nSQL2016';
GO

CREATE CERTIFICATE TDECert
WITH SUBJECT = 'Certificado de Transparent data Encryption';
GO

BACKUP CERTIFICATE TDECert
TO FILE = 'D:\SQLBackups\TDECert.bak'
WITH PRIVATE KEY (FILE = 'D:\SQLBackups\MasterCert.pvk',
                  ENCRYPTION BY PASSWORD = 'Cl@veDeC0piaDeSegurid@d');
GO

--Activa TDE
USE WideWorldImporters;
GO

CREATE DATABASE ENCRYPTION KEY
WITH ALGORITHM = AES_128
ENCRYPTION BY SERVER CERTIFICATE TDECert;
GO

ALTER DATABASE WideWorldImporters
SET ENCRYPTION ON

--Copia de seguridad
BACKUP DATABASE WideWorldImporters
TO DISK = 'D:\SQLBackups\WideWorldImporters_ConTDE.bak'
WITH INIT,
NAME = 'Full Backup WideWorldImporters despues de activar TDE';
GO

--Restaura copia de seguridad en otra instancia
USE master;
GO

RESTORE DATABASE WideWorldImporters
FROM  DISK = 'D:\SQLBackups\WideWorldImporters_ConTDE.bak'
WITH  MOVE 'WWI_Primary' TO 'C:\DBLSECData\WideWorldImporters.mdf',  
MOVE 'WWI_Log' TO 'D:\DBLSECLog\WideWorldImporters.ldf',
MOVE 'WWI_UserData' TO 'D:\DBLSECLog\WideWorldImporters_UserData.ndf';
GO

--Deshabilita TDE
USE master
ALTER DATABASE WideWorldImporters SET ENCRYPTION OFF;
GO

USE WideWorldImporters
DROP DATABASE ENCRYPTION KEY;
DROP CERTIFICATE TDECert;
DROP MASTER KEY;
