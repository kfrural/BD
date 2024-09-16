CREATE TABLE Endereco (
	cod_endereco SERIAL PRIMARY KEY,
	endereco varchar(30),
	cep varchar(15),
	uf varchar(2),
	cgc int(20),
	inscr_estadual varchar(20)
);

CREATE TABLE Cliente (
	cod_cliente int(5) PRIMARY KEY,
	nome varchar(20),
	cod_endereco int,
	FOREIGN KEY (cod_endereco) REFERENCES Endereco(cod_endereco)
);

CREATE TABLE Pedido (
	num_pedido int(5) PRIMARY KEY,
	prazo_entrega int(3),
	cod_cliente int(5),
	cod_vendedor int(5),
	FOREIGN KEY (cod_cliente) REFERENCES Cliente(cod_cliente),
	FOREIGN KEY (cod_vendedor) REFERENCES Vendedor(cod_vendedor)
);
