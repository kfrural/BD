--Tabela Pessoa
CREATE TABLE Pessoa (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    data_nascimento DATE,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    tipo ENUM('Funcionario', 'Geral') NOT NULL
);

-- Tabela Endereco
CREATE TABLE Endereco (
    id SERIAL PRIMARY KEY,
    pessoa_id INT REFERENCES Pessoa(id) ON DELETE CASCADE,
    rua VARCHAR(255) NOT NULL,
    numero VARCHAR(10),
    complemento VARCHAR(50),
    bairro VARCHAR(100),
    cidade VARCHAR(100),
    estado VARCHAR(2),
    cep VARCHAR(10)
);

-- Tabela Equipe
CREATE TABLE Equipe (
    id SERIAL PRIMARY KEY,
    setor VARCHAR(255) NOT NULL
);

-- Tabela Funcionario
CREATE TABLE Funcionario (
    id SERIAL PRIMARY KEY,
    pessoa_id INT REFERENCES Pessoa(id) ON DELETE CASCADE,
    equipe_id INT REFERENCES Equipe(id) ON DELETE SET NULL,
    funcao ENUM('Agente', 'Epidemiologico') NOT NULL
);

-- Tabela Laboratorio
CREATE TABLE Laboratorio (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    endereco VARCHAR(255),
    telefone VARCHAR(15),
    email VARCHAR(100)
);

-- Tabela Exame
CREATE TABLE Exame (
    id SERIAL PRIMARY KEY,
    pessoa_id INT REFERENCES Pessoa(id) ON DELETE CASCADE,
    laboratorio_id INT REFERENCES Laboratorio(id) ON DELETE SET NULL,
    data_exame DATE NOT NULL,
    resultado ENUM('Positivo', 'Negativo') NOT NULL,
    tipo_dengue ENUM('Dengue 1', 'Dengue 2', 'Dengue 3'),
    tipo_informe ENUM('Laboratorial', 'Clinico') NOT NULL
);

-- Tabela Notificacao
CREATE TABLE Notificacao (
    id SERIAL PRIMARY KEY,
    exame_id INT REFERENCES Exame(id) ON DELETE CASCADE,
    tipo VARCHAR(100) NOT NULL,
    data_notificacao DATE NOT NULL,
    hora_notificacao TIME NOT NULL,
    sintomas TEXT,
    origem ENUM('Pessoa', 'Laboratorio', 'Farmacia', 'Clinica') NOT NULL
);

-- esse trem é pra melhorar a forma de consultar e ter um prumo melhor
CREATE INDEX idx_pessoa_cpf ON Pessoa(cpf);
CREATE INDEX idx_endereco_pessoa ON Endereco(pessoa_id);
CREATE INDEX idx_funcionario_pessoa ON Funcionario(pessoa_id);
CREATE INDEX idx_funcionario_equipe ON Funcionario(equipe_id);
CREATE INDEX idx_exame_pessoa ON Exame(pessoa_id);
CREATE INDEX idx_exame_laboratorio ON Exame(laboratorio_id);
CREATE INDEX idx_notificacao_exame ON Notificacao(exame_id);
