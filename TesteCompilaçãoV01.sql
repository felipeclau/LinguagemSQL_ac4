Coloque seu C�DIGO SQL abaixo:

--Faculdade Impacta de Tecnologia

--Projeto LMS (Learning Management System)

--Curso: Banco de Dados

--Disciplina: Linguagem SQL


CREATE DATABASE ProjetoLMSVTESTE;

GO





USE ProjetoLMSVTESTE;





CREATE TABLE Usuario

(

	ID INT NOT NULL IDENTITY (1,1),

	[Login] VARCHAR (50) NOT NULL,

	Senha VARCHAR (50) NOT NULL,

	DtExpedi��o DATE NOT NULL CONSTRAINT DF_DataExpedi��o DEFAULT '01/01/1900',

	CONSTRAINT Pk_Usuario PRIMARY KEY (ID),

	CONSTRAINT UQ_LoginUsuario UNIQUE([Login]),

);

GO





CREATE TABLE Coordenador



(

	ID INT NOT NULL IDENTITY (1,1),

	Nome VARCHAR (50) NOT NULL,

	ID_Usuario INT NOT NULL,

	Email VARCHAR (50) NOT NULL,

	Celular TINYINT,

	CONSTRAINT Pk_Coordenador PRIMARY KEY (ID),

	CONSTRAINT UQ_EmailCoordenador UNIQUE(Email),

	CONSTRAINT UQ_CelularCoordenador UNIQUE(Celular),

	CONSTRAINT Ck_CelularCoordenador CHECK ( Celular LIKE '[0-9][0-9][0-9]) [0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),

	CONSTRAINT fk_CoordenadorUsuario

			FOREIGN KEY (ID_USUARIO)

			REFERENCES Usuario (ID)

);

GO



CREATE TABLE Aluno



(

	ID INT NOT NULL IDENTITY (1,1),

	Nome VARCHAR (50) NOT NULL,

	ID_Usuario INT NOT NULL,

	Email VARCHAR (50) NOT NULL,

	Celular TINYINT,

	RA TINYINT NOT NULL,

	Foto VARCHAR (50) NULL,

	CONSTRAINT Pk_Aluno PRIMARY KEY (ID),

	CONSTRAINT UQ_EmailAluno UNIQUE(Email),

	CONSTRAINT UQ_CelularAluno UNIQUE(Celular),

	CONSTRAINT Ck_CelularAluno CHECK ( Celular LIKE '[0-9][0-9][0-9]) [0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),

	CONSTRAINT fk_AlunoUsuario

			FOREIGN KEY (ID_USUARIO)

			REFERENCES Usuario (ID)

);

GO



CREATE TABLE Professor

(

	ID INT NOT NULL IDENTITY(1,1),

	Id_usuario INT NOT NULL,

	Email VARCHAR(100),

	Celular TINYINT,

	Apelido VARCHAR(50)

	CONSTRAINT PK_Professor PRIMARY KEY (ID),

	CONSTRAINT FK_IDId_usuarioProfessor

	FOREIGN KEY (Id_usuario)

	REFERENCES Usuario(ID),

	CONSTRAINT UQ_EmailProfessor UNIQUE(Email),

	CONSTRAINT UQ_CelularProfessor UNIQUE(Celular)

);

GO



CREATE TABLE Disciplina

(

	ID INT NOT NULL IDENTITY(1,1),

	Nome VARCHAR(100) NOT NULL,

	[Data] DATE NOT NULL CONSTRAINT DF_DataDisciplina DEFAULT(GETDATE()),

	[Status] VARCHAR(7) NOT NULL CONSTRAINT DF_StatusDisciplina DEFAULT 'Aberta',

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

	CONSTRAINT FK_IDCoordenadorDisciplina

	FOREIGN KEY (IdCoordenador)

	REFERENCES Coordenador(ID),

	CONSTRAINT UQ_NomeDisciplina UNIQUE(Nome),

	CONSTRAINT CK_StatusDisciplina CHECK([Status] IN('Aberta','Fechada')),

	CONSTRAINT CK_PercentualPraticoDisciplina CHECK(PercentualPratico >= 0 AND PercentualPratico <= 100),

	CONSTRAINT CK_PercentualTeoricoDisciplina CHECK(PercentualTeorico >= 0 AND PercentualTeorico <= 100)

);

GO



CREATE TABLE Curso

(

    	ID INT NOT NULL IDENTITY(1,1),

   	NomeCurso VARCHAR(30) NOT NULL,

    	CONSTRAINT PK_IdCurso PRIMARY KEY (ID),

    	CONSTRAINT UQ_NomeCurso UNIQUE (NomeCurso)

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

	CONSTRAINT FK_IDCoordenadorDisciplinaOfertada

	FOREIGN KEY (IdCoordenador)

	REFERENCES Coordenador(ID),

	CONSTRAINT FK_IDDisciplinaDisciplinaOfertada

	FOREIGN KEY (IdDisciplina)

	REFERENCES Disciplina(ID),

	CONSTRAINT FK_IDCursoDisciplinaOfertada

	FOREIGN KEY (IdCurso)

	REFERENCES Curso(ID),

	CONSTRAINT PK_IDProfessorDisciplinaOfertada

	FOREIGN KEY (IdProfessor)

	REFERENCES Professor(ID),

	CONSTRAINT CK_AnoDisciplinaOfertada CHECK(Ano BETWEEN 1900 AND 2100),

	CONSTRAINT CK_SemestreDisciplinaOfertada CHECK(Semestre BETWEEN 1 AND 2),

	CONSTRAINT CK_TurmaDisciplinaOfertada CHECK(Turma LIKE '[A-Z]'),

	CONSTRAINT UQ_ValidaOfertaDisciplinaOfertada UNIQUE(idDisciplina, idCurso, Ano, Semestre, Turma)

);

GO



 

 CREATE TABLE SolicitacaoMatricula

 (

 	ID INT NOT NULL IDENTITY(1,1),

    	IdAluno INT NOT NULL,

    	IdDisciplinaOferdatada INT NOT NULL,

    	DtSolicitacao DATE NOT NULL CONSTRAINT DF_DtSolicitacao DEFAULT (GETDATE()),

    	--"IdCoordenador n�o � obrigat�rio de ser preenchido, por�m, quando o coordenador aprov�-la (ie: alterar o status da mesma), seu ID deve ser preenchido.-->

	IdCoordenador INT NULL,

    	Status VARCHAR(10) NOT NULL CONSTRAINT DF_Status DEFAULT ('Solicitada'),

    	CONSTRAINT CK_Status CHECK (Status IN ('Solicitada', 'Aprovada', 'Rejeitada', 'Cancelada')),

	-- Alterado FK_IdAluno para FK_IdAlunoSolicitacaoMatribula -- 

	CONSTRAINT FK_IdAlunoSolicitacaoMatricula FOREIGN KEY (IdAluno) REFERENCES Aluno (ID),

	CONSTRAINT FK_IdDisciplinaOfertada FOREIGN KEY (IdDisciplinaOferdatada) REFERENCES DisciplinaOfertada (ID),

 );

 GO

 

  CREATE TABLE Atividade

 (

    	ID INT NOT NULL IDENTITY(1,1),

    	Titulo VARCHAR(50) NOT NULL,

    	Descricao VARCHAR(3000) NOT NULL,

    	Conteudo VARCHAR(3000) NOT NULL,

    	Tipo VARCHAR(14) NOT NULL CONSTRAINT CK_Tipo CHECK (Tipo IN ('Resposta Aberta','Teste')),

    	Extras VARCHAR(30) NULL,

    	IdProfessor INT NOT NULL

	CONSTRAINT FK_IdProfessor FOREIGN KEY (IdProfessor) REFERENCES Professor (ID)

);

GO