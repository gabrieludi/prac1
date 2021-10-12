CREATE TABLE [dbo].[Inscrito]
(
	[Id] INT NOT NULL PRIMARY KEY, 
    [Id_Alumno] INT NOT NULL, 
    [Cod_Curso] INT NOT NULL, 
    CONSTRAINT [FK_Inscrito_Alumno] FOREIGN KEY ([Id_Alumno]) REFERENCES [Alumno]([Id]), 
    CONSTRAINT [FK_Inscrito_Curso] FOREIGN KEY ([Cod_Curso]) REFERENCES [Curso]([Cod])
)
