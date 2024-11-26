--criação das tabela
CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(255) UNIQUE,
    region_id INTEGER REFERENCES regions(id)
);

CREATE TABLE regions (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(id),
    order_date DATE,
    total_amount DECIMAL(10, 2)
);

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10, 2),
    cust_price DECIMAL(10, 2)
);

CREATE TABLE order_items (
    id SERIAL PRIMARY KEY,
    order_id INTEGER REFERENCES orders(id),
    product_id INTEGER REFERENCES products(id),
    quantity INTEGER,
    price_per_unit DECIMAL(10, 2)
);

-- insercao dos dados para fazer as analise
INSERT INTO regions (name) VALUES 
('Norte'), ('Sul'), ('Leste'), ('Oeste');

INSERT INTO products (name, category, price, cust_price) VALUES 
('Smartphone X', 'Smartphones', 999.99, 750.00),
('Laptop Pro', 'Laptops', 1299.99, 950.00),
('Tablet Pro', 'Tablets', 799.99, 650.00),
('Headset Pro', 'Accessories', 199.99, 150.00),
('Power Bank', 'Accessories', 49.99, 30.00);

INSERT INTO customers (name, email, region_id) VALUES 
('João Silva', 'joao.silva@example.com', 1),
('Maria Santos', 'maria.santos@example.com', 2),
('Pedro Rodrigues', 'pedro.rodrigues@example.com', 3),
('Ana Oliveira', 'ana.oliveira@example.com', 4),
('Carlos Ferreira', 'carlos.ferreira@example.com', 1);

INSERT INTO orders (customer_id, order_date, total_amount) VALUES 
(1, '2024-01-01', 999.99),
(2, '2024-02-15', 1299.99 + 799.99),
(3, '2024-03-20', 199.99 + 49.99),
(4, '2024-04-05', 999.99),
(5, '2024-05-10', 1299.99);

INSERT INTO order_items (order_id, product_id, quantity, price_per_unit) VALUES 
(1, 1, 1, 999.99),
(2, 2, 1, 1299.99),
(2, 3, 1, 799.99),
(3, 4, 1, 199.99),
(3, 5, 1, 49.99),
(4, 1, 1, 999.99),
(5, 2, 1, 1299.99);

--Top 5 produtos mais vendidos por região, incluindo o número de unidades vendidas e o valor total (exercicio1)
WITH region_product_sales AS (
  SELECT 
    r.name AS region,
    p.name AS product,
    SUM(oi.quantity) AS total_quantity,
    SUM(oi.quantity * oi.price_per_unit) AS total_value
  FROM customers c
  JOIN orders o ON c.id = o.customer_id
  JOIN order_items oi ON o.id = oi.order_id
  JOIN products p ON oi.product_id = p.id
  JOIN regions r ON c.region_id = r.id
  GROUP BY r.name, p.name
)
SELECT 
  region,
  product,
  total_quantity,
  total_value
FROM region_product_sales
ORDER BY region, total_value DESC;

--CClientes que compraram produtos da categoria "Smartphones" e também da categoria "Laptops(exercico2)
SELECT DISTINCT c.id, c.name
FROM customers c
JOIN orders o ON c.id = o.customer_id
JOIN order_items oi ON o.id = oi.order_id
JOIN products p ON oi.product_id = p.id
WHERE p.category IN ('Smartphones', 'Laptops');

--Crescimento percentual das vendas em cada região ano a ano(exercicio3)
WITH region_sales AS (
  SELECT 
    r.name AS region,
    EXTRACT(YEAR FROM o.order_date) AS year,
    SUM(oi.quantity * oi.price_per_unit) AS total_sales
  FROM customers c
  JOIN orders o ON c.id = o.customer_id
  JOIN order_items oi ON o.id = oi.order_id
  JOIN regions r ON c.region_id = r.id
  GROUP BY r.name, EXTRACT(YEAR FROM o.order_date)
)
SELECT 
  region,
  year,
  total_sales,
  LAG(total_sales) OVER (PARTITION BY region ORDER BY year) AS prev_year_sales,
  ROUND((total_sales / NULLIF(LAG(total_sales) OVER (PARTITION BY region ORDER BY year), 0)) - 1, 2) AS growth_rate
FROM region_sales
ORDER BY region, year;


--Produtos com maior margem de lucro (preço - custo) e exibir o nome do produto, preço de venda e margem de lucro(exercicio4)
WITH product_profit AS (
  SELECT 
    p.name AS product,
    p.price AS selling_price,
    oi.quantity * oi.price_per_unit AS revenue,
    oi.quantity * p.cust_price AS cost
  FROM products p
  JOIN order_items oi ON p.id = oi.product_id
  GROUP BY p.name, p.price, oi.quantity, p.cust_price
)
SELECT 
  product,
  selling_price,
  revenue,
  cost,
  selling_price - cost AS profit_margin
FROM product_profit
ORDER BY profit_margin DESC LIMIT 10;

--Tabela de fatos combinando informações de vendas, clientes e produtos para análise detalhado(exercicio5)
SELECT 
  c.name AS customer_name,
  o.order_date,
  p.name AS product_name,
  oi.quantity,
  oi.price_per_unit AS sale_amount
FROM customers c
JOIN orders o ON c.id = o.customer_id
JOIN order_items oi ON o.id = oi.order_id
JOIN products p ON oi.product_id = p.id;
