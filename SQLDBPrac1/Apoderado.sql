CREATE TABLE [dbo].[Apoderado]
(
	[Id] INT NOT NULL PRIMARY KEY, 
    [Nombre] NVARCHAR(50) NOT NULL, 
    [Telefono] NVARCHAR(50) NOT NULL, 
    [Id_Alumno] INT NOT NULL, 
    CONSTRAINT [FK_Apoderado_Alumno] FOREIGN KEY ([Id_Alumno]) REFERENCES [Alumno]([Id])
)
