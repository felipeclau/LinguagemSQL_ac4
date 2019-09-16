--Faculdade Impacta de Tecnologia
--Projeto LMS (Learning Management System)
--Curso: Banco de Dados
--Disciplina: Linguagem SQL

CREATE DATABASE ProjetoLMS;
GO


USE ProjetoLMS;

CREATE TABLE Professor
(
	ID INT NOT NULL IDENTITY(1,1),
	Id_usuario INT NOT NULL,
	Email VARCHAR(100),
	Celular TINYINT,
	Apelido VARCHAR(50)
	CONSTRAINT PK_Professor PRIMARY KEY (ID),
	CONSTRAINT UQ_EmailProfessor UNIQUE(Email),
	CONSTRAINT UQ_CelularProfessor UNIQUE(Celular)
);
GO

CREATE TABLE Disciplina
(
	ID INT NOT NULL IDENTITY(1,1),
	Nome VARCHAR(100) NOT NULL,
	Data DATE NOT NULL CONSTRAINT DF_DataDisciplina DEFAULT(GETDATE()),
	Status VARCHAR(7) NOT NULL CONSTRAINT DF_StatusDisciplina DEFAULT 'Aberta',
	PlanoDeEnsino VARCHAR(200) NOT NULL,
	CargaHoraria INT NOT NULL,
	Competencias VARCHAR(200) NOT NULL,
	Habilidades VARCHAR(200) NOT NULL,
	Ementa VARCHAR(5000) NOT NULL,
	ConteudoProgramatico VARCHAR(5000) NOT NULL,
	BibliograficaBasica VARCHAR(3000) NOT NULL,
	BibliograficaComplementar VARCHAR(3000) NOT NULL,
	PercentualPratico TINYINT NOT NULL,
	PercentualTeorico TINYINT NOT NULL,
	IdCoordenador INT NOT NULL
	CONSTRAINT PK_Disciplina PRIMARY KEY(ID),
	CONSTRAINT UQ_NomeDisciplina UNIQUE(Nome),
	CONSTRAINT CK_StatusDisciplina CHECK(Status IN('Aberta','Fechada')),
	CONSTRAINT CK_PercentualPraticoDisciplina CHECK(PercentualPratico >= 0 AND PercentualPratico <= 100),
	CONSTRAINT CK_PercentualTeoricoDisciplina CHECK(PercentualTeorico >= 0 AND PercentualTeorico <= 100)
);
GO

CREATE TABLE DisciplinaOfertada
(
	ID INT NOT NULL IDENTITY(1,1),
	IdCoordenador INT NOT NULL,
	DtInicioMatricula DATE NULL,
	DtFimMatricula DATE NULL,
	IdDisciplina INT NOT NULL,
	IdCurso INT NOT NULL,
	Ano SMALLINT NOT NULL,
	Semestre TINYINT NOT NULL,
	Turma CHAR(1) NOT NULL,
	IdProfessor INT NULL,
	Metodologia VARCHAR(3000) NULL,
	Recursos VARCHAR(3000) NULL,
	CriterioAvaliacao VARCHAR(3000) NULL,
	PlanoDeAulas VARCHAR(3000) NULL
	CONSTRAINT PK_DisciplinaOfertada PRIMARY KEY (ID),
	CONSTRAINT CK_AnoDisciplinaOfertada CHECK(Ano BETWEEN 1900 AND 2100),
	CONSTRAINT CK_SemestreDisciplinaOfertada CHECK(Semestre BETWEEN 1 AND 2),
	CONSTRAINT CK_TurmaDisciplinaOfertada CHECK(Turma LIKE '[A-Z]')
);
GO


