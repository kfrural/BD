CREATE TABLE Dpto (
	cod_dpto int PRIMARY KEY,
	nome_dpto varchar(100) NOT NULL
);

CREATE TABLE Titulacao (
	cod_tit int PRIMARY KEY,
	nome_tit varchar(100) NOT NULL
);

CREATE TABLE Professor (
	cod_prof int PRIMARY KEY,
	cod_dpto int,
	cod_tit int,
	nome_prof varchar(100) NOT NULL,
	FOREIGN KEY (cod_dpto) REFERENCES Dpto(cod_dpto),
	FOREIGN KEY (cod_tit) REFERENCES Titulacao(cod_tit)
);

CREATE TABLE Disciplina (
	cod_dpto int,
	num_disc int,
	nome_disc varchar(100) NOT NULL,
	creditos_disc int,
	PRIMARY KEY (cod_dpto, num_disc),
	FOREIGN KEY (cod_dpto) REFERENCES Dpto(cod_dpto)
);

CREATE TABLE Pre_req (
	cod_dpto int,
	num_disc int,
	num_disc_req int,
	PRIMARY KEY (cod_dpto, num_disc, num_disc_req),
	FOREIGN KEY (cod_dpto, num_disc) REFERENCES Disciplina (cod_dpto, num_disc)
);

CREATE TABLE Turma (
	cod_dpto int,
	num_disc int,
	anos_sem int,
	sigla_tur varchar(10),
	PRIMARY KEY (cod_dpto, num_disc, anos_sem, sigla_tur),
	FOREIGN KEY (cod_dpto, num_disc) REFERENCES Disciplina (cod_dpto, num_disc)
);

CREATE TABLE Prof_Turma (
	cod_dpto int,
	num_disc int,
	anos_sem int,
	sigla_tur varchar(10),
	cod_prof int,
	PRIMARY KEY (cod_dpto, num_disc, anos_sem, sigla_tur, cod_prof),
	FOREIGN KEY (cod_dpto, num_disc, anos_sem, sigla_tur) REFERENCES Turma (cod_dpto, num_disc, anos_sem, sigla_tur),
	FOREIGN KEY (cod_prof) REFERENCES Professor (cod_prof)
);

CREATE TABLE Predio (
	cod_predio int PRIMARY KEY,
	descricao_predio varchar(100) NOT NULL
);

CREATE TABLE Sala (
	cod_predio int,
	num_sala int,
	descricao_sala varchar(100) NOT NULL,
	capacidade int,
	PRIMARY KEY (cod_predio, num_sala),
	FOREIGN KEY (cod_predio) REFERENCES Predio (cod_predio)
);

CREATE TABLE Horario (
	cod_dpto int,
	num_disc int,
	anos_sem int,
	sigla_tur varchar(10),
	dia_sem int,
	hora_inicio time,
	cod_predio int,
	num_sala int,
	num_horas int,
	PRIMARY KEY (cod_dpto, num_disc, anos_sem, sigla_tur, dia_sem, hora_inicio),
	FOREIGN KEY (cod_dpto, num_disc, anos_sem, sigla_tur) REFERENCES Turma (cod_dpto, num_disc, anos_sem, sigla_tur),
	FOREIGN KEY (cod_predio) REFERENCES Predio(cod_predio),
	FOREIGN KEY (num_sala) REFERENCES Sala (num_sala)
);

INSERT INTO Dpto (cod_dpto, nome_dpto) VALUES (1, 'Departamento de Ciências Exatas');
INSERT INTO Dpto (cod_dpto, nome_dpto) VALUES (2, 'Departamento de Humanas');
INSERT INTO Dpto (cod_dpto, nome_dpto) VALUES (3, 'Departamento de Engenharia');

INSERT INTO Titulacao (cod_tit, nome_tit) VALUES (1, 'Mestre');
INSERT INTO Titulacao (cod_tit, nome_tit) VALUES (2, 'Doutor');
INSERT INTO Titulacao (cod_tit, nome_tit) VALUES (3, 'Especialista');

INSERT INTO Professor (cod_prof, cod_dpto, cod_tit, nome_prof) VALUES (1, 1, 1, 'Prof. João');
INSERT INTO Professor (cod_prof, cod_dpto, cod_tit, nome_prof) VALUES (2, 2, 2, 'Prof. Tavares');
INSERT INTO Professor (cod_prof, cod_dpto, cod_tit, nome_prof) VALUES (3, 3, 3, 'Prof. Maria');

INSERT INTO Disciplina (cod_dpto, num_disc, nome_disc, creditos_disc) VALUES (1, 101, 'Cálculo I', 4);
INSERT INTO Disciplina (cod_dpto, num_disc, nome_disc, creditos_disc) VALUES (2, 202, 'Filosofia', 3);
INSERT INTO Disciplina (cod_dpto, num_disc, nome_disc, creditos_disc) VALUES (3, 303, 'Engenharia de Software', 5);

INSERT INTO Pre_req (cod_dpto, num_disc, num_disc_req) VALUES (1, 101, 100);
INSERT INTO Pre_req (cod_dpto, num_disc, num_disc_req) VALUES (2, 202, 201);
INSERT INTO Pre_req (cod_dpto, num_disc, num_disc_req) VALUES (3, 303, 302);

INSERT INTO Turma (cod_dpto, num_disc, anos_sem, sigla_tur) VALUES (1, 101, 2024, 'A');
INSERT INTO Turma (cod_dpto, num_disc, anos_sem, sigla_tur) VALUES (2, 202, 2024, 'B');
INSERT INTO Turma (cod_dpto, num_disc, anos_sem, sigla_tur) VALUES (3, 303, 2024, 'C');

INSERT INTO Prof_Turma (cod_dpto, num_disc, anos_sem, sigla_tur, cod_prof) VALUES (1, 101, 2024, 'A', 1);
INSERT INTO Prof_Turma (cod_dpto, num_disc, anos_sem, sigla_tur, cod_prof) VALUES (2, 202, 2024, 'B', 2);
INSERT INTO Prof_Turma (cod_dpto, num_disc, anos_sem, sigla_tur, cod_prof) VALUES (3, 303, 2024, 'C', 3);

INSERT INTO Predio (cod_predio, descricao_predio) VALUES (1, 'Prédio Principal');
INSERT INTO Predio (cod_predio, descricao_predio) VALUES (2, 'Prédio de Engenharia');
INSERT INTO Predio (cod_predio, descricao_predio) VALUES (3, 'Prédio de Humanas');

INSERT INTO Sala (cod_predio, num_sala, descricao_sala, capacidade) VALUES (1, 101, 'Sala 101', 40);
INSERT INTO Sala (cod_predio, num_sala, descricao_sala, capacidade) VALUES (2, 202, 'Sala 202', 30);
INSERT INTO Sala (cod_predio, num_sala, descricao_sala, capacidade) VALUES (3, 303, 'Sala 303', 50);

INSERT INTO Horario (cod_dpto, num_disc, anos_sem, sigla_tur, dia_sem, hora_inicio, cod_predio, num_sala, num_horas) 
VALUES (1, 101, 2024, 'A', 2, '08:00:00', 1, 101, 2);

INSERT INTO Horario (cod_dpto, num_disc, anos_sem, sigla_tur, dia_sem, hora_inicio, cod_predio, num_sala, num_horas) 
VALUES (2, 202, 2024, 'B', 3, '10:00:00', 2, 202, 3);

INSERT INTO Horario (cod_dpto, num_disc, anos_sem, sigla_tur, dia_sem, hora_inicio, cod_predio, num_sala, num_horas) 
VALUES (3, 303, 2024, 'C', 4, '14:00:00', 3, 303, 2);


--exercicio 1
SELECT p.descricao_predio, COUNT(s.num_sala) AS qtd_salas
FROM Predio p LEFT JOIN Sala s ON p.cod_predio = s.cod_predio
GROUP BY p.descricao_predio
ORDER BY p.descricao_predio;

--exerccio 2
SELECT p.descricao_predio, COUNT(s.num_sala) AS qtd_sala
FROM Predio p LEFT JOIN Sala s ON p.cod_predio = s.cod_predio
GROUP BY p.descricao_predio
HAVING COUNT (s.num_sala) > 3;

--exercicio 3
SELECT d.nome_disc, t.sigla_tur FROM Professor p
JOIN Prof_Turma pt ON p.cod_prof = pt.cod_prof
JOIN Turma t ON pt.cod_dpto = t.cod_dpto AND pt.num_disc = t.num_disc AND pt.anos_sem = t.anos_sem AND pt.sigla_tur = t.sigla_tur
JOIN Disciplina d ON t.cod_dpto = d.cod_dpto AND t.num_disc = d.num_disc
WHERE p.nome_prof = 'Tavares';

--exercicio 4
SELECT d.nome_disc, t.sigla_tur
FROM Disciplina d
LEFT JOIN Turma t ON d.cod_dpto = t.cod_dpto AND d.num_disc = t.num_disc;
