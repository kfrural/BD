CREATE DATABASE Epidemiologia;

USE Epidemiologia;

CREATE TABLE Pessoas (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(255) NOT NULL,
    CPF VARCHAR(11) UNIQUE NOT NULL,
    Sexo CHAR(1),
    Idade INT,
    Endereco VARCHAR(255),
    Telefone VARCHAR(15),
    Email VARCHAR(255)
);

CREATE TABLE Funcionarios (
    ID_Func INT AUTO_INCREMENT PRIMARY KEY,
    CPF VARCHAR(11) UNIQUE NOT NULL,
    RegiaoAtuacao VARCHAR(255),
    RelatorioDiario TEXT,
    FOREIGN KEY (CPF) REFERENCES Pessoas(CPF)
);

CREATE TABLE UnidadesSaude (
    ID_Unidade INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(255) NOT NULL,
    Tipo ENUM('hospital', 'clínica', 'posto de saúde'),
    Telefone VARCHAR(15),
    Localizacao VARCHAR(255)
);

CREATE TABLE Notificacoes (
    ID_Notificacao INT AUTO_INCREMENT PRIMARY KEY,
    DataHora DATETIME NOT NULL,
    Descricao TEXT,
    Tipo VARCHAR(255),
    ID_Unidade INT,
    ID_Pessoa INT,
    FOREIGN KEY (ID_Unidade) REFERENCES UnidadesSaude(ID_Unidade),
    FOREIGN KEY (ID_Pessoa) REFERENCES Pessoas(ID)
);

CREATE TABLE Consultas (
    ID_Consulta INT AUTO_INCREMENT PRIMARY KEY,
    ID_Medico INT,
    ID_Pessoa INT,
    Diagnostico TEXT,
    Tratamento TEXT,
    Doenca VARCHAR(255),
    FOREIGN KEY (ID_Medico) REFERENCES Funcionarios(ID_Func),
    FOREIGN KEY (ID_Pessoa) REFERENCES Pessoas(ID)
);

CREATE TABLE Exames (
    ID_Exame INT AUTO_INCREMENT PRIMARY KEY,
    ID_Laboratorio INT,
    ID_Pessoa INT,
    Data DATE,
    Resultado TEXT,
    Tipo VARCHAR(255),
    FOREIGN KEY (ID_Laboratorio) REFERENCES Laboratorios(ID_Laboratorio),
    FOREIGN KEY (ID_Pessoa) REFERENCES Pessoas(ID)
);

CREATE TABLE Vacinas (
    ID_Vacina INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(255) NOT NULL,
    Fabricante VARCHAR(255),
    Lote VARCHAR(255)
);


CREATE TABLE Laboratorios (
    ID_Laboratorio INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(255) NOT NULL,
    Localizacao VARCHAR(255),
    Telefone VARCHAR(15),
    Email VARCHAR(255),
    ID_Unidade INT,
    FOREIGN KEY (ID_Unidade) REFERENCES UnidadesSaude(ID_Unidade)
);

CREATE TABLE Medicos (
    ID_Medico INT AUTO_INCREMENT PRIMARY KEY,
    ID_Funcionario INT,
    CRM VARCHAR(20),
    Especialidade VARCHAR(255),
    FOREIGN KEY (ID_Funcionario) REFERENCES Funcionarios(ID_Func)
);

CREATE TABLE AgentesSaude (
    ID_AgenteS INT AUTO_INCREMENT PRIMARY KEY,
    ID_Funcionario INT,
    FOREIGN KEY (ID_Funcionario) REFERENCES Funcionarios(ID_Func)
);

CREATE TABLE AgentesCombate (
    ID_AgenteC INT AUTO_INCREMENT PRIMARY KEY,
    ID_Funcionario INT,
    FOREIGN KEY (ID_Funcionario) REFERENCES Funcionarios(ID_Func)
);

CREATE TABLE AgentesPrevencao (
    ID_AgenteP INT AUTO_INCREMENT PRIMARY KEY,
    ID_Funcionario INT,
    FOREIGN KEY (ID_Funcionario) REFERENCES Funcionarios(ID_Func)
);
