/*
Script de implementación para DBPrac1

Una herramienta generó este código.
Los cambios realizados en este archivo podrían generar un comportamiento incorrecto y se perderán si
se vuelve a generar el código.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "DBPrac1"
:setvar DefaultFilePrefix "DBPrac1"
:setvar DefaultDataPath "C:\Users\USER\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB\"
:setvar DefaultLogPath "C:\Users\USER\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB\"

GO
:on error exit
GO
/*
Detectar el modo SQLCMD y deshabilitar la ejecución del script si no se admite el modo SQLCMD.
Para volver a habilitar el script después de habilitar el modo SQLCMD, ejecute lo siguiente:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'El modo SQLCMD debe estar habilitado para ejecutar correctamente este script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
PRINT N'Quitando Clave externa [dbo].[FK_Apoderado_Alumno]...';


GO
ALTER TABLE [dbo].[Apoderado] DROP CONSTRAINT [FK_Apoderado_Alumno];


GO
PRINT N'Quitando Clave externa [dbo].[FK_Inscrito_Alumno]...';


GO
ALTER TABLE [dbo].[Inscrito] DROP CONSTRAINT [FK_Inscrito_Alumno];


GO
PRINT N'Quitando Clave externa [dbo].[FK_Inscrito_Curso]...';


GO
ALTER TABLE [dbo].[Inscrito] DROP CONSTRAINT [FK_Inscrito_Curso];


GO
PRINT N'Iniciando recompilación de la tabla [dbo].[Alumno]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Alumno] (
    [Id]     INT           NOT NULL,
    [Nombre] NVARCHAR (50) NOT NULL,
    [Ciudad] NVARCHAR (50) NOT NULL,
    [Edad]   INT           NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Alumno])
    BEGIN
        INSERT INTO [dbo].[tmp_ms_xx_Alumno] ([Id], [Nombre], [Ciudad], [Edad])
        SELECT   [Id],
                 [Nombre],
                 [Ciudad],
                 [Edad]
        FROM     [dbo].[Alumno]
        ORDER BY [Id] ASC;
    END

DROP TABLE [dbo].[Alumno];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Alumno]', N'Alumno';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Iniciando recompilación de la tabla [dbo].[Apoderado]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Apoderado] (
    [Id]        INT           NOT NULL,
    [Nombre]    NVARCHAR (50) NOT NULL,
    [Telefono]  NVARCHAR (50) NOT NULL,
    [Id_Alumno] INT           NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Apoderado])
    BEGIN
        INSERT INTO [dbo].[tmp_ms_xx_Apoderado] ([Id], [Nombre], [Telefono], [Id_Alumno])
        SELECT   [Id],
                 [Nombre],
                 [Telefono],
                 [Id_Alumno]
        FROM     [dbo].[Apoderado]
        ORDER BY [Id] ASC;
    END

DROP TABLE [dbo].[Apoderado];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Apoderado]', N'Apoderado';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Iniciando recompilación de la tabla [dbo].[Curso]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Curso] (
    [Cod]          INT           NOT NULL,
    [Nombre]       NVARCHAR (50) NOT NULL,
    [Fecha_inicio] NVARCHAR (50) NOT NULL,
    [Duracion]     INT           NOT NULL,
    [Valor]        INT           NOT NULL,
    PRIMARY KEY CLUSTERED ([Cod] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Curso])
    BEGIN
        INSERT INTO [dbo].[tmp_ms_xx_Curso] ([Cod], [Nombre], [Fecha_inicio], [Duracion], [Valor])
        SELECT   [Cod],
                 [Nombre],
                 [Fecha_inicio],
                 [Duracion],
                 [Valor]
        FROM     [dbo].[Curso]
        ORDER BY [Cod] ASC;
    END

DROP TABLE [dbo].[Curso];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Curso]', N'Curso';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Iniciando recompilación de la tabla [dbo].[Inscrito]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Inscrito] (
    [Id]        INT NOT NULL,
    [Id_Alumno] INT NOT NULL,
    [Cod_Curso] INT NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Inscrito])
    BEGIN
        INSERT INTO [dbo].[tmp_ms_xx_Inscrito] ([Id], [Id_Alumno], [Cod_Curso])
        SELECT   [Id],
                 [Id_Alumno],
                 [Cod_Curso]
        FROM     [dbo].[Inscrito]
        ORDER BY [Id] ASC;
    END

DROP TABLE [dbo].[Inscrito];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Inscrito]', N'Inscrito';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Creando Clave externa [dbo].[FK_Apoderado_Alumno]...';


GO
ALTER TABLE [dbo].[Apoderado] WITH NOCHECK
    ADD CONSTRAINT [FK_Apoderado_Alumno] FOREIGN KEY ([Id_Alumno]) REFERENCES [dbo].[Alumno] ([Id]);


GO
PRINT N'Creando Clave externa [dbo].[FK_Inscrito_Alumno]...';


GO
ALTER TABLE [dbo].[Inscrito] WITH NOCHECK
    ADD CONSTRAINT [FK_Inscrito_Alumno] FOREIGN KEY ([Id_Alumno]) REFERENCES [dbo].[Alumno] ([Id]);


GO
PRINT N'Creando Clave externa [dbo].[FK_Inscrito_Curso]...';


GO
ALTER TABLE [dbo].[Inscrito] WITH NOCHECK
    ADD CONSTRAINT [FK_Inscrito_Curso] FOREIGN KEY ([Cod_Curso]) REFERENCES [dbo].[Curso] ([Cod]);


GO
PRINT N'Comprobando los datos existentes con las restricciones recién creadas';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[Apoderado] WITH CHECK CHECK CONSTRAINT [FK_Apoderado_Alumno];

ALTER TABLE [dbo].[Inscrito] WITH CHECK CHECK CONSTRAINT [FK_Inscrito_Alumno];

ALTER TABLE [dbo].[Inscrito] WITH CHECK CHECK CONSTRAINT [FK_Inscrito_Curso];


GO
PRINT N'Actualización completada.';


GO
