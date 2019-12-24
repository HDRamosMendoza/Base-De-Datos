GO
USE master
GO
DROP DATABASE DB_WebIDE;
GO
CREATE DATABASE DB_WebIDE;
GO
USE DB_WebIDE;
GO
IF OBJECT_ID('[DB_WebIDE].[dbo].[Usuario]') IS NOT NULL
DROP TABLE [DB_WebIDE].[dbo].[Usuario]
GO
CREATE TABLE [DB_WebIDE].[dbo].[Usuario](
	usu_id int IDENTITY(1,1),
	usu_nomb nvarchar(45),
	usu_ape nvarchar(45),
	usu_ali nvarchar(20) UNIQUE,
	usu_rol int NOT NULL,
	usu_act int DEFAULT 0,
	usu_fact date,
	usu_fedi date,
	usu_freg datetime DEFAULT (GETDATE()),
	PRIMARY KEY(usu_id)
)
GO
IF OBJECT_ID('[DB_WebIDE].[dbo].[NoticiaImagen]') IS NOT NULL
DROP TABLE [DB_WebIDE].[dbo].[NoticiaImagen]
GO
CREATE TABLE [DB_WebIDE].[dbo].[NoticiaImagen](
	notimg_id int IDENTITY(1,1),
	notimg_img nvarchar(50),
	notimg_fact date,
	notimg_fedi date,
	notimg_freg datetime DEFAULT (GETDATE()),
	PRIMARY KEY(notimg_id)
)
GO
IF OBJECT_ID('[DB_WebIDE].[dbo].[Noticia]') IS NOT NULL
DROP TABLE [DB_WebIDE].[dbo].[Noticia]
GO
CREATE TABLE [DB_WebIDE].[dbo].[Noticia](
	not_id int IDENTITY(1,1),
	not_nomb nvarchar(50),
	not_desc nvarchar(100),
	not_fact date,
	not_fedi date,
	not_freg datetime DEFAULT (GETDATE()),
	pub_id_fk int,
	notimg_id_fk int, 
	PRIMARY KEY(not_id)
)
GO
IF OBJECT_ID('[DB_WebIDE].[dbo].[TipoRecurso]') IS NOT NULL
DROP TABLE [DB_WebIDE].[dbo].[TipoRecurso]
GO
CREATE TABLE [DB_WebIDE].[dbo].[TipoRecurso](
	tiprec_id int IDENTITY(1,1),
	tiprec_nomb nvarchar(20),
	tiprec_fact date,
	tiprec_fedi date,
	tiprec_freg datetime DEFAULT (GETDATE()),
	PRIMARY KEY(tiprec_id)
)
GO
IF OBJECT_ID('[DB_WebIDE].[dbo].[Recurso]') IS NOT NULL
DROP TABLE [DB_WebIDE].[dbo].[Recurso]
GO
CREATE TABLE [DB_WebIDE].[dbo].[Recurso](
	rec_id int IDENTITY(1,1),
	rec_nomb nvarchar(45) UNIQUE,
	rec_desc nvarchar(45),
	rec_inst nvarchar(45),
	rec_resp nvarchar(45),
	rec_link nvarchar(45),
	rec_img nvarchar(45),
	rec_fact date,
	rec_fedi date,
	rec_freg datetime DEFAULT (GETDATE()),
	tiprec_id_fk int,
	pub_id_fk int,
	PRIMARY KEY(rec_id)
)
GO
IF OBJECT_ID('[DB_WebIDE].[dbo].[Escala]') IS NOT NULL
DROP TABLE [DB_WebIDE].[dbo].[Escala]
GO
CREATE TABLE [DB_WebIDE].[dbo].[Escala](
	escal_id int IDENTITY(1,1),
	escal_escala nvarchar(20),
	escal_fact date,
	escal_fedi date,
	escal_freg datetime DEFAULT (GETDATE()),
	PRIMARY KEY(escal_id)
)
GO
IF OBJECT_ID('[DB_WebIDE].[dbo].[TipoCatalogoWeb]') IS NOT NULL
DROP TABLE [DB_WebIDE].[dbo].[TipoCatalogoWeb]
GO
CREATE TABLE [DB_WebIDE].[dbo].[TipoCatalogoWeb](
	tipcat_id int IDENTITY(1,1),
	tipcat_nomb nvarchar(45),
	tipcat_desc nvarchar(10),
	tipcat_fact date,
	tipcat_fedi date,
	tipcat_freg datetime DEFAULT (GETDATE()),
	PRIMARY KEY(tipcat_id)
)
GO
IF OBJECT_ID('[DB_WebIDE].[dbo].[CatalogoWweb]') IS NOT NULL
DROP TABLE [DB_WebIDE].[dbo].[CatalogoWeb]
GO
CREATE TABLE [DB_WebIDE].[dbo].[CatalogoWeb](
	cat_id int IDENTITY(1,1),
	cat_nomb nvarchar(45),
	cat_desc nvarchar(60),
	cat_esca int,
	cat_inst nvarchar(45),
	cat_link nvarchar(200),
	cat_fact date,
	cat_fedi date,
	cat_freg datetime DEFAULT (GETDATE()),
	tipcat_id_fk int,
	pub_id_fk int,
	escal_id_fk int,
	PRIMARY KEY(cat_id)
)
GO
IF OBJECT_ID('[DB_WebIDE].[dbo].[TipoNormaEstandar]') IS NOT NULL
DROP TABLE [DB_WebIDE].[dbo].[TipoNormaEstandar]
GO
CREATE TABLE [DB_WebIDE].[dbo].[TipoNormaEstandar](
	tipnor_id int IDENTITY(1,1),
	tipnor_nomb nvarchar(45),
	tipnor_fact date,
	tipnor_fedi date,
	tipnor_freg datetime DEFAULT (GETDATE()),
	PRIMARY KEY(tipnor_id)
)
GO
IF OBJECT_ID('[DB_WebIDE].[dbo].[OrganismoNormador]') IS NOT NULL
DROP TABLE [DB_WebIDE].[dbo].[OrganismoNormador]
GO
CREATE TABLE [DB_WebIDE].[dbo].[OrganismoNormador](
	org_id int IDENTITY(1,1),
	org_abrev nvarchar(20),
	org_nomb nvarchar(200),
	org_link nvarchar(200),
	org_origen int DEFAULT 0,
	org_fact date,
	org_fedi date,
	org_freg datetime DEFAULT (GETDATE()),
	PRIMARY KEY(org_id)
)
GO
IF OBJECT_ID('[DB_WebIDE].[dbo].[NormaEstandar]') IS NOT NULL
DROP TABLE [DB_WebIDE].[dbo].[NormaEstandar]
GO
CREATE TABLE [DB_WebIDE].[dbo].[NormaEstandar](
	nor_id int IDENTITY(1,1),
	nor_nomb nvarchar(45),
	nor_desc nvarchar(45),
	nor_resp nvarchar(45),
	nor_fact date,
	nor_fedi date,
	nor_freg datetime DEFAULT (GETDATE()),
	tipnor_id_fk int,
	org_id_fk int,
	pub_id_fk int,
	PRIMARY KEY(nor_id)
)
GO
/*
	Hay una gran probabilidad de que la tabla CONTACTAR
	solo este de modelo ya que se deberia enviar mensaje 
	directamente al correo institucional.
*/
IF OBJECT_ID('[DB_WebIDE].[dbo].[Contacto]') IS NOT NULL
DROP TABLE [DB_WebIDE].[dbo].[Contactar]
GO
CREATE TABLE [DB_WebIDE].[dbo].[Contactar](
	cont_id int IDENTITY(1,1),
	cont_nomb nvarchar(45),
	cont_tel nvarchar(45),
	cont_corr nvarchar(45),
	cont_sms nvarchar(150),
	cont_fact date,
	cont_fedi date,
	cont_freg datetime DEFAULT (GETDATE()),
	PRIMARY KEY(cont_id)
)
GO
IF OBJECT_ID('[DB_WebIDE].[dbo].[Publicacion]') IS NOT NULL
DROP TABLE [DB_WebIDE].[dbo].[Publicacion]
GO
CREATE TABLE [DB_WebIDE].[dbo].[Publicacion](--Tabla maestra
	pub_id int IDENTITY(1,1),
	pub_edi int DEFAULT YEAR(GETDATE()),
	pub_fact date,
	pub_fedi date,
	pub_freg datetime DEFAULT (GETDATE()),
	usu_id_fk int,
	PRIMARY KEY(pub_id)
)
GO
ALTER TABLE [DB_WebIDE].[dbo].[Recurso]
ADD CONSTRAINT FK_Recurso_TipoRecurso
FOREIGN KEY (tiprec_id_fk) 
REFERENCES [DB_WebIDE].[dbo].[TipoRecurso](tiprec_id)
GO
ALTER TABLE [DB_WebIDE].[dbo].[Recurso]
ADD CONSTRAINT FK_Recurso_Publicacion
FOREIGN KEY (pub_id_fk) 
REFERENCES [DB_WebIDE].[dbo].[Publicacion](pub_id)
GO
ALTER TABLE [DB_WebIDE].[dbo].[CatalogoWeb]
ADD CONSTRAINT FK_CatalogoWeb_TipoCatalogoWeb
FOREIGN KEY (tipcat_id_fk)
REFERENCES [DB_WebIDE].[dbo].[TipoCatalogoWeb](tipcat_id)
GO
ALTER TABLE [DB_WebIDE].[dbo].[CatalogoWeb]
ADD CONSTRAINT FK_CatalogoWeb_Escala
FOREIGN KEY (escal_id_fk)
REFERENCES [DB_WebIDE].[dbo].[Escala](escal_id)
GO
ALTER TABLE [DB_WebIDE].[dbo].[CatalogoWeb]
ADD CONSTRAINT FK_CatalogoWeb_Publicacion
FOREIGN KEY (pub_id_fk)
REFERENCES [DB_WebIDE].[dbo].[Publicacion](pub_id)
GO
ALTER TABLE [DB_WebIDE].[dbo].[NormaEstandar]
ADD CONSTRAINT FK_NormaEstandar_TipoNormaEstandar
FOREIGN KEY (tipnor_id_fk)
REFERENCES [DB_WebIDE].[dbo].[TipoNormaEstandar](tipnor_id)
GO
ALTER TABLE [DB_WebIDE].[dbo].[NormaEstandar]
ADD CONSTRAINT FK_NormaEstandar_Publicacion
FOREIGN KEY (pub_id_fk)
REFERENCES [DB_WebIDE].[dbo].[Publicacion](pub_id)
GO
ALTER TABLE [DB_WebIDE].[dbo].[NormaEstandar]
ADD CONSTRAINT FK_NormaEstandar_OrganismoNormador
FOREIGN KEY (org_id_fk)
REFERENCES [DB_WebIDE].[dbo].[OrganismoNormador](org_id)
GO
ALTER TABLE [DB_WebIDE].[dbo].[Noticia]
ADD CONSTRAINT FK_Noticia_NoticiaImagen
FOREIGN KEY (notimg_id_fk)
REFERENCES [DB_WebIDE].[dbo].[NoticiaImagen](notimg_id)
GO
ALTER TABLE [DB_WebIDE].[dbo].[Noticia]
ADD CONSTRAINT FK_Noticia_Publicacion
FOREIGN KEY (pub_id_fk)
REFERENCES [DB_WebIDE].[dbo].[Publicacion](pub_id)
GO
ALTER TABLE [DB_WebIDE].[dbo].[Publicacion]
ADD CONSTRAINT FK_Publicacion_Usuario
FOREIGN KEY (usu_id_fk)
REFERENCES [DB_WebIDE].[dbo].[Usuario](usu_id)
GO
/*************************************************************************************************************************** INSERTAR PUBLICACION **/
INSERT INTO Publicacion(pub_edi) values('2016');
/*************************************************************************************************************************** INSERTAR CATALOGO WEB **/
INSERT INTO Escala (escal_escala) 
    VALUES	('1K'),('25K'),('50K'),('100K'),('500K'),('1M'),('Escala Normalizada');
GO
SELECT * FROM Escala 
GO
INSERT INTO dbo.TipoCatalogoWeb (tipcat_nomb, tipcat_desc) 
    VALUES	('Servicio de Cobertura','SC'),
			('Servicio de Descarga','SD'),
			('Servicio de Visualización','SV');
GO
SELECT * FROM TipoCatalogoWeb 
GO /* Servicio de Visualizacion */
INSERT INTO CatalogoWeb(cat_nomb,cat_desc,cat_inst,cat_link,tipcat_id_fk,pub_id_fk,escal_id_fk)
VALUES	('Cuadro Empalme','','Instituto Geográfico Nacional del Perú','http://www.idep.gob.pe:6080/arcgis/services/IDE_IGN/CUADRO_DE_EMPALME/MapServer/WMSServer?request=GetCapabilities&service=WMS',3,1,2),
		('Cuadro Empalme','','Instituto Geográfico Nacional del Perú','http://www.idep.gob.pe:6080/arcgis/services/IDE_IGN/CUADRO_DE_EMPALME/MapServer/WMSServer?request=GetCapabilities&service=WMS',3,1,3),
		('Cuadro Empalme','','Instituto Geográfico Nacional del Perú','http://www.idep.gob.pe:6080/arcgis/services/IDE_IGN/CUADRO_DE_EMPALME/MapServer/WMSServer?request=GetCapabilities&service=WMS',3,1,4),
		('Transporte y Comunicaciones','','Instituto Geográfico Nacional del Perú','http://www.idep.gob.pe:6080/arcgis/services/IDE_IGN/TRANSPORTES_Y_COMUNICACIONES_100K/MapServer/WMSServer?request=GetCapabilities&service=WMS',3,1,4),
		('Transporte y Comunicaciones','','Instituto Geográfico Nacional del Perú','http://www.idep.gob.pe:6080/arcgis/services/IDE_IGN/TRANSPORTES_Y_COMUNICACIONES_500K/MapServer/WMSServer?request=GetCapabilities&service=WMS',3,1,5),
		('Toponimia','','Instituto Geográfico Nacional del Perú','http://www.idep.gob.pe:6080/arcgis/services/IDE_IGN/TOPONIMIA_500K/MapServer/WMSServer?request=GetCapabilities&service=WMS',3,1,5),
		('Moquegua Tacna','','Instituto Geográfico Nacional del Perú','http://www.idep.gob.pe:6080/arcgis/services/IDE_IGN/MOQUEGUA_TACNA_25K/MapServer/WMSServer?request=GetCapabilities&service=WMS',3,1,2),
		('Puente Piedra','','Instituto Geográfico Nacional del Perú','http://www.idep.gob.pe:6080/arcgis/services/IDE_IGN/PUENTE_PIEDRA/MapServer/WMSServer?request=GetCapabilities&service=WMS',3,1,7),
		('Parque Nacional Otishi:','','Instituto Geográfico Nacional del Perú','http://www.idep.gob.pe:6080/arcgis/services/IDE_IGN/PARQUE_NACIONAL_OTISHI_WMS/MapServer/WMSServer?request=GetCapabilities&service=WMS',3,1,7),
		('Nazca','','Instituto Geográfico Nacional del Perú','http://www.idep.gob.pe:6080/arcgis/services/IDE_IGN/Nazca/MapServer/WMSServer?request=GetCapabilities&service=WMS',3,1,1),
		('Caral','','Instituto Geográfico Nacional del Perú','http://www.idep.gob.pe:6080/arcgis/services/IDE_IGN/CARAL_25K/MapServer/WMSServer?request=GetCapabilities&service=WMS',3,1,4),
		('Caral','','Instituto Geográfico Nacional del Perú','http://www.idep.gob.pe:6080/arcgis/services/IDE_IGN/CARAL_25K/MapServer/WMSServer?request=GetCapabilities&service=WMS',3,1,5),
		('Proyectos Cartográficos IGN','','Instituto Geográfico Nacional del Perú','http://www.idep.gob.pe:6080/arcgis/services/IDE_IGN/Proyectos_Cartograficos_IGN/MapServer/WMSServer?request=GetCapabilities&service=WMS',3,1,7),
		('Límites','','Instituto Geográfico Nacional del Perú','http://www.idep.gob.pe:6080/arcgis/services/IDE_IGN/LIMITES/MapServer/WMSServer?request=GetCapabilities&service=WMS',3,1,4),
		('Cultura','','Instituto Geográfico Nacional del Perú','http://www.idep.gob.pe:6080/arcgis/services/IDE_IGN/CULTURAL_100K/MapServer/WMSServer?request=GetCapabilities&service=WMS',3,1,4),
		('Cultura','','Instituto Geográfico Nacional del Perú','http://www.idep.gob.pe:6080/arcgis/services/IDE_IGN/CULTURAL_500K/MapServer/WMSServer?request=GetCapabilities&service=WMS',3,1,5),
		('Fisiografía','','Instituto Geográfico Nacional del Perú','http://www.idep.gob.pe:6080/arcgis/services/IDE_IGN/FISIOGRAFIA_100K/MapServer/WMSServer?request=GetCapabilities&service=WMS',3,1,4),
		('Fisiografía','','Instituto Geográfico Nacional del Perú','http://www.idep.gob.pe:6080/arcgis/services/IDE_IGN/FISIOGRAFIA500K/MapServer/WMSServer?request=GetCapabilities&service=WMS',3,1,5),
		('Hidrografía','','Instituto Geográfico Nacional del Perú','http://www.idep.gob.pe:6080/arcgis/services/IDE_IGN/HIDROGRAFIA_100K/MapServer/WMSServer?request=GetCapabilities&service=WMS',3,1,4),
		('Hidrografía','','Instituto Geográfico Nacional del Perú','http://www.idep.gob.pe:6080/arcgis/services/IDE_IGN/HIDROGRAFIA_500K/MapServer/WMSServer?request=GetCapabilities&service=WMS',3,1,5),
		('Industria','','Instituto Geográfico Nacional del Perú','http://www.idep.gob.pe:6080/arcgis/services/IDE_IGN/INDUSTRIA_500K/MapServer/WMSServer?request=GetCapabilities&service=WMS',3,1,5);		
GO /* Servicio de Descarga */
INSERT INTO CatalogoWeb(cat_nomb,cat_desc,cat_inst,cat_link,tipcat_id_fk,pub_id_fk,escal_id_fk)
VALUES	('Cuadro Empalme','','Instituto Geográfico Nacional del Perú','http://www.idep.gob.pe:6080/arcgis/services/IDE_IGN/CUADRO_DE_EMPALME/MapServer/WMSServer?request=GetCapabilities&service=WMS',2,1,2),
		('Cuadro Empalme','','Instituto Geográfico Nacional del Perú','http://www.idep.gob.pe:6080/arcgis/services/IDE_IGN/CUADRO_DE_EMPALME/MapServer/WMSServer?request=GetCapabilities&service=WMS',2,1,3),
		('Cuadro Empalme','','Instituto Geográfico Nacional del Perú','http://www.idep.gob.pe:6080/arcgis/services/IDE_IGN/CUADRO_DE_EMPALME/MapServer/WMSServer?request=GetCapabilities&service=WMS',2,1,4);
GO /* Servicio de Cobertura */
INSERT INTO CatalogoWeb(cat_nomb,cat_desc,cat_inst,cat_link,tipcat_id_fk,pub_id_fk,escal_id_fk)
VALUES	('Cuadro Empalme','','Instituto Geográfico Nacional del Perú','http://www.idep.gob.pe:6080/arcgis/services/IDE_IGN/CUADRO_DE_EMPALME/MapServer/WMSServer?request=GetCapabilities&service=WMS',1,1,2),
		('Cuadro Empalme','','Instituto Geográfico Nacional del Perú','http://www.idep.gob.pe:6080/arcgis/services/IDE_IGN/CUADRO_DE_EMPALME/MapServer/WMSServer?request=GetCapabilities&service=WMS',1,1,3);
GO
SELECT * FROM CatalogoWeb;
GO /* Recurso */
INSERT INTO dbo.TipoRecurso(tiprec_nomb)
	VALUES	('Doc. Tecnico'),
			('Tutorial'),
			('Manual');
SELECT * FROM TipoRecurso;
GO /* Recurso Documento Tecnico */
INSERT INTO Recurso(rec_nomb,rec_desc,rec_inst,rec_resp,rec_link,rec_img,tiprec_id_fk,pub_id_fk)
VALUES	('Prueba1','Es una prueba','Instituto Geografic Nacional','Reynaldo Flores','http:www.google.com','',1,1),
		('Prueba2','Es una prueba','Instituto Geografic Nacional','Reynaldo Flores','http:www.google.com','',1,1),
		('Prueba3','Es una prueba','Instituto Geografic Nacional','Reynaldo Flores','http:www.google.com','',1,1);
GO
SELECT * FROM Recurso WHERE tiprec_id_fk = 1
GO /* Recurso Video Tutorial */
INSERT INTO Recurso(rec_nomb,rec_desc,rec_inst,rec_resp,rec_link,rec_img,tiprec_id_fk,pub_id_fk)
VALUES	('Prueba 1','Es una prueba','Instituto Geografic Nacional','Reynaldo Flores','http:www.google.com','',2,1),
		('Prueba 2','Es una prueba','Instituto Geografic Nacional','Reynaldo Flores','http:www.google.com','',2,1),
		('Prueba 3','Es una prueba','Instituto Geografic Nacional','Reynaldo Flores','http:www.google.com','',2,1);
GO
SELECT * FROM Recurso WHERE tiprec_id_fk = 2
GO
INSERT INTO dbo.OrganismoNormador(org_abrev,org_nomb,org_link,org_origen)
	VALUES	('PCM','Presidencia de Consejos de Ministros','http://www.pcm.gob.pe/',1),
			('ONGEI','Oficina Nacional de Gobierno Electrónico e Informatica','http://www.ongei.gob.pe/',1),
			('CCIDEP','Comité Coordinador Permanente de la Infraestructura de Datos espaciales del Perú','http://www.geoidep.gob.pe/index.php/principalesactoresylogros/ccidep',1),
			('GSDI','Global Spatial Data Infraestructure.','http://gsdiassociation.org/',0),
			('UN-GGIM: AMÉRICAS','Comité Regional de las Naciones Unidas sobre la Gestión Global de Información Geoespacial para las Américas.','http://www.cp-idea.org/',0),
			('GeoSur','La Red Geoespacial de América Latina y el Caribe.','http://www.geosur.info/geosur/index.php/es/',0),
			('ISO TC / 211','Geographic Information / Geomatics.','http://www.isotc211.org/',0);
GO
INSERT INTO dbo.TipoNormaEstandar(tipnor_nomb)
	VALUES	('Norma'),
			('Estandar'),
			('Política'),
			('Propuestas'),
			('Otro');
GO
SELECT * FROM dbo.TipoNormaEstandar;
GO
INSERT INTO dbo.NormaEstandar(nor_nomb,nor_desc,nor_resp)
	VALUES	('ISO/TC 211','Descripcion de ISO','IGN'),
			('Politica de Metadatos Geoespaciales','Descripcion de ISO','IGN'),
			('Politica Nacional de Datos Espaciales','Descripcion de ISO','IGN');
GO
SELECT * FROM dbo.NormaEstandar
/*************************************************************************************************************************** PR_USUARIO **/
DROP PROCEDURE pr_insertar_usuario;
GO
CREATE PROCEDURE pr_insertar_usuario(
	@usu_nomb NVARCHAR(45),
	@usu_ape NVARCHAR(45),
	@usu_ali NVARCHAR(20),
	@usu_rol INT,
	@usu_ID INT OUTPUT
)
AS
	IF NOT EXISTS(SELECT * FROM dbo.Usuario WHERE usu_ali = @usu_ali)
		BEGIN
			INSERT INTO Usuario(usu_nomb,usu_ape,usu_ali,usu_rol) 
			VALUES(@usu_nomb,@usu_ape,@usu_ali,@usu_rol)
			SET @usu_ID = SCOPE_IDENTITY()
		END
	ELSE
		SET @usu_ID = 0
GO
DECLARE @ID INT
EXEC pr_insertar_usuario 'Heber Daniel','Ramos Mendoza','hramos',2,@ID OUTPUT;
SELECT @ID
GO
SELECT * FROM Usuario;
/*delimitacion de / limitacion de cuencas*/
/*************************************************************************************************************************** PR_PUBLICACION **/
/* Variable de ingreso en el ID del USUARIO y la salida es ID de la ultima PUBLICACION */
DROP PROCEDURE pr_insertar_publicacion;
GO
CREATE PROCEDURE pr_insertar_publicacion(
	@usuario_id INT,
	@publicacion_id INT OUTPUT
)
AS
BEGIN
	INSERT INTO dbo.Publicacion(pub_edi,usu_id_fk) VALUES(YEAR(GETDATE()),@usuario_id);
	SET @publicacion_id = SCOPE_IDENTITY();
END
GO
DECLARE @ID INT
EXEC pr_insertar_publicacion 1,@ID OUTPUT;
SELECT @ID
GO
SELECT * FROM Publicacion;
/*************************************************************************************************************************** PR_ORGANISMONORMADOR **/

SELECT * FROM dbo.OrganismoNormador;
GO
DROP PROCEDURE pr_insertar_organismonormador;
GO
CREATE PROCEDURE pr_insertar_organismonormador
	@org_abrev NVARCHAR(11),
	@org_nomb NVARCHAR(45),
	@org_link NVARCHAR(45),
	@org_origen INT,
	@organismonormador_id INT OUTPUT
AS
	IF NOT EXISTS(SELECT * FROM OrganismoNormador WHERE org_nomb = @org_nomb)
	BEGIN
		INSERT INTO OrganismoNormador(org_abrev,org_nomb,org_link,org_origen) 
		VALUES (@org_abrev, @org_nomb, @org_link, @org_origen)
		SET @organismonormador_id = SCOPE_IDENTITY();
	END
	ELSE
		SET @organismonormador_id = 0;
GO
DECLARE @ID INT
EXEC pr_insertar_organismonormador 'Prueba abreviatura','Prueba Nom77YYbre','www.abreviatura.com',0,@ID OUTPUT;
SELECT @ID
GO
SELECT * FROM OrganismoNormador;
/*************************************************************************************************************************** PR_NORMADORESTANDAR **/
GO
DROP PROCEDURE pr_insertar_normaestandar;
GO
CREATE PROCEDURE pr_insertar_normaestandar(
	@nor_nomb NVARCHAR(45),
	@nor_desc NVARCHAR(45),
	@nor_resp NVARCHAR(45),
	@tipnor_id_fk INT,
	@org_id_fk INT,
	@pub_id_fk INT,
	@resp INT OUTPUT
)
AS
	IF NOT EXISTS(SELECT * FROM NormaEstandar WHERE nor_nomb = @nor_nomb) 
	BEGIN
		INSERT INTO dbo.NormaEstandar(nor_nomb,nor_desc,nor_resp,tipnor_id_fk,org_id_fk,pub_id_fk)
		VALUES(@nor_nomb, @nor_desc, @nor_resp, @tipnor_id_fk, @org_id_fk, @pub_id_fk);
		SET @resp = 1;
	END
	ELSE
		SET @resp = 0;	
GO
DECLARE @resp INT
EXEC pr_insertar_normaestandar'Prueba PublicSSacion','Prueba descripcion','Prueba Responsable',1,1,1,@resp OUTPUT
SELECT @resp
GO
SELECT * FROM dbo.NormaEstandar;
GO
/*************************************************************************************************************************** PR_NOTICIA **/
USE bd_validar
GO
INSERT INTO Noticia(not_nomb,not_desc)
VALUES	('1 Nombre prueba','1 Descripcion prueba'),
		('2 Nombre prueba','2 Descripcion prueba'),
		('3 Nombre prueba','3 Descripcion prueba'),
		('4 Nombre prueba','4 Descripcion prueba'),
		('5 Nombre prueba','5 Descripcion prueba');

GO
DROP PROCEDURE pr_lista_noticia
GO
CREATE PROCEDURE pr_lista_noticia
AS
	BEGIN
		/* La consultra se debe de mejorar ya que se realizara una consulta a dos tablas*/
		SELECT not_nomb, not_desc
		FROM Noticia
	END
GO
EXEC pr_lista_noticia
GO
DROP PROCEDURE pr_insertar_noticia;
GO
CREATE PROCEDURE pr_insertar_noticia(
	@not_nomb NVARCHAR(50),
	@not_desc NVARCHAR(100),
	@pub_id_fk INT,
	@resp INT OUTPUT
)
AS
	IF NOT EXISTS (SELECT * FROM dbo.Noticia WHERE not_nomb = @not_nomb)
		BEGIN
			INSERT INTO dbo.Noticia(not_nomb,not_desc,pub_id_fk)
			VALUES(@not_nomb,@not_desc,@pub_id_fk);
			SET @resp = 1;
		END
	ELSE
		SET @resp = 0;
GO
DECLARE @resp INT
EXEC pr_insertar_noticia 'PrKKuebahh LLNombre', 'Prueba descripcion',1,@resp OUTPUT;
SELECT @resp
GO
SELECT * FROM dbo.Noticia
/*************************************************************************************************************************** RECURSO **/
GO
DROP PROCEDURE pr_tiporecurso;
GO
CREATE PROCEDURE pr_tiporecurso(
	@tiprec_nomb NVARCHAR(20),
	@resp INT OUTPUT
)
AS
	IF NOT EXISTS(SELECT * FROM dbo.TipoRecurso WHERE tiprec_nomb = @tiprec_nomb)
		BEGIN
			INSERT INTO TipoRecurso(tiprec_nomb)
			VALUES(@tiprec_nomb);
			SET @resp = 1;
		END
	ELSE
		SET @resp = 0;
GO
DECLARE @resp INT
EXEC pr_tiporecurso 'Prueba Nomdbre',@resp OUTPUT
SELECT @resp
GO
SELECT * FROM TipoRecurso;
GO
DROP PROCEDURE pr_recurso;
GO
CREATE PROCEDURE pr_recurso(
	@rec_nomb NVARCHAR(45),
	@rec_desc NVARCHAR(45),
	@rec_inst NVARCHAR(45),
	@rec_resp NVARCHAR(45),
	@rec_link NVARCHAR(45),
	@rec_img NVARCHAR(45),
	@tiprec_id_fk INT,
	@pub_id_fk INT,
	@resp INT OUTPUT
)
AS
	IF NOT EXISTS(SELECT * FROM dbo.Recurso WHERE rec_nomb = @rec_nomb)
		BEGIN
			INSERT INTO Recurso(rec_nomb,rec_desc,rec_inst,rec_resp,rec_link,rec_img,tiprec_id_fk,pub_id_fk)
			VALUES(@rec_nomb,@rec_desc,@rec_inst,@rec_resp,@rec_link,@rec_img,@tiprec_id_fk,@pub_id_fk);
			SET @resp = 1;
		END
	ELSE
		SET @resp = 0;
GO
DECLARE @resp INT
EXEC pr_recurso 'Prueba Nomyyydbre','Prueba descripcion','Prueba institution','Prueba responsable','Prueba Link','Prueba Imagen',1,1, @resp OUTPUT
SELECT @resp
GO
SELECT * FROM Recurso;
GO
/*************************************************************************** Lista de Documento Tecnico */
IF OBJECT_ID('pr_lista_recursodocumento') IS NOT NULL DROP PROCEDURE pr_lista_recursodocumento
GO
CREATE PROCEDURE pr_lista_recursodocumento
AS
	BEGIN
		SELECT * 
		FROM Recurso
		WHERE tiprec_id_fk = 1
	END
GO
EXEC pr_lista_recursodocumento
/*************************************************************************** Lista de Video Tutoriales */
IF OBJECT_ID('pr_lista_recursovideotutorial') IS NOT NULL DROP PROCEDURE pr_lista_recursovideotutorial
GO
CREATE PROCEDURE pr_lista_recursovideotutorial
AS
	BEGIN
		SELECT * 
		FROM Recurso
		WHERE tiprec_id_fk = 2
	END
GO
EXEC pr_lista_recursovideotutorial
/*************************************************************************************************************************** PR_CONTACTO **/
DROP PROCEDURE pr_contacto;
GO
CREATE PROCEDURE pr_contacto(
	@cont_nomb NVARCHAR(45),
	@cont_tel NVARCHAR(45),
	@cont_corr NVARCHAR(45),
	@cont_sms NVARCHAR(150)
)
AS
	BEGIN
		INSERT INTO dbo.Contacto(cont_nomb,cont_tel,cont_corr,cont_sms)
		VALUES(@cont_nomb,@cont_tel,@cont_corr,@cont_sms)
	END
GO
EXEC pr_contacto 'Daniel','999130638','hramos@gmail.com','Hola mundo como estas'
GO
SELECT * FROM Contacto;
/*************************************************************************************************************************** PR_TIPOCATALOGOWEB **/

GO
DROP PROCEDURE pr_tipocatalogoweb
GO
CREATE PROCEDURE pr_tipocatalogoweb(
	@tipcat_nomb NVARCHAR(45),
	@tipcat_desc NVARCHAR(10)
)
AS
	BEGIN
		INSERT INTO dbo.TipoCatalogoWeb(tipcat_nomb,tipcat_desc)
		VALUES(@tipcat_nomb,@tipcat_desc) 
	END
GO
EXEC pr_tipocatalogoweb 'Servicio de PRUEBA','Es un servicio de PRUEBA'		
GO
SELECT * FROM TipoCatalogoWeb;
/*************************************************************************************************************************** PR_CATALOGOWEB **/
GO
DROP PROCEDURE pr_catalogoweb
GO
CREATE PROCEDURE pr_catalogoweb(
	@cat_nomb NVARCHAR(45),
	@cat_desc NVARCHAR(60),
	@cat_inst NVARCHAR(45), 
	@cat_link NVARCHAR(45),
	@escal_id_fk INT, 
	@tipcat_id_fk INT,
	@pub_id_fk INT
)
AS
	BEGIN
		INSERT INTO dbo.CatalogoWeb(cat_nomb,cat_desc,cat_inst,cat_link,escal_id_fk,tipcat_id_fk,pub_id_fk)
		VALUES(@cat_nomb,@cat_desc,@cat_inst,@cat_link,@escal_id_fk,@tipcat_id_fk,@pub_id_fk)
	END
GO
EXEC pr_catalogoweb 'Nombre Prueba','Es una descripcion simple','IGN','WWW.GOOGLE.COM',1,1,1
GO
SELECT * FROM CatalogoWeb


/*********************************************************************************************************************************************************************** SERVICIO DE COBERTURA */
GO
IF OBJECT_ID('pr_lista_serviciocobertura') IS NOT NULL
DROP PROCEDURE pr_lista_serviciocobertura
GO
CREATE PROCEDURE pr_lista_serviciocobertura
AS
	BEGIN
		SELECT cat_id, cat_nomb, cat_desc, ISNULL(cat_esca,'') AS cat_esca, cat_inst, cat_link
		FROM CatalogoWeb
		WHERE tipcat_id_fk = 1
	END
GO
EXEC pr_lista_serviciocobertura
/*********************************************************************************************************************************************************************** SERVICIO DE DESCARGA */
GO
IF OBJECT_ID('pr_lista_serviciodescarga') IS NOT NULL
DROP PROCEDURE pr_lista_serviciodescarga
GO
CREATE PROCEDURE pr_lista_serviciodescarga
AS
	BEGIN
		SELECT cat_id, cat_nomb, cat_desc, ISNULL(cat_esca,'') AS cat_esca, cat_inst, cat_link
		FROM CatalogoWeb
		WHERE tipcat_id_fk = 2
	END
GO
EXEC pr_lista_serviciodescarga
/*********************************************************************************************************************************************************************** SERVICIO DE VISUALIZACION */
GO
IF OBJECT_ID('pr_lista_serviciovisualizacion') IS NOT NULL DROP PROCEDURE pr_lista_serviciovisualizacion
GO
CREATE PROCEDURE pr_lista_serviciovisualizacion
AS
	BEGIN
		SELECT cat_id, cat_nomb, cat_desc, ISNULL(cat_esca,'') AS cat_esca, cat_inst, cat_link
		FROM CatalogoWeb
		WHERE tipcat_id_fk = 3
	END
GO
EXEC pr_lista_serviciovisualizacion
GO
/************************************************************************************************** Norma Estandar Insertar, lista */
SELECT * FROM dbo.OrganismoNormador;
GO
IF OBJECT_ID('pr_insertar_organismonormador') IS NOT NULL DROP PROCEDURE pr_insertar_organismonormador
GO
CREATE PROCEDURE pr_insertar_organismonormador
	@org_abrev NVARCHAR(11),
	@org_nomb NVARCHAR(45),
	@org_link NVARCHAR(45),
	@org_origen INT,
	@organismonormador_id INT OUTPUT
AS
	IF NOT EXISTS(SELECT * FROM OrganismoNormador WHERE org_nomb = @org_nomb)
	BEGIN
		INSERT INTO OrganismoNormador(org_abrev,org_nomb,org_link,org_origen) 
		VALUES (@org_abrev, @org_nomb, @org_link, @org_origen)
		SET @organismonormador_id = SCOPE_IDENTITY();
	END
	ELSE
		SET @organismonormador_id = 0;
GO
IF OBJECT_ID('pr_lista_organismonormador') IS NOT NULL DROP PROCEDURE pr_lista_organismonormador
GO
CREATE PROCEDURE pr_lista_organismonormador
AS
	BEGIN
		SELECT org_id, org_abrev, org_nomb, org_link, org_origen 
		FROM OrganismoNormador
	END
GO
EXEC pr_lista_organismonormador
GO
IF OBJECT_ID('pr_lista_normaestandar') IS NOT NULL DROP PROCEDURE pr_lista_normaestandar
GO
CREATE PROCEDURE pr_lista_normaestandar
AS
	BEGIN
		SELECT nor_id, nor_nomb, nor_desc, nor_resp,tipnor_id_fk,org_id_fk,pub_id_fk
		FROM NormaEstandar
	END
GO
EXEC pr_lista_normaestandar
GO


USE bd_validar
GO
CREATE TABLE Usuario(
	usu_id int IDENTITY(1,1),
	usu_nomb nvarchar(45),
	usu_ape nvarchar(45),
	usu_ali nvarchar(20) UNIQUE,
	usu_rol int NOT NULL,
	usu_act int DEFAULT 0,
	usu_fact date,
	usu_fedi date,
	usu_freg datetime DEFAULT (GETDATE()),
	PRIMARY KEY(usu_id)
)
GO
IF OBJECT_ID('NoticiaImagen') IS NOT NULL
DROP TABLE NoticiaImagen
GO
CREATE TABLE NoticiaImagen(
	notimg_id int IDENTITY(1,1),
	notimg_img nvarchar(50),
	notimg_fact date,
	notimg_fedi date,
	notimg_freg datetime DEFAULT (GETDATE()),
	PRIMARY KEY(notimg_id)
)
GO
IF OBJECT_ID('Noticia') IS NOT NULL
DROP TABLE Noticia
GO
CREATE TABLE Noticia(
	not_id int IDENTITY(1,1),
	not_nomb nvarchar(50),
	not_desc nvarchar(100),
	not_fact date,
	not_fedi date,
	not_freg datetime DEFAULT (GETDATE()),
	pub_id_fk int,
	notimg_id_fk int, 
	PRIMARY KEY(not_id)
)
GO
IF OBJECT_ID('TipoRecurso') IS NOT NULL
DROP TABLE TipoRecurso
GO
CREATE TABLE TipoRecurso(
	tiprec_id int IDENTITY(1,1),
	tiprec_nomb nvarchar(20),
	tiprec_fact date,
	tiprec_fedi date,
	tiprec_freg datetime DEFAULT (GETDATE()),
	PRIMARY KEY(tiprec_id)
)
GO
IF OBJECT_ID('Recurso') IS NOT NULL
DROP TABLE Recurso
GO
CREATE TABLE Recurso(
	rec_id int IDENTITY(1,1),
	rec_nomb nvarchar(45) UNIQUE,
	rec_desc nvarchar(45),
	rec_inst nvarchar(45),
	rec_resp nvarchar(45),
	rec_link nvarchar(45),
	rec_img nvarchar(45),
	rec_fact date,
	rec_fedi date,
	rec_freg datetime DEFAULT (GETDATE()),
	tiprec_id_fk int,
	pub_id_fk int,
	PRIMARY KEY(rec_id)
)
GO
IF OBJECT_ID('Escala') IS NOT NULL
DROP TABLE Escala
GO
CREATE TABLE Escala(
	escal_id int IDENTITY(1,1),
	escal_escala nvarchar(20),
	escal_fact date,
	escal_fedi date,
	escal_freg datetime DEFAULT (GETDATE()),
	PRIMARY KEY(escal_id)
)
GO
IF OBJECT_ID('TipoCatalogoWeb') IS NOT NULL
DROP TABLE TipoCatalogoWeb
GO
CREATE TABLE TipoCatalogoWeb(
	tipcat_id int IDENTITY(1,1),
	tipcat_nomb nvarchar(45),
	tipcat_desc nvarchar(10),
	tipcat_fact date,
	tipcat_fedi date,
	tipcat_freg datetime DEFAULT (GETDATE()),
	PRIMARY KEY(tipcat_id)
)
GO
IF OBJECT_ID('CatalogoWeb') IS NOT NULL
DROP TABLE CatalogoWeb
GO
CREATE TABLE CatalogoWeb(
	cat_id int IDENTITY(1,1),
	cat_nomb nvarchar(45),
	cat_desc nvarchar(60),
	cat_esca int,
	cat_inst nvarchar(45),
	cat_link nvarchar(200),
	cat_fact date,
	cat_fedi date,
	cat_freg datetime DEFAULT (GETDATE()),
	tipcat_id_fk int,
	pub_id_fk int,
	escal_id_fk int,
	PRIMARY KEY(cat_id)
)
GO
IF OBJECT_ID('TipoNormaEstandar') IS NOT NULL
DROP TABLE TipoNormaEstandar
GO
CREATE TABLE TipoNormaEstandar(
	tipnor_id int IDENTITY(1,1),
	tipnor_nomb nvarchar(45),
	tipnor_fact date,
	tipnor_fedi date,
	tipnor_freg datetime DEFAULT (GETDATE()),
	PRIMARY KEY(tipnor_id)
)
GO
IF OBJECT_ID('OrganismoNormador') IS NOT NULL
DROP TABLE OrganismoNormador
GO
CREATE TABLE OrganismoNormador(
	org_id int IDENTITY(1,1),
	org_abrev nvarchar(20),
	org_nomb nvarchar(200),
	org_link nvarchar(200),
	org_origen int DEFAULT 0,
	org_fact date,
	org_fedi date,
	org_freg datetime DEFAULT (GETDATE()),
	PRIMARY KEY(org_id)
)
GO
IF OBJECT_ID('NormaEstandar') IS NOT NULL
DROP TABLE NormaEstandar
GO
CREATE TABLE NormaEstandar(
	nor_id int IDENTITY(1,1),
	nor_nomb nvarchar(45),
	nor_desc nvarchar(45),
	nor_resp nvarchar(45),
	nor_fact date,
	nor_fedi date,
	nor_freg datetime DEFAULT (GETDATE()),
	tipnor_id_fk int,
	org_id_fk int,
	pub_id_fk int,
	PRIMARY KEY(nor_id)
)
GO
IF OBJECT_ID('Contactar') IS NOT NULL
DROP TABLE Contactar
GO
CREATE TABLE Contactar(
	cont_id int IDENTITY(1,1),
	cont_nomb nvarchar(45),
	cont_tel nvarchar(45),
	cont_corr nvarchar(45),
	cont_sms nvarchar(150),
	cont_fact date,
	cont_fedi date,
	cont_freg datetime DEFAULT (GETDATE()),
	PRIMARY KEY(cont_id)
)
GO
IF OBJECT_ID('Publicacion') IS NOT NULL
DROP TABLE Publicacion
GO
CREATE TABLE Publicacion(
	pub_id int IDENTITY(1,1),
	pub_edi int DEFAULT YEAR(GETDATE()),
	pub_fact date,
	pub_fedi date,
	pub_freg datetime DEFAULT (GETDATE()),
	usu_id_fk int,
	PRIMARY KEY(pub_id)
)
GO
ALTER TABLE Recurso
ADD CONSTRAINT FK_Recurso_TipoRecurso
FOREIGN KEY (tiprec_id_fk) 
REFERENCES TipoRecurso(tiprec_id)
GO
ALTER TABLE Recurso
ADD CONSTRAINT FK_Recurso_Publicacion
FOREIGN KEY (pub_id_fk) 
REFERENCES Publicacion(pub_id)
GO
ALTER TABLE CatalogoWeb
ADD CONSTRAINT FK_CatalogoWeb_TipoCatalogoWeb
FOREIGN KEY (tipcat_id_fk)
REFERENCES TipoCatalogoWeb(tipcat_id)
GO
ALTER TABLE CatalogoWeb
ADD CONSTRAINT FK_CatalogoWeb_Escala
FOREIGN KEY (escal_id_fk)
REFERENCES Escala(escal_id)
GO
ALTER TABLE CatalogoWeb
ADD CONSTRAINT FK_CatalogoWeb_Publicacion
FOREIGN KEY (pub_id_fk)
REFERENCES Publicacion(pub_id)
GO
ALTER TABLE NormaEstandar
ADD CONSTRAINT FK_NormaEstandar_TipoNormaEstandar
FOREIGN KEY (tipnor_id_fk)
REFERENCES TipoNormaEstandar(tipnor_id)
GO
ALTER TABLE NormaEstandar
ADD CONSTRAINT FK_NormaEstandar_Publicacion
FOREIGN KEY (pub_id_fk)
REFERENCES Publicacion(pub_id)
GO
ALTER TABLE NormaEstandar
ADD CONSTRAINT FK_NormaEstandar_OrganismoNormador
FOREIGN KEY (org_id_fk)
REFERENCES OrganismoNormador(org_id)
GO
ALTER TABLE Noticia
ADD CONSTRAINT FK_Noticia_NoticiaImagen
FOREIGN KEY (notimg_id_fk)
REFERENCES NoticiaImagen(notimg_id)
GO
ALTER TABLE Noticia
ADD CONSTRAINT FK_Noticia_Publicacion
FOREIGN KEY (pub_id_fk)
REFERENCES Publicacion(pub_id)
GO



ALTER TABLE Publicacion
ADD CONSTRAINT FK_Publicacion_Usuario
FOREIGN KEY (usu_id_fk)
REFERENCES Usuario(usu_id)
GO






CREATE PROCEDURE pr_lista_escala
AS
	BEGIN
		SELECT escal_id, escal_escala
		FROM Escala
	END
GO
EXEC pr_lista_escala

/* LISTA DE TIPO DE CATALOGO WEB */
INSERT INTO TipoCatalogoWeb(tipcat_nomb,tipcat_desc)
	VALUES('Catalogo','Decripcion')
GO
SELECT * FROM TipoCatalogoWeb;
GO
CREATE PROCEDURE pr_lista_tipocatalogoweb
AS
	BEGIN
		SELECT * 
		FROM TipoCatalogoWeb
	END
GO

/* LISTA DE TIPO NORMA ESTANDAR */
INSERT INTO TipoNormaEstandar(tipnor_nomb)
	VALUES('Catalogo'),('Catalogo');
GO
SELECT * FROM TipoNormaEstandar;
GO
CREATE PROCEDURE pr_lista_tiponormaestandar
AS
	BEGIN
		SELECT * 
		FROM TipoNormaEstandar
	END
GO

/* LISTA DE TIPO RECURSO */
INSERT INTO TipoRecurso(tiprec_nomb)
	VALUES('Catalogo'),('Catalogo');
GO
SELECT * FROM TipoRecurso;
GO
CREATE PROCEDURE pr_lista_tiporecurso
AS
	BEGIN
		SELECT * 
		FROM TipoRecurso
	END
GO

SELECT * FROM curso

/****************************************************************************************************************/

curso

CREATE PROCEDURE pr_detalle_curso
@V_ID int 
AS
BEGIN
	SELECT * FROM curso WHERE codigo_c = @V_ID
END

EXEC pr_detalle_curso '2'