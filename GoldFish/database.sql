CREATE TABLE Peixes (
    cod_peixe INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    peso DECIMAL(5,2) NOT NULL,
    tamanho DECIMAL(4,2) NOT NULL,
    foto BLOB,
    ração VARCHAR(200),
    problema VARCHAR(200)
);

CREATE TABLE Fornecedores (
    cod_forn INT PRIMARY KEY AUTO_INCREMENT,
    nome_forn VARCHAR(100) NOT NULL,
    país VARCHAR(50) NOT NULL
);

CREATE TABLE Criadores (
    cod_criador INT PRIMARY KEY AUTO_INCREMENT,
    nome_criador VARCHAR(100) NOT NULL,
    local VARCHAR(200) NOT NULL
);

CREATE TABLE Clientes (
    cod_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    endereço VARCHAR(200) NOT NULL,
    tipo VARCHAR(20) CHECK (tipo IN ('varejista', 'hobby')) NOT NULL
);

CREATE TABLE Pedidos (
    cod_pedido INT PRIMARY KEY AUTO_INCREMENT,
    data DATE NOT NULL,
    taxa_extra DECIMAL(5,2),
    cod_cliente INT,
    FOREIGN KEY (cod_cliente) REFERENCES Clientes(cod_cliente)
);

CREATE TABLE Racao (
    cod_racao INT PRIMARY KEY AUTO_INCREMENT,
    tipo VARCHAR(50) NOT NULL,
    data_compra DATE NOT NULL,
    quantidade DECIMAL(5,2) NOT NULL,
    cod_peixe INT,
    FOREIGN KEY (cod_peixe) REFERENCES Peixes(cod_peixe)
);

CREATE TABLE Doenças (
    cod_doenca INT PRIMARY KEY AUTO_INCREMENT,
    nome_doenca VARCHAR(100) NOT NULL,
    descrição VARCHAR(200)
);

CREATE TABLE Diagnosticos (
    cod_diagnostico INT PRIMARY KEY AUTO_INCREMENT,
    data_diagnostico DATE NOT NULL,
    cod_peixe INT,
    cod_doenca INT,
    FOREIGN KEY (cod_peixe) REFERENCES Peixes(cod_peixe),
    FOREIGN KEY (cod_doenca) REFERENCES Doenças(cod_doenca)
);

CREATE TABLE Tratamentos (
    cod_tratamento INT PRIMARY KEY AUTO_INCREMENT,
    descrição VARCHAR(200) NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE,
    cod_diagnostico INT,
    FOREIGN KEY (cod_diagnostico) REFERENCES Diagnosticos(cod_diagnostico)
);

ALTER TABLE Peixes
ADD COLUMN cod_forn INT,
ADD FOREIGN KEY (cod_forn) REFERENCES Fornecedores(cod_forn);

ALTER TABLE Peixes
ADD COLUMN cod_criador INT,
ADD FOREIGN KEY (cod_criador) REFERENCES Criadores(cod_criador);
