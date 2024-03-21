INSERT INTO Clientes (Nome, Email, DataNascimento) VALUES ('João Silva', 'joao.silva@email.com', '1980-01-01');
INSERT INTO Clientes (Nome, Email, DataNascimento) VALUES ('Maria Santos', 'maria.santos@email.com', '1985-05-15');

INSERT INTO Produtos (Nome, Preco) VALUES ('Produto A', 100.00);
INSERT INTO Produtos (Nome, Preco) VALUES ('Produto B', 200.00);

INSERT INTO Pedidos (ClienteID, DataPedido, Total) VALUES (1, '2024-03-01', 300.00);
INSERT INTO Pedidos (ClienteID, DataPedido, Total) VALUES (2, '2024-03-02', 400.00);

INSERT INTO PedidoProdutos (PedidoID, ProdutoID, Quantidade) VALUES (1, 1, 2);
INSERT INTO PedidoProdutos (PedidoID, ProdutoID, Quantidade) VALUES (1, 2, 1);
INSERT INTO PedidoProdutos (PedidoID, ProdutoID, Quantidade) VALUES (2, 1, 1);
