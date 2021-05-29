CREATE DATABASE UNIVERSIDADE
GO

USE UNIVERSIDADE
GO

CREATE TABLE Universidade (
	IdUniversidade INT IDENTITY NOT NULL,
	Universidade VARCHAR(150) NOT NULL,
	Status BIT
)
GO

ALTER TABLE Universidade
ADD PRIMARY KEY (IdUniversidade)
GO

CREATE TABLE Predio(
	IdPredio INT IDENTITY(1,1) NOT NULL,
	Predio VARCHAR(150) NOT NULL,
	Cidade VARCHAR(150) NOT NULL,
	Uf CHAR(2) NOT NULL,
	Regiao VARCHAR(75) NOT NULL,
	Zona CHAR(5) NULL,
	IdUniversidade INT NOT NULL,
	Status BIT
) 
GO


ALTER TABLE Predio
ADD PRIMARY KEY (IdPredio)
GO

ALTER TABLE Predio
ADD FOREIGN KEY (IdUniversidade) REFERENCES Universidade(IdUniversidade)
GO

CREATE TABLE Sala(
	IdSala INT IDENTITY(1,1) NOT NULL,
	Sala VARCHAR(150) NOT NULL,
	IdPredio INT NOT NULL,
	NumeroSala INT NOT NULL,
	Capacidade INT NOT NULL,
	Status BIT
) 
GO

ALTER TABLE Sala
ADD PRIMARY KEY (IdSala)
GO

ALTER TABLE Sala
ADD FOREIGN KEY (IdPredio) REFERENCES Predio (IdPredio)
GO

CREATE TABLE Departamento(
	IdDepartamento INT IDENTITY(1,1) NOT NULL,
	Departamento VARCHAR(150) NOT NULL,
	Sigla CHAR(5) NOT NULL,
	Orcamento NUMERIC(12,2) CHECK (Orcamento > 0 AND Orcamento < 1000000),
	IdPredio INT NOT NULL,
	Status BIT 
) 
GO

ALTER TABLE Departamento
ADD PRIMARY KEY (IdDepartamento)
GO

ALTER TABLE Departamento
ADD FOREIGN KEY (IdPredio) REFERENCES Predio (IdPredio)
GO

CREATE TABLE Funcionario (
	IdFuncionario INT IDENTITY(1,1) NOT NULL,
	Funcionario VARCHAR(150) NOT NULL,
	IdDepartamento INT NOT NULL,
	IdUniversidade INT NOT NULL,
	Status BIT NOT NULL,
	Diretor BIT
)

ALTER TABLE Funcionario 
ADD PRIMARY KEY (IdFuncionario)
GO

ALTER TABLE Funcionario
ADD FOREIGN KEY (IdDepartamento) REFERENCES Departamento(IdDepartamento)
GO

ALTER TABLE Funcionario
ADD FOREIGN KEY (IdUniversidade) REFERENCES Universidade(IdUniversidade)
GO



CREATE TABLE Curso(
	IdCurso INT IDENTITY(1,1) NOT NULL,
	Curso VARCHAR(150) NOT NULL,
	IdDepartamento INT NOT NULL,
	Nota NUMERIC(1,0) CHECK (Nota > 0 AND Nota < 6) NOT NULL,
	Staus BIT
)
GO

ALTER TABLE Curso
ADD PRIMARY KEY (IdCurso)
GO

ALTER TABLE Curso
ADD FOREIGN KEY (IdDepartamento) REFERENCES Departamento(IdDepartamento)
GO

CREATE TABLE Professor(
	IdProfessor INT IDENTITY(1,1) NOT NULL,
	IdFuncionario INT NOT NULL,
	IdDepartamento INT NULL,
	Salario NUMERIC(8,2) CHECK (Salario < 29999 AND Salario < 100001) NOT NULL, 
	Status BIT
)
GO

ALTER TABLE Professor
ADD PRIMARY KEY (IdProfessor)
GO

ALTER TABLE Professor 
ADD FOREIGN KEY(IdDepartamento) REFERENCES Departamento(IdDepartamento)
GO

ALTER TABLE Professor 
ADD FOREIGN KEY(IdFuncionario) REFERENCES Funcionario(IdFuncionario)
GO

CREATE TABLE Semestre (
	IdSemestre INT IDENTITY(1,1) NOT NULL,
	Semestre INT CHECK (Semestre > 0 AND Semestre < 13) NOT NULL,
	IdCurso INT NOT NULL,
	Ano INT NOT NULL,
	IdPredio INT NOT NULL,
	IdSala INT NOT NULL,
	Periodo INT NOT NULL,
	Status BIT
)
GO

ALTER TABLE Semestre
ADD PRIMARY KEY (IdSemestre)
GO

ALTER TABLE Semestre
ADD FOREIGN KEY(IdCurso) REFERENCES Curso(IdCurso)
GO

ALTER TABLE Semestre
ADD FOREIGN KEY(IdPredio) REFERENCES Predio(IdPredio)
GO

ALTER TABLE Semestre
ADD FOREIGN KEY(IdSala) REFERENCES Sala(IdSala)
GO

CREATE TABLE Ministra (
	IdProfessor INT NOT NULL,
	IdCurso INT NOT NULL,
	IdSemestre INT NOT NULL,
	Status BIT
)
GO

ALTER TABLE Ministra
ADD PRIMARY KEY (IdProfessor)
GO

ALTER TABLE Ministra
ADD FOREIGN KEY(IdProfessor) REFERENCES Professor(IdProfessor)
GO

ALTER TABLE Ministra
ADD FOREIGN KEY(IdCurso) REFERENCES Curso(IdCurso) ON DELETE CASCADE
GO

ALTER TABLE Ministra
ADD FOREIGN KEY(IdSemestre) REFERENCES Semestre(IdSemestre) ON DELETE CASCADE
GO

CREATE TABLE Aluno (
	IdAluno INT IDENTITY(1,1) NOT NULL,
	Nome VARCHAR(150) NOT NULL,
	IdDepartamento INT NOT NULL,
	Credito NUMERIC(3,0) CHECK (Credito >= 0) NOT NULL,
	Status BIT
)
GO

ALTER TABLE Aluno
ADD PRIMARY KEY (IdAluno)
GO

ALTER TABLE Aluno
ADD FOREIGN KEY(IdDepartamento) REFERENCES Departamento(IdDepartamento)
GO

CREATE TABLE Realiza (
	IdAluno INT NOT NULL,
	IdCurso INT NOT NULL,
	IdSemestre INT NOT NULL,
	Nota INT CHECK (Nota >= 0 AND Nota <= 10) NOT NULL,
	Status BIT
)
GO

ALTER TABLE Realiza
ADD PRIMARY KEY (IdAluno)
GO

ALTER TABLE Realiza
ADD FOREIGN KEY (IdAluno) REFERENCES Aluno(IdAluno) ON DELETE CASCADE
GO

ALTER TABLE Realiza
ADD FOREIGN KEY (IdCurso) REFERENCES Curso(IdCurso) ON DELETE CASCADE
GO

ALTER TABLE Realiza
ADD FOREIGN KEY (IdSemestre) REFERENCES Semestre(IdSemestre) ON DELETE CASCADE
GO

CREATE TABLE Mentor (
	IdProfessor INT NOT NULL,
	IdAluno INT NOT NULL
)
GO

ALTER TABLE Mentor
ADD PRIMARY KEY (IdProfessor)
GO

ALTER TABLE Mentor
ADD FOREIGN KEY (IdProfessor) REFERENCES Professor(IdProfessor)
GO

ALTER TABLE Mentor
ADD FOREIGN KEY (IdAluno) REFERENCES Aluno(IdAluno) ON DELETE CASCADE
GO

----------------------------------------------------------
---------------- B I B L I O T E C A ---------------------
----------------------------------------------------------
CREATE TABLE Biblioteca(
	IdBiblioteca INT IDENTITY(1,1) NOT NULL,
	Biblioteca VARCHAR(150) NOT NULL,
	IdUniversidade INT NOT NULL,
	IdPredio INT NOT NULL,
	IdFuncionario INT NOT NULL,
	Status BIT
)
GO

ALTER TABLE Biblioteca
ADD PRIMARY KEY (IdBiblioteca)
GO

ALTER TABLE Biblioteca
ADD FOREIGN KEY (IdUniversidade) REFERENCES Universidade(IdUniversidade)
GO

ALTER TABLE Biblioteca
ADD FOREIGN KEY (IdPredio) REFERENCES Predio(IdPredio)
GO

ALTER TABLE Biblioteca
ADD FOREIGN KEY (IdFuncionario) REFERENCES Funcionario(IdFuncionario)
GO

CREATE TABLE Autor(
	IdAutor INT IDENTITY(1,1) NOT NULL,
	Autor VARCHAR(150) NOT NULL
)

ALTER TABLE Autor
ADD PRIMARY KEY (IdAutor)
GO

CREATE TABLE Editora (
	IdEditora INT IDENTITY(1,1) NOT NULL,
	Editora VARCHAR(150) NOT NULL
)
GO

ALTER TABLE Editora
ADD PRIMARY KEY (IdEditora)
GO

CREATE TABLE Categoria (
	IdCategoria INT IDENTITY(1,1) NOT NULL,
	Categoria VARCHAR(150) NOT NULL
)
GO

ALTER TABLE Categoria
ADD PRIMARY KEY (IdCategoria)
GO

CREATE TABLE Livro (
	CodigoBarra VARCHAR(100) NOT NULL,
	Livro VARCHAR(150) NOT NULL,
	AnoLancamento CHAR(4) NOT NULL,
	IdAutor INT NOT NULL,
	IdEditora INT NOT NULL,
	IdCategoria INT NOT NULL,
	IdBiblioteca INT NOT NULL,
	QtdeExemplares INT CHECK (QtdeExemplares >=0) NOT NULL,
	Status BIT
)
ALTER TABLE Livro
ADD PRIMARY KEY (CodigoBarra)
GO

ALTER TABLE Livro
ADD FOREIGN KEY (IdBiblioteca) REFERENCES Biblioteca(IdBiblioteca)
GO

ALTER TABLE Livro
ADD FOREIGN KEY (IdCategoria) REFERENCES Categoria(IdCategoria)
GO

ALTER TABLE Livro
ADD FOREIGN KEY (IdEditora) REFERENCES Editora(IdEditora)
GO

ALTER TABLE Livro
ADD FOREIGN KEY (IdAutor) REFERENCES Autor(IdAutor)
GO

CREATE TABLE Reserva (
	IdReserva INT IDENTITY(1,1) NOT NULL,
	IdLivro VARCHAR(100) NOT NULL,
	IdAluno INT NOT NULL,
	DataReserva DATETIME NOT NULL,
	DataEmprestimo DATE NOT NULL,
	Status BIT
)

ALTER TABLE Reserva
ADD PRIMARY KEY (IdReserva)
GO

ALTER TABLE Reserva
ADD FOREIGN KEY (IdLivro) REFERENCES Livro(CodigoBarra)
GO

ALTER TABLE Reserva
ADD FOREIGN KEY (IdAluno) REFERENCES Aluno(IdAluno)
GO

CREATE TABLE Emprestimo (
	IdEmprestimo INT IDENTITY(1,1) NOT NULL,
	IdLivro VARCHAR(100) NOT NULL,
	IdAluno INT NOT NULL,
	DataRetirada DATETIME NOT NULL,
	IdBibliotecaRetirada INT NOT NULL,
	DataDevolucao DATE NOT NULL,
	IdBibliotecaDevolucao INT NOT NULL,
	Reserva BIT
)
GO

ALTER TABLE Emprestimo
ADD PRIMARY KEY (IdEmprestimo)
GO

ALTER TABLE Emprestimo
ADD FOREIGN KEY (IdLivro) REFERENCES Livro(CodigoBarra)
GO

ALTER TABLE Emprestimo
ADD FOREIGN KEY (IdAluno) REFERENCES Aluno(IdAluno)
GO

ALTER TABLE Emprestimo
ADD FOREIGN KEY (IdBibliotecaRetirada) REFERENCES Biblioteca(IdBiblioteca)
GO

ALTER TABLE Emprestimo
ADD FOREIGN KEY (IdBibliotecaDevolucao) REFERENCES Biblioteca(IdBiblioteca)
GO

CREATE TABLE EmprestimoReserva (
	IdEmprestimoReserva INT IDENTITY(1,1) NOT NULL,
	IdReserva INT NOT NULL,
	IdEmprestimo INT NOT NULL,
	Status BIT
)
ALTER TABLE EmprestimoReserva
ADD PRIMARY KEY (IdEmprestimo)
GO

ALTER TABLE EmprestimoReserva
ADD FOREIGN KEY (IdReserva) REFERENCES Reserva(IdReserva) ON DELETE CASCADE
GO

ALTER TABLE EmprestimoReserva
ADD FOREIGN KEY (IdEmprestimo) REFERENCES Emprestimo(IdEmprestimo) ON DELETE CASCADE
GO

----------------------------------------------------------
---------------- F I N A N C E I R O ---------------------
----------------------------------------------------------


-----------------E M   B R E V E -------------------------