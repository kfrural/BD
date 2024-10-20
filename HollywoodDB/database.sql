CREATE TABLE Pessoas (
    cod_pessoa INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(20),
    endereco VARCHAR(200),
    sexo ENUM('Masculino', 'Feminino', 'Outro') NOT NULL,
    estado_civil ENUM('Solteiro', 'Casado', 'Divorciado', 'Viúvo') NOT NULL
);

CREATE TABLE Celebridades (
    cod_celebridade INT AUTO_INCREMENT PRIMARY KEY,
    tipo ENUM('Estrela de Cinema', 'Modelo') NOT NULL,
    cod_pessoa INT,
    tipo_filme VARCHAR(100),
    funcao VARCHAR(50),
    preferencias VARCHAR(200),
    FOREIGN KEY (cod_pessoa) REFERENCES Pessoas(cod_pessoa)
        ON DELETE CASCADE
);

CREATE TABLE EstrelasDeCinema (
    cod_estrela INT AUTO_INCREMENT PRIMARY KEY,
    cod_celebridade INT,
    FOREIGN KEY (cod_celebridade) REFERENCES Celebridades(cod_celebridade)
        ON DELETE CASCADE
);

CREATE TABLE Modelos (
    cod_modelo INT AUTO_INCREMENT PRIMARY KEY,
    cod_celebridade INT,
    FOREIGN KEY (cod_celebridade) REFERENCES Celebridades(cod_celebridade)
        ON DELETE CASCADE
);

CREATE TABLE Projetos (
    cod_projeto INT AUTO_INCREMENT PRIMARY KEY,
    tipo_projeto ENUM('Filme', 'Modelagem') NOT NULL,
    cod_estrela INT,
    cod_modelo INT,
    FOREIGN KEY (cod_estrela) REFERENCES EstrelasDeCinema(cod_estrela)
        ON DELETE SET NULL,
    FOREIGN KEY (cod_modelo) REFERENCES Modelos(cod_modelo)
        ON DELETE SET NULL
);

CREATE TABLE Patrocinadores (
    cod_patrocinador INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    tipo ENUM('Pessoa Física', 'Empresa') NOT NULL
);

CREATE TABLE ProjetoPatrocinador (
    cod_projeto INT,
    cod_patrocinador INT,
    PRIMARY KEY (cod_projeto, cod_patrocinador),
    FOREIGN KEY (cod_projeto) REFERENCES Projetos(cod_projeto)
        ON DELETE CASCADE,
    FOREIGN KEY (cod_patrocinador) REFERENCES Patrocinadores(cod_patrocinador)
        ON DELETE CASCADE
);


-- Inserindo uns dados para testar

INSERT INTO Pessoas (nome, telefone, endereco, sexo, estado_civil) VALUES
('Maria Silva', '1234-5678', 'Rua A, 123', 'Feminino', 'Solteiro'),
('João Oliveira', '9876-5432', 'Avenida B, 456', 'Masculino', 'Casado'),
('Ana Costa', '5555-1234', 'Rua C, 789', 'Feminino', 'Divorciado');

INSERT INTO Celebridades (tipo, cod_pessoa, tipo_filme, funcao, preferencias) VALUES
('Estrela de Cinema', 1, 'Aventura', 'Atriz', 'Filmes de ação e drama'),
('Modelo', 2, NULL, NULL, 'Moda e publicidades'),
('Estrela de Cinema', 3, 'Comédia', 'Atriz', 'Filmes de comédia');

INSERT INTO EstrelasDeCinema (cod_celebridade) VALUES
(1),
(3);

INSERT INTO Modelos (cod_celebridade) VALUES
(2);

INSERT INTO Projetos (tipo_projeto, cod_estrela, cod_modelo) VALUES
('Filme', 1, NULL),
('Filme', 3, NULL),
('Modelagem', NULL, 1);

INSERT INTO Patrocinadores (nome, tipo) VALUES
('Empresa A', 'Empresa'),
('João da Silva', 'Pessoa Física');

INSERT INTO ProjetoPatrocinador (cod_projeto, cod_patrocinador) VALUES
(1, 1),
(2, 2),
(3, 1);

SELECT * FROM Pessoas;

SELECT c.cod_celebridade, p.nome, c.tipo, c.tipo_filme, c.funcao, c.preferencias
FROM Celebridades c
JOIN Pessoas p ON c.cod_pessoa = p.cod_pessoa;

SELECT p.cod_projeto, p.tipo_projeto, e.cod_estrela, m.cod_modelo
FROM Projetos p
LEFT JOIN EstrelasDeCinema e ON p.cod_estrela = e.cod_estrela
LEFT JOIN Modelos m ON p.cod_modelo = m.cod_modelo;

SELECT pa.nome AS patrocinador, pr.cod_projeto, pr.tipo_projeto
FROM Patrocinadores pa
JOIN ProjetoPatrocinador pp ON pa.cod_patrocinador = pp.cod_patrocinador
JOIN Projetos pr ON pp.cod_projeto = pr.cod_projeto;
