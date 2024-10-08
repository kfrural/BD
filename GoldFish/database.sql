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

--inserir uns trem pra testar... daqui pra baixo desconsideara

--inserindo os fornecedor
INSERT INTO Fornecedores (nome_forn, país)
VALUES ('abc', 'Brasil'),
       ('def', 'Estados Unidos');

--inserindo os criador
INSERT INTO Criadores (nome_criador, local)
VALUES ('jao', 'São Paulo'),
       ('ze', 'Rio de Janeiro');

--inserindo cliente
INSERT INTO Clientes (nome, endereço, tipo)
VALUES ('filipe', 'Rua 1, 123', 'varejista'),
       ('luiz', 'Rua 2, 456', 'hobby');

--inserindo peixe
INSERT INTO Peixes (nome, peso, tamanho, foto, ração, problema, cod_forn, cod_criador)
VALUES ('Tilápia', 2.50, 30.5, NULL, 'Ração Proteica', 'Infecção Bacteriana', 1, 1),
       ('Carpa', 4.00, 50.0, NULL, 'Ração Vegetal', 'Nenhum', 2, 2);

--inserindo pedido
INSERT INTO Pedidos (data, taxa_extra, cod_cliente)
VALUES ('2024-10-01', 10.50, 1),
       ('2024-10-03', 5.00, 2);

--inserirndo racao
INSERT INTO Racao (tipo, data_compra, quantidade, cod_peixe)
VALUES ('Proteica', '2024-09-25', 5.00, 1),
       ('Vegetal', '2024-09-30', 10.00, 2);

--inserindo doenca
INSERT INTO Doenças (nome_doenca, descrição)
VALUES ('Infecção Bacteriana', 'aaaaaa'),
       ('Parasitose', 'bbbb');

--inserindo diagnostico
INSERT INTO Diagnosticos (data_diagnostico, cod_peixe, cod_doenca)
VALUES ('2024-10-01', 1, 1);

--inserindo tratamento
INSERT INTO Tratamentos (descrição, data_inicio, data_fim, cod_diagnostico)
VALUES ('Antibiótico por 7 dias', '2024-10-02', '2024-10-09', 1);

--listando os peixe com fornecedor e criador
SELECT P.nome AS Peixe, P.peso, P.tamanho, F.nome_forn AS Fornecedor, C.nome_criador AS Criador
FROM Peixes P
JOIN Fornecedores F ON P.cod_forn = F.cod_forn
JOIN Criadores C ON P.cod_criador = C.cod_criador;

--listanfo os pedido dos cliente e as descricao
SELECT Pe.nome AS Peixe, Cl.nome AS Cliente, Pe.racao, Cl.tipo, Pe.problema, Pe.peso
FROM Peixes Pe
JOIN Pedidos Pd ON Pd.cod_cliente = Cl.cod_cliente
JOIN Clientes Cl ON Pd.cod_cliente = Cl.cod_cliente;

--listar os peixe com diagnostico e tratamento
SELECT P.nome AS Peixe, D.nome_doenca AS Doença, T.descrição AS Tratamento, T.data_inicio, T.data_fim
FROM Peixes P
JOIN Diagnosticos Di ON P.cod_peixe = Di.cod_peixe
JOIN Doenças D ON Di.cod_doenca = D.cod_doenca
JOIN Tratamentos T ON Di.cod_diagnostico = T.cod_diagnostico;

--verificar estoque das racao
SELECT P.nome AS Peixe, R.tipo AS TipoRacao, R.quantidade, R.data_compra
FROM Racao R
JOIN Peixes P ON R.cod_peixe = P.cod_peixe;

--ver os peixe que tem problema de saude com diagnostico
SELECT P.nome AS Peixe, P.problema
FROM Peixes P
WHERE P.problema IS NOT NULL AND P.problema <> 'Nenhum';
