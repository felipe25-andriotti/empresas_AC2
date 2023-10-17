
CREATE TABLE marcas (
  mrc_id INT AUTO_INCREMENT NOT NULL,
  mrc_nome VARCHAR(50) NOT NULL,
  PRIMARY KEY (mrc_id)
);

CREATE TABLE produtos (
  prd_id INT AUTO_INCREMENT PRIMARY KEY,
  prd_nome VARCHAR(50) NOT NULL,
  mrc_nacionalidade VARCHAR(50) NOT NULL,
  prd_qtd_estoque INT DEFAULT 0,
  prd_estoque_min INT DEFAULT 0,
  prd_data_fabricacao TIMESTAMP DEFAULT NOW(),
  prd_perecivel BOOLEAN NOT NULL,
  prd_valor DECIMAL(10,2) NOT NULL,
  prd_marca_id INT,
  CONSTRAINT fkmrc FOREIGN KEY (prd_marca_id) REFERENCES marcas (mrc_id)
);

CREATE TABLE fornecedores (
  frn_id INT AUTO_INCREMENT NOT NULL,
  frn_nome VARCHAR(50) NOT NULL,
  frn_email VARCHAR(50) NOT NULL,
  prd_marca_id INT NOT NULL,
  CONSTRAINT fk_marcas FOREIGN KEY (prd_marca_id) REFERENCES marcas (mrc_id),
  PRIMARY KEY (frn_id)
);

CREATE TABLE produto_fornecedor (
  pf_prod_id INT NOT NULL,
  pf_forn_id INT NOT NULL,
  PRIMARY KEY (pf_prod_id, pf_forn_id),
  FOREIGN KEY (pf_prod_id) REFERENCES produtos (prd_id),
  FOREIGN KEY (pf_forn_id) REFERENCES fornecedores (frn_id)
);

INSERT INTO marcas (mrc_nome) VALUES ('Marca XYZ');
INSERT INTO marcas (mrc_nome) VALUES ('Marca ABC');
INSERT INTO marcas (mrc_nome) VALUES ('Marca 123');
INSERT INTO marcas (mrc_nome) VALUES ('Marca QWE');
INSERT INTO marcas (mrc_nome) VALUES ('Marca LKJ');

INSERT INTO produtos (prd_nome, mrc_nacionalidade, prd_qtd_estoque, prd_estoque_min, prd_data_fabricacao, prd_perecivel, prd_valor, prd_marca_id) VALUES
('Produto X', 'Nacional', 100, 10, NOW(), 1, 25.99, 1);
INSERT INTO produtos (prd_nome, mrc_nacionalidade, prd_qtd_estoque, prd_estoque_min, prd_data_fabricacao, prd_perecivel, prd_valor, prd_marca_id) VALUES
('Produto Y', 'Importado', 50, 5, NOW(), 0, 35.50, 2);
INSERT INTO produtos (prd_nome, mrc_nacionalidade, prd_qtd_estoque, prd_estoque_min, prd_data_fabricacao, prd_perecivel, prd_valor, prd_marca_id) VALUES
('Produto Z', 'Nacional', 75, 7, NOW(), 1, 19.99, 1);
INSERT INTO produtos (prd_nome, mrc_nacionalidade, prd_qtd_estoque, prd_estoque_min, prd_data_fabricacao, prd_perecivel, prd_valor, prd_marca_id) VALUES
('Produto A', 'Importado', 30, 3, NOW(), 0, 49.99, 3);
INSERT INTO produtos (prd_nome, mrc_nacionalidade, prd_qtd_estoque, prd_estoque_min, prd_data_fabricacao, prd_perecivel, prd_valor, prd_marca_id) VALUES
('Produto B', 'Nacional', 60, 6, NOW(), 1, 29.99, 4);

INSERT INTO fornecedores (frn_nome, frn_email, prd_marca_id) VALUES
('Fornecedor João', 'joao@example.com', 1);
INSERT INTO fornecedores (frn_nome, frn_email, prd_marca_id) VALUES
('Fornecedor Maria', 'maria@example.com', 2);
INSERT INTO fornecedores (frn_nome, frn_email, prd_marca_id) VALUES
('Fornecedor Pedro', 'pedro@example.com', 1);
INSERT INTO fornecedores (frn_nome, frn_email, prd_marca_id) VALUES
('Fornecedor Ana', 'ana@example.com', 3);
INSERT INTO fornecedores (frn_nome, frn_email, prd_marca_id) VALUES
('Fornecedor Luís', 'luis@example.com', 4);

INSERT INTO produto_fornecedor (pf_prod_id, pf_forn_id) VALUES (1, 1);
INSERT INTO produto_fornecedor (pf_prod_id, pf_forn_id) VALUES (2, 2);
INSERT INTO produto_fornecedor (pf_prod_id, pf_forn_id) VALUES (3, 3);
INSERT INTO produto_fornecedor (pf_prod_id, pf_forn_id) VALUES (4, 4);
INSERT INTO produto_fornecedor (pf_prod_id, pf_forn_id) VALUES (5, 5);

CREATE VIEW Produtos_Fornecedores_Marcas AS
SELECT
  produtos.prd_nome AS produtos,
  fornecedores.frn_nome AS fornecedores,
  marcas.mrc_nome AS marca
FROM produtos
JOIN produto_fornecedor ON produto_fornecedor.pf_prod_id = produtos.prd_id
JOIN fornecedores ON produto_fornecedor.pf_forn_id = fornecedores.frn_id
JOIN marcas ON marcas.mrc_id = produtos.prd_marca_id;

SELECT * FROM Produtos_Fornecedores_Marcas;
