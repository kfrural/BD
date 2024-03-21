CREATE DATABASE IF NOT EXISTS bulltech;
USE bulltech;

CREATE TABLE usuarios(
    ID int AUTO_INCREMENT PRIMARY KEY,
    nome varchar(30),
    sobrenome varchar(30),
    email varchar(50),
    telefone varchar(20),
    username varchar(20),
    senha varchar(20)
);

CREATE TABLE animais(
    ID int AUTO_INCREMENT PRIMARY KEY,
    qtd_animais int,
    data_entrada DATE,
    peso_medio double,
    valor_pg double,
    peso_final_pret double,
    data_final_pret DATE,
    Gasto_extraID double,
    valor_vendido double,
    usuarioID int,
    FOREIGN KEY (usuarioID) REFERENCES usuarios(ID)
);

CREATE TABLE Eventos (
    ID int AUTO_INCREMENT PRIMARY KEY,
    animaisID int,
    TipoEvento varchar(50),
    DataEvento date,
    Valor double,
    RecebimentoPagamento varchar(50),
    DataVencimento date,
    FOREIGN KEY (animaisID) REFERENCES animais(ID)
);

CREATE TABLE ControleFinanceiro (
    ID int AUTO_INCREMENT PRIMARY KEY,
    animaisID int,
    Ganhos double,
    Gastos double,
    Saldo double,
    FOREIGN KEY (animaisID) REFERENCES animais(ID)
);
