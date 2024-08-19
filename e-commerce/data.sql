CREATE TABLE "Cliente" (
	"login" INTEGER NOT NULL UNIQUE,
	"nome" VARCHAR NOT NULL,
	"sobrenome" VARCHAR NOT NULL,
	"email" VARCHAR,
	"senha" VARCHAR,
	"telefone" VARCHAR,
	"id_endereco" INTEGER,
	PRIMARY KEY("login")
);


CREATE TABLE "Endereço" (
	"id" INTEGER NOT NULL UNIQUE,
	"logradouro" VARCHAR,
	"cidade" VARCHAR,
	"estado" VARCHAR,
	PRIMARY KEY("id")
);


CREATE TABLE "Carrinho" (
	"id_Car" INTEGER NOT NULL UNIQUE,
	"tipo" VARCHAR,
	"preco_total" NUMERIC,
	"id_data" INTEGER,
	PRIMARY KEY("id_Car")
);


CREATE TABLE "Data" (
	"id_Data" INTEGER NOT NULL UNIQUE,
	"dia" NUMERIC,
	"mes" NUMERIC,
	"ano" NUMERIC,
	PRIMARY KEY("id_Data")
);


CREATE TABLE "Lista_de_itens" (
	"id_Lista" INTEGER NOT NULL UNIQUE,
	"preco" NUMERIC,
	"quantidade" INTEGER,
	"id_carrinho" INTEGER,
	"id_estoque" INTEGER,
	PRIMARY KEY("id_Lista")
);


CREATE TABLE "Estoque" (
	"cod_Prod" INTEGER NOT NULL UNIQUE,
	"quant_Est" INTEGER,
	"cor" VARCHAR,
	"tamanho" VARCHAR,
	PRIMARY KEY("cod_Prod")
);


CREATE TABLE "Produto" (
	"cod_Prod" INTEGER NOT NULL UNIQUE,
	"nome_Prod" VARCHAR,
	"preco" NUMERIC,
	"figura" BYTEA,
	PRIMARY KEY("cod_Prod")
);


ALTER TABLE "Endereço"
ADD FOREIGN KEY("id") REFERENCES "Cliente"("id_endereco")
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "Cliente"
ADD FOREIGN KEY("login") REFERENCES "Carrinho"("id_Car")
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "Data"
ADD FOREIGN KEY("id_Data") REFERENCES "Carrinho"("id_data")
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "Lista_de_itens"
ADD FOREIGN KEY("id_carrinho") REFERENCES "Carrinho"("id_Car")
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "Lista_de_itens"
ADD FOREIGN KEY("id_estoque") REFERENCES "Estoque"("cod_Prod")
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "Produto"
ADD FOREIGN KEY("cod_Prod") REFERENCES "Estoque"("cod_Prod")
ON UPDATE NO ACTION ON DELETE NO ACTION;
