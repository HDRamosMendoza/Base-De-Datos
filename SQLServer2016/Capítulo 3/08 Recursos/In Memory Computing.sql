SELECT @@Version

CREATE DATABASE IMDemo;
GO

SELECT compatibility_level FROM sys.databases
WHERE database_id=DB_ID('IMDemo'); 

--Si no es 130
ALTER DATABASE IMDemo
SET COMPATIBILITY_LEVEL = 130;

--Elevar optimización de memoria a SNAPSHOT
ALTER DATABASE IMDemo
SET MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = ON;


--Anadir grupo de archivo para datos optimizados para memoria
ALTER DATABASE IMDemo
  ADD FILEGROUP IMDemo_MOD CONTAINS MEMORY_OPTIMIZED_DATA;
GO

--Anadir archivo de datos para datos optimizados para memoria
ALTER DATABASE IMDemo
 ADD FILE (NAME='IMDemo_MOD', FILENAME='D:\SQLData\SQL130\IMDemo_MOD.ndf')
 TO FILEGROUP IMDemo_MOD;
GO

--Creamos una tabla de prueba
USE IMDemo;
GO

CREATE TABLE dbo.MiTabla_MOD (
 Mtmod_ID int IDENTITY(1,1) NOT NULL,
 Mtmod_Fecha datetime NOT NULL,
 Mtmod_Status int NOT NULL

 CONSTRAINT PK_MiTabla_MOD PRIMARY KEY
   NONCLUSTERED HASH (Mtmod_ID) WITH (BUCKET_COUNT=20)
) WITH (MEMORY_OPTIMIZED=ON, DURABILITY=SCHEMA_AND_DATA);
GO

--Procedimiento almacenado de prueba
CREATE PROCEDURE dbo.InsertaMtmod
 WITH NATIVE_COMPILATION, SCHEMABINDING
AS
BEGIN ATOMIC WITH (TRANSACTION ISOLATION LEVEL = SNAPSHOT, LANGUAGE='spanish')
 DECLARE 
   @ID int = 1,
   @Status tinyint = 1,
   @Fecha datetime = getdate()

 WHILE @ID <= 100000
 BEGIN
   INSERT INTO dbo.MiTabla_MOD (Mtmod_Fecha,Mtmod_Status)
     VALUES (@Fecha, CAST(RAND()*1000 AS int))
   SET @ID += 1
 END
END;
GO

--ejecución del SP
EXEC dbo.InsertaMtmod;
GO

--Validación
SELECT COUNT(*) FROM dbo.MiTabla_MOD;
GO
SELECT * FROM dbo.MiTabla_MOD WHERE Mtmod_ID = 54321;
GO

--Optimización
SELECT * FROM sys.dm_db_xtp_hash_index_stats;
GO

ALTER TABLE dbo.MiTabla_MOD ALTER INDEX PK_MiTabla_MOD REBUILD WITH (BUCKET_COUNT= 400000);
GO

SELECT * FROM sys.dm_db_xtp_hash_index_stats;
GO
