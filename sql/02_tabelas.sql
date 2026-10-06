DROP TABLE IF EXISTS banco_sj90.fraudes;
DROP TABLE IF EXISTS banco_sj90.clientes_produtos;
DROP TABLE IF EXISTS banco_sj90.cartoes_credito;
DROP TABLE IF EXISTS banco_sj90.perfis_seguranca;
DROP TABLE IF EXISTS banco_sj90.produtos_financeiros;
DROP TABLE IF EXISTS banco_sj90.clientes;
DROP TABLE IF EXISTS banco_sj90.bancos_parceiros;

CREATE TABLE banco_sj90.bancos_parceiros (
    codigo INT PRIMARY KEY,
    ispb VARCHAR(8) NOT NULL,
    nome VARCHAR(150) NOT NULL
);

CREATE TABLE banco_sj90.clientes (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    data_cadastro DATE
);

CREATE TABLE banco_sj90.perfis_seguranca (
    id_cliente INT PRIMARY KEY,
    FOREIGN KEY (id_cliente) REFERENCES banco_sj90.clientes(id),
    dispositivo_cadastrado VARCHAR(50),
    limite_diario DECIMAL(10,2)
);

CREATE TABLE banco_sj90.cartoes_credito (
    id_cartao SERIAL PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_banco INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES banco_sj90.clientes(id),
    FOREIGN KEY (id_banco) REFERENCES banco_sj90.bancos_parceiros(codigo),
    numero_cartao VARCHAR(16) UNIQUE NOT NULL,
    limite_aprovado DECIMAL(10,2)
);

CREATE TABLE banco_sj90.produtos_financeiros (
    id SERIAL PRIMARY KEY,
    nome_produto VARCHAR(50) NOT NULL,
    taxa_rendimento DECIMAL(10,2)
);

CREATE TABLE banco_sj90.clientes_produtos (
    id_cliente INT,
    id_produto INT,
    PRIMARY KEY (id_cliente, id_produto),
    FOREIGN KEY (id_cliente) REFERENCES banco_sj90.clientes(id),
    FOREIGN KEY (id_produto) REFERENCES banco_sj90.produtos_financeiros(id)
);

CREATE TABLE banco_sj90.fraudes (
    id         SERIAL PRIMARY KEY,
    trans_num  VARCHAR(50),
    id_cartao  INTEGER NOT NULL REFERENCES banco_sj90.cartoes_credito(id_cartao),
    merchant   VARCHAR(150),
    category   VARCHAR(50),
    amt        DECIMAL(12,2),
    unix_time  INTEGER,
    merch_lat  DECIMAL(9,6),
    merch_long DECIMAL(9,6)
);