CREATE TABLE Empregado (
    cpf VARCHAR(11) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    tipo ENUM('secretário', 'engenheiro', 'técnico') NOT NULL,
    idioma VARCHAR(50, NULL), -- pq so secretario q tem
    grau_tecnico VARCHAR(50) NULL, -- so tecnico q tem
    CREA VARCHAR(20) NULL, -- so eng q tem
    formacao_academica VARCHAR(100) NULL -- so gerente
);

CREATE TABLE Obras (
    cod_obra INT AUTO_INCREMENT PRIMARY KEY,
    nome_obra VARCHAR(100) NOT NULL,
    engenheiro_cpf VARCHAR(11),
    FOREIGN KEY (engenheiro_cpf) REFERENCES Empregado(cpf) ON DELETE SET NULL
);

CREATE TABLE Filiais (
    cod_filial INT AUTO_INCREMENT PRIMARY KEY,
    nome_filial VARCHAR(100) NOT NULL,
    gerente_cpf VARCHAR(11),
    FOREIGN KEY (gerente_cpf) REFERENCES Empregado(cpf) ON DELETE SET NULL
);

CREATE TABLE Pagamentos (
    cod_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    empregado_cpf VARCHAR(11),
    tipo_pagamento ENUM('mensalista', 'horista') NOT NULL,
    adicional_funcao DECIMAL(10, 2) DEFAULT 0.00, -- so gerente e eng
    FOREIGN KEY (empregado_cpf) REFERENCES Empregado(cpf) ON DELETE CASCADE
);

--dawui pra baixo so pra teste memo, desconsidera esse trem

--inserindo os empregado
INSERT INTO Empregado (cpf, nome, tipo, idioma, grau_tecnico, CREA, formacao_academica) VALUES
('12345678901', 'luiz eduardo', 'engenheiro', NULL, NULL, '1234567890', 'eng civil'),
('10987654321', 'jao', 'secretário', 'ingles', NULL, NULL, NULL),
('98765432100', 'ze', 'tecnico', NULL, 'tecnico em informatica', NULL, NULL),
('12312312312', 'filipe', 'gerente', NULL, NULL, NULL, 'adm'),
('32132132132', 'paulo', 'engenheiro', NULL, NULL, '0987654321', 'eng civil');

--inserindo obra
INSERT INTO Obras (nome_obra, engenheiro_cpf) VALUES
('Construção do Edifício A', '12345678901'),
('Reforma do Prédio B', '32132132132');

--inserindo as filial
INSERT INTO Filiais (nome_filial, gerente_cpf) VALUES
('Filial Centro', '12312312312'),
('Filial Norte', '32132132132');

--inserindo os pagamento
INSERT INTO Pagamentos (empregado_cpf, tipo_pagamento, adicional_funcao) VALUES
('12345678901', 'mensalista', 500.00),
('10987654321', 'horista', 0.00),
('98765432100', 'horista', 0.00),
('12312312312', 'mensalista', 800.00),
('32132132132', 'mensalista', 600.00);

--listar os empregado e tudo sobre eles
SELECT * FROM Empregado;

--listar os eng responsavel pelas obra
SELECT o.nome_obra, e.nome
FROM Obras o
JOIN Empregado e ON o.engenheiro_cpf = e.cpf;

--listar as filial e seus gerente
SELECT f.nome_filial, e.nome
FROM Filiais f
JOIN Empregado e ON f.gerente_cpf = e.cpf;

--listar os pagamento e o tipo
SELECT e.nome, p.tipo_pagamento, p.adicional_funcao
FROM Pagamentos p
JOIN Empregado e ON p.empregado_cpf = e.cpf;

--verificar qual eh tecnico
SELECT nome, grau_tecnico
FROM Empregado
WHERE tipo = 'tccnico';

--contar os empregado em cada tipo
SELECT tipo, COUNT(*) AS total
FROM Empregado
GROUP BY tipo;

