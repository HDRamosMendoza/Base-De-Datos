CREATE DATABASE PruebaUsuario;
go
USE PruebaUsuario;
go
CREATE TABLE cargo(
	car_cod int not null primary key,
	car_des varchar(50) not null
)
GO
CREATE TABLE usuario(
	usu_codi int not null primary key,
	usu_nom varchar(50) not null,
	car_cod int not null references cargo
)
GO
INSERT INTO cargo(car_cod,car_des)
VALUES	(1,'Administrador'),
		(2,'Auxiliar'),
		(3,'Soporte')
GO
INSERT INTO usuario(usu_codi,usu_nom,car_cod) 
VALUES	(1,'Heber',1),
		(2,'Daniel',2),
		(3,'Juan',3),
		(4,'William',1)
GO
CREATE TABLE area(
	are_cod int primary key,
	are_des varchar(50)
)
GO
CREATE TABLE empleado(
	emp_cod int primary key,
	emp_nom varchar(50),
	are_cod int not null references area
)
GO
INSERT INTO area 
VALUES	(1, 'gerencia'),
		(2, 'recursos humanos'),
		(3, 'almacen')
GO
INSERT INTO empleado
VALUES	( 1, 'Luthiem', 1),
		( 2, 'Beren', 1),	
		( 3, 'Bildo', 2),
		( 4, 'Tom', 2),
		( 5, 'Merry', 3),
		( 6, 'Samwise', 3)
GO
----------------------------------------------------------------------------------------------
DROP PROCEDURE pr_listar_area
GO
CREATE PROCEDURE pr_listar_area
AS
	SELECT * 
	FROM area
GO
----------------------------------------------------------------------------------------------
DROP PROCEDURE pr_buscar_area
GO
CREATE PROCEDURE pr_buscar_area
@codigo int 
AS
	SELECT * 
	FROM area
	WHERE are_cod = @codigo
GO
----------------------------------------------------------------------------------------------
DROP PROCEDURE pr_insertar_area
GO
CREATE PROCEDURE pr_insertar_area
@descripcion varchar(100)
AS
	--Valiamos que no exista dos areas con el mismo nombre
	IF NOT EXISTS(
					SELECT *
					FROM dbo.area
					WHERE are_des = @descripcion
				)
BEGIN
	DECLARE @codigo1 int 
	SELECT @codigo1 = ISNULL(MAX(are_cod),0)+1 
	from area

	INSERT INTO dbo.area(are_cod, are_des) 
	values(@codigo1, @descripcion);
END
GO
----------------------------------------------------------------------------------------------
DROP PROCEDURE pr_actualizar_area 
GO
CREATE PROCEDURE pr_actualizar_area
@codigo2 int,
@descripcion2 varchar(100)
AS
	--Validamos que no existan dos areas con el mismo nombre.
	IF NOT EXISTS( 
					SELECT *
					FROM dbo.area
					WHERE are_des = @descripcion2
				)
BEGIN 
	UPDATE dbo.area 
	SET are_des = @descripcion2
	WHERE are_cod = @codigo2
END
GO
----------------------------------------------------------------------------------------------
DROP PROCEDURE pr_eliminar_area
GO
CREATE PROCEDURE pr_eliminar_area
@codigo3 int
AS
	DELETE area
	WHERE are_cod = @codigo3
GO
--------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------
CREATE DATABASE bd_validar
GO
USE bd_validar
GO
CREATE TABLE usuario(
	usuario_u varchar(10) primary key,
	clave_u varchar(10),
	nombreUsuario_u varchar(100)
) 
GO
INSERT INTO usuario(usuario_u, clave_u, nombreUsuario_u)
VALUES('LPintado','admin','Luthien Pintado'),('BCastillo','admin','Beren Castillo')
GO
CREATE TABLE curso(
	codigo_c int identity(1,1) primary key,
	nombre_c varchar(100),
	correo_c varchar(50) ,
	credito_c int
)
GO
INSERT INTO curso(nombre_c, correo_c, credito_c)
VALUES('Literatura','lit@gmail.com',3),('Matemàtica','mat@gmail.com',5),('Biòlogia','bio@gmail.com',6)
GO
----------------------------------------------------------------------------------------------
DROP PROCEDURE pr_login
GO
CREATE PROCEDURE pr_login
@P_Usuario varchar(10),
@P_Clave varchar(10)
AS
SELECT * FROM usuario
WHERE usuario_u = @P_Usuario and clave_u = @P_Clave
GO
----------------------------------------------------------------------------------------------
DROP PROCEDURE pr_listar_cursos
GO
CREATE PROCEDURE pr_listar_cursos
AS
SELECT * FROM curso
ORDER BY nombre_c
GO
----------------------------------------------------------------------------------------------
DROP PROCEDURE pr_registrar_curso
GO
CREATE PROCEDURE pr_registrar_curso
@C_NOMBRE varchar(50),
@C_EMAIL_CURSO varchar(50),
@C_CREDITOS int 
AS
-- No va a haber DOS CURSOS CON EL MISMO NOMBRE.
IF NOT EXISTS (SELECT * FROM curso WHERE nombre_c = @C_NOMBRE)
BEGIN
	INSERT INTO curso([nombre_c],[correo_c],[credito_c]) 
	VALUES (@C_NOMBRE,@C_EMAIL_CURSO,@C_CREDITOS)
END
----------------------------------------------------------------------------------------------




