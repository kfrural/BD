CREATE DATABASE BibliotecaUniversitaria;

USE BibliotecaUniversitaria;

--criacao das tabela

CREATE TABLE Estudantes (
    EstudanteID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Curso VARCHAR(100),
    AnoIngresso INT
);

CREATE TABLE Livros (
    LivroID INT AUTO_INCREMENT PRIMARY KEY,
    Titulo VARCHAR(150) NOT NULL,
    Autor VARCHAR(100),
    Genero VARCHAR(50),
    QuantidadeEstoque INT
);

CREATE TABLE Emprestimos (
    EmprestimoID INT AUTO_INCREMENT PRIMARY KEY,
    EstudanteID INT,
    LivroID INT,
    DataEmprestimo DATE,
    DataDevolucao DATE,
    Status VARCHAR(20) DEFAULT 'Emprestado',
    FOREIGN KEY (EstudanteID) REFERENCES Estudantes(EstudanteID),
    FOREIGN KEY (LivroID) REFERENCES Livros(LivroID)
);

CREATE TABLE Reservas (
    ReservaID INT AUTO_INCREMENT PRIMARY KEY,
    EstudanteID INT,
    LivroID INT,
    DataReserva DATE,
    Status VARCHAR(20) DEFAULT 'Ativa',
    FOREIGN KEY (EstudanteID) REFERENCES Estudantes(EstudanteID),
    FOREIGN KEY (LivroID) REFERENCES Livros(LivroID)
);

CREATE TABLE HistoricoAcessos (
    AcessoID INT AUTO_INCREMENT PRIMARY KEY,
    EstudanteID INT,
    DataAcesso DATE,
    FOREIGN KEY (EstudanteID) REFERENCES Estudantes(EstudanteID)
);

--inserindo dados

INSERT INTO Estudantes (Nome, Curso, AnoIngresso) VALUES
('Ana Silva', 'Engenharia de Software', 2022),
('João Oliveira', 'Ciência da Computação', 2021),
('Maria Santos', 'Engenharia Elétrica', 2020),
('Carlos Pereira', 'Arquitetura', 2023);

INSERT INTO Livros (Titulo, Autor, Genero, QuantidadeEstoque) VALUES
('Introdução à Programação', 'José Lima', 'Tecnologia', 10),
('Estruturas de Dados', 'Maria Tavares', 'Tecnologia', 5),
('História do Brasil', 'Clara Almeida', 'História', 7),
('Engenharia Civil Moderna', 'Luiz Ribeiro', 'Engenharia', 3);

INSERT INTO Emprestimos (EstudanteID, LivroID, DataEmprestimo, DataDevolucao, Status) VALUES
(1, 1, '2024-10-01', '2024-10-15', 'Devolvido'),
(2, 2, '2024-10-05', NULL, 'Emprestado'),
(3, 3, '2024-09-20', '2024-10-10', 'Devolvido');

INSERT INTO Reservas (EstudanteID, LivroID, DataReserva, Status) VALUES
(1, 2, '2024-09-30', 'Ativa'),
(4, 1, '2024-10-01', 'Ativa');

INSERT INTO HistoricoAcessos (EstudanteID, DataAcesso) VALUES
(1, '2024-10-01'),
(2, '2024-10-02'),
(1, '2024-10-03'),
(3, '2024-10-04'),
(4, '2024-10-05');

--exercicio3
WITH RankingPorGenero AS (
    SELECT 
        L.Genero,
        L.Titulo,
        COUNT(EM.EmprestimoID) AS TotalEmprestimos,
        RANK() OVER (PARTITION BY L.Genero ORDER BY COUNT(EM.EmprestimoID) DESC) AS Posicao
    FROM Livros L
    LEFT JOIN Emprestimos EM ON L.LivroID = EM.LivroID
    GROUP BY L.Genero, L.Titulo
)
SELECT Genero, Titulo, TotalEmprestimos
FROM RankingPorGenero
WHERE Posicao = 1;

--exercico4
SELECT 
    AVG(DATEDIFF(E.DataEmprestimo, R.DataReserva)) AS MediaDias
FROM Reservas R
JOIN Emprestimos E ON R.LivroID = E.LivroID AND R.EstudanteID = E.EstudanteID
WHERE R.Status = 'Ativa' AND E.Status = 'Emprestado';

--exercicio5
WITH AcessosSemestre AS (
    SELECT 
        EstudanteID,
        COUNT(AcessoID) AS TotalAcessos
    FROM HistoricoAcessos
    WHERE DataAcesso >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
    GROUP BY EstudanteID
)
SELECT E.Nome, A.TotalAcessos
FROM AcessosSemestre A
JOIN Estudantes E ON A.EstudanteID = E.EstudanteID
ORDER BY A.TotalAcessos DESC
LIMIT 5;

--exercico6
DELIMITER $$

CREATE FUNCTION CalcularMulta(pEmprestimoID INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE vDiasAtraso INT;
    DECLARE vMulta DECIMAL(10,2);
    
    SELECT DATEDIFF(CURDATE(), DataEmprestimo) - 15 INTO vDiasAtraso
    FROM Emprestimos
    WHERE EmprestimoID = pEmprestimoID;
    
    IF vDiasAtraso > 0 THEN
        SET vMulta = vDiasAtraso * 2.00;
    ELSE
        SET vMulta = 0.00;
    END IF;
    
    RETURN vMulta;
END$$

DELIMITER ;

--teste disso
SELECT CalcularMulta(2);

--exercico7
SELECT E.Nome, L.Genero, COUNT(EM.EmprestimoID) AS TotalEmprestimos
FROM Estudantes E
JOIN Emprestimos EM ON E.EstudanteID = EM.EstudanteID
JOIN Livros L ON EM.LivroID = L.LivroID
GROUP BY E.Nome, L.Genero
HAVING TotalEmprestimos > 3;

