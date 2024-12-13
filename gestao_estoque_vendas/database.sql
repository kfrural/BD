CREATE TABLE funcionarios (
    id INT PRIMARY KEY,
    nome VARCHAR(100),
    cargo VARCHAR(50)
);

CREATE TABLE clientes (
    id INT PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    cidade VARCHAR(50)
);

CREATE TABLE produtos (
    id INT PRIMARY KEY,
    nome VARCHAR(100),
    preco DECIMAL(10,2),
    categoria VARCHAR(50)
);

CREATE TABLE estoque (
    produto_id INT,
    quantidade INT,
    data_cadastro DATE,
    PRIMARY KEY (produto_id, data_cadastro),
    FOREIGN KEY (produto_id) REFERENCES produtos(id)
);

CREATE TABLE vendas (
    id INT PRIMARY KEY,
    data DATE,
    valor DECIMAL(10,2),
    cliente_id INT,
    vendedor_id INT,
    produto_id INT,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id),
    FOREIGN KEY (vendedor_id) REFERENCES funcionarios(id),
    FOREIGN KEY (produto_id) REFERENCES produtos(id)
);

--exercicio 1
CREATE TABLE estoque_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    produto_id INT,
    quantidade_antiga INT,
    quantidade_nova INT,
    data_alteracao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TRIGGER log_estoque_alteracoes
AFTER UPDATE ON estoque
FOR EACH ROW
BEGIN
    INSERT INTO estoque_log (produto_id, quantidade_antiga, quantidade_nova)
    VALUES (OLD.produto_id, OLD.quantidade, NEW.quantidade);
END;

--exercicio 2
SELECT 
    vendedor_id,
    SUM(valor) AS total_vendas,
    COUNT(*) AS numero_vendas,
    AVG(valor) AS media_venda
FROM vendas
WHERE data BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 6 MONTH) AND CURRENT_DATE
GROUP BY vendedor_id;

--exercicio 3
SELECT 
    categoria,
    AVG(preco) OVER (PARTITION BY categoria) AS preco_medio
FROM produtos;

--exercicio 4
SELECT 
    p.id AS produto_id,
    p.nome AS produto_nome,
    e.quantidade,
    MAX(e.quantidade) OVER (PARTITION BY p.id) AS estoque_maximo
FROM estoque e
JOIN produtos p ON e.produto_id = p.id
WHERE e.quantidade < 0.2 * MAX(e.quantidade) OVER (PARTITION BY p.id);

--exercicio 5
SELECT 
    p.id AS produto_id,
    p.nome AS produto_nome,
    p.preco,
    LAG(p.preco) OVER (PARTITION BY p.id ORDER BY p.preco DESC) AS preco_anterior,
    p.preco - LAG(p.preco) OVER (PARTITION BY p.id ORDER BY p.preco DESC) AS diferenca_preco
FROM produtos p;

--exercicio 6
SELECT 
    c.cidade,
    COUNT(v.id) AS total_vendas,
    SUM(v.valor) AS valor_total
FROM vendas v
JOIN clientes c ON v.cliente_id = c.id
GROUP BY c.cidade;

--exercicio 7
ALTER TABLE produtos ADD COLUMN custo DECIMAL(10,2);

SELECT 
    v.id AS venda_id,
    v.valor AS preco_venda,
    p.custo AS preco_custo,
    (v.valor - p.custo) AS margem
FROM vendas v
JOIN produtos p ON v.produto_id = p.id;

--exercicio 8
SELECT 
    vendedor_id,
    SUM(valor) AS total_vendas,
    RANK() OVER (ORDER BY SUM(valor) DESC) AS ranking
FROM vendas
WHERE data BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 12 MONTH) AND CURRENT_DATE
GROUP BY vendedor_id;

--exerccio 9
SELECT 
    p.id AS produto_id,
    p.nome AS produto_nome,
    e.quantidade AS estoque_atual,
    COUNT(v.id) AS total_vendas
FROM produtos p
LEFT JOIN estoque e ON p.id = e.produto_id
LEFT JOIN vendas v ON p.id = v.produto_id
WHERE e.quantidade < 10
GROUP BY p.id, p.nome, e.quantidade;

--exercicio 10
SELECT 
    p.id AS produto_id,
    p.nome AS produto_nome,
    p.preco AS preco_atual,
    (p.preco * 1.1) AS preco_simulado,
    SUM(v.valor) * 1.1 AS vendas_simuladas
FROM produtos p
JOIN vendas v ON p.id = v.produto_id
GROUP BY p.id, p.nome, p.preco;


