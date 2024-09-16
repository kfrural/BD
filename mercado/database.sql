CREATE TABLE Endereco ( --nao tem essa table mas achei melhor ter
	cod_endereco SERIAL PRIMARY KEY,
	endereco varchar(30),
	cidade varchar(15),
	cep varchar(8),
	uf varchar(2),
	cgc numeric(20),
	inscr_estadual varchar(20)
);

CREATE TABLE Cliente (
	cod_cliente numeric(5) PRIMARY KEY,
	nome_cliente varchar(20) NOT NULL,
	cod_endereco integer,
	FOREIGN KEY (cod_endereco) REFERENCES Endereco(cod_endereco)
);

CREATE TABLE Vendedor (
	cod_vendedor numeric(3) PRIMARY KEY,
	nome_vendedor varchar(20) NOT NULL,
	salario_fixo money,
	faixa_comissao varchar(1)
);

CREATE TABLE Pedido (
	cod_pedido numeric(5) PRIMARY KEY,
	prazo_entrega numeric(3),
	cod_cliente numeric(5),
	cod_vendedor numeric(3),
	FOREIGN KEY (cod_cliente) REFERENCES Cliente(cod_cliente),
	FOREIGN KEY (cod_vendedor) REFERENCES Vendedor(cod_vendedor)
);

CREATE TABLE Produto (
	cod_produto numeric(7) PRIMARY KEY,
	unidade varchar(3),
	descricao varchar(30),
	valor_unitario money
);

CREATE TABLE Item_Pedido (
	cod_pedido numeric(5),
	cod_produto numeric(7),
	quantidade numeric(9),
	PRIMARY KEY (cod_pedido, cod_produto),
	FOREIGN KEY (cod_pedido) REFERENCES Pedido(cod_pedido),
	FOREIGN KEY (cod_produto) REFERENCES Produto(cod_produto)
);
