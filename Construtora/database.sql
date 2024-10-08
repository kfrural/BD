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
