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

INSERT INTO Endereco(endereco, cidade, cep, uf, cgc, inscr_estadual)
VALUES ('Fazenda Boa Esperanca', 'São Geraldo', '36530000','mg' , 1, '1' );

INSERT INTO Endereco(endereco, cidade, cep, uf, cgc, inscr_estadual)
VALUES ('Bairro Manuel Moreira', 'Sao Geraldo', '36530000','mg' , 2, '2');

INSERT INTO Endereco(endereco, cidade, cep, uf, cgc, inscr_estadual)
VALUES ('Av Santa Rita', 'Viçosa', '36570099','mg' , 3, 3);

SELECT * FROM Endereco;

INSERT INTO Cliente (cod_cliente, nome_cliente, cod_endereco)
VALUES (1,'Karla', 1);

INSERT INTO Cliente (cod_cliente, nome_cliente, cod_endereco)
VALUES (2, 'jao', 2);

INSERT INTO Cliente (cod_cliente, nome_cliente, cod_endereco)
VALUES (3, 'luiz', 3);

SELECT * FROM Cliente;

INSERT INTO Vendedor (cod_vendedor, nome_vendedor, salario_fixo, faixa_comissao)
VALUES (1, 'ze', 2000.00, '3');

INSERT INTO Vendedor (cod_vendedor, nome_vendedor, salario_fixo, faixa_comissao)
VALUES (2, 'jr', 1234.00, '4');

INSERT INTO Vendedor (cod_vendedor, nome_vendedor, salario_fixo, faixa_comissao)
VALUES (3, 'pedro', 3214.33, '5');

SELECT * FROM Vendedor;

INSERT INTO Pedido (cod_pedido, prazo_entrega, cod_cliente, cod_vendedor)
VALUES (1, 10, 1, 1);

INSERT INTO Pedido (cod_pedido, prazo_entrega, cod_cliente, cod_vendedor)
VALUES (2, 30, 2, 2);

INSERT INTO Pedido (cod_pedido, prazo_entrega, cod_cliente, cod_vendedor)
VALUES (3, 60, 3, 3);

SELECT * FROM Pedido;

INSERT INTO Produto (cod_produto, unidade, descricao, valor_unitario)
VALUES (1, 'kg', 'arroz', 40.00);

INSERT INTO Produto (cod_produto, unidade, descricao, valor_unitario)
VALUES (2, 'kg', 'feijao', 10.00);

INSERT INTO Produto (cod_produto, unidade, descricao, valor_unitario)
VALUES (3, 'un', 'agua', 1.50);

SELECT * FROM Produto;

INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade)
VALUES (1, 1, 12);

INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade)
VALUES (2, 2, 2);

INSERT INTO Item_Pedido (cod_pedido, cod_produto, quantidade)
VALUES (3, 3, 3);

SELECT * FROM Item_Pedido;

-- exercicio num 1
SELECT descricao, unidade, valor_unitario
FROM Produto;

-- exercico num2
SELECT c.nome_cliente, e.endereco, e.cgc
FROM Cliente c
JOIN Endereco e ON c.cod_endereco = e.cod_endereco;

--exercico num3
SELECT * FROM Vendedor;

--exercicio 4
SELECT cod_pedido, cod_produto, quantidade FROM Item_Pedido
WHERE quantidade = 32;

UPDATE Item_Pedido SET quantidade = 32
WHERE cod_pedido = 1 AND cod_produto = 1;--pq tinha cadastrado sem 32

--exercicio 5
SELECT c.nome_cliente, e.endereco, e.cidade, e.uf
FROM Cliente c
JOIN Endereco e ON c.cod_endereco = e.cod_endereco
WHERE e.uf = 'rj'; --nao tem

--exercicio 6
SELECT descricao FROM Produto
WHERE unidade = 'un' AND valor_unitario:: numeric < 30.00; --converter pra numeric pra comparar essse trem

--exercicio 7
SELECT c.nome_cliente, e.endereco, e.cidade, e.uf
FROM Cliente c
JOIN Endereco e ON c.cod_endereco = e.cod_endereco
WHERE e.cidade = 'rio de janeiro' OR e.uf = 'rj'; --nao tem 

--exercicio 8
SELECT * FROM Pedido WHERE cod_cliente <> 2; --mudei pra 2 pra ter graca

--exercicio 9
SELECT cod_produto, descricao FROM Produto
WHERE valor_unitario::numeric BETWEEN 5.00 AND 12.00; -- converter pra poder comparar

--exercicio 10
SELECT * FROM Produto WHERE unidade LIKE 'k%';

--exercicio 11
SELECT * FROM Vendedor WHERE nome_vendedor NOT LIKE 'v%';

--exercicio 12
SELECT * FROM Vendedor WHERE faixa_comissao IN ('5', '15');

--exercicio13
SELECT nome_vendedor, salario_fixo FROM Vendedor
ORDER BY nome_vendedor;

--exercico 14
SELECT c.nome_cliente, e.cidade, e.uf FROM Cliente c
JOIN Endereco e ON c.cod_endereco = e.cod_endereco
ORDER BY e.uf DESC, e.cidade DESC;

--exercicio 15
SELECT descricao, valor_unitario FROM Produto
WHERE unidade = 'kg' --mudei pra dar certo
ORDER BY valor_unitario ASC;

--exercicio16
SELECT nome_vendedor, salario_fixo::numeric + (salario_fixo::numeric * 0.75) + 120.00
FROM Vendedor WHERE faixa_comissao = '5'
ORDER BY nome_vendedor;

--exercicio 17
SELECT MIN(salario_fixo) AS menor_salario, MAX(salario_fixo) AS maior_salario
FROM Vendedor;
