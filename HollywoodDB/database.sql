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
