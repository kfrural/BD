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

