INSERT INTO banco_sj90.clientes (nome, cpf, data_cadastro) VALUES
    ('Caio Miranda', '444.555.777-96', '2026-01-01'),
    ('Júlia Reis', '999.888.777-55', '2026-04-21'),
    ('Luis Costa', '111.222.333-45', '2026-05-02'),
    ('Marina Duarte', '222.333.444-10', '2026-05-18'),
    ('Rafael Tavares', '333.444.555-21', '2026-06-03'),
    ('Beatriz Nogueira', '555.666.777-32', '2026-06-27'),
    ('Thiago Almeida', '666.777.888-43', '2026-07-09'),
    ('Camila Prado', '777.888.999-54', '2026-08-14');

INSERT INTO banco_sj90.perfis_seguranca (id_cliente, dispositivo_cadastrado, limite_diario) VALUES
    ((SELECT id FROM banco_sj90.clientes WHERE cpf = '444.555.777-96'), 'Lenovo Ideapad 3', 10000),
    ((SELECT id FROM banco_sj90.clientes WHERE cpf = '999.888.777-55'), 'Iphone 14 Pro', 30000),
    ((SELECT id FROM banco_sj90.clientes WHERE cpf = '111.222.333-45'), 'Xiaomi Redmi Note 12', 7500),
    ((SELECT id FROM banco_sj90.clientes WHERE cpf = '222.333.444-10'), 'Samsung Galaxy S23', 15000),
    ((SELECT id FROM banco_sj90.clientes WHERE cpf = '333.444.555-21'), 'Motorola Edge 40', 8000),
    ((SELECT id FROM banco_sj90.clientes WHERE cpf = '555.666.777-32'), 'MacBook Air M2', 25000),
    ((SELECT id FROM banco_sj90.clientes WHERE cpf = '666.777.888-43'), 'Dell Inspiron 15', 12000),
    ((SELECT id FROM banco_sj90.clientes WHERE cpf = '777.888.999-54'), 'Iphone 13', 20000);

INSERT INTO banco_sj90.cartoes_credito (id_cliente, id_banco, numero_cartao, limite_aprovado) VALUES
    ((SELECT id FROM banco_sj90.clientes WHERE cpf = '444.555.777-96'), 1,   '4000123456789010', 35000),
    ((SELECT id FROM banco_sj90.clientes WHERE cpf = '444.555.777-96'), 341, '6378282246310005', 50000),
    ((SELECT id FROM banco_sj90.clientes WHERE cpf = '444.555.777-96'), 237, '4222555566667777', 15000),
    ((SELECT id FROM banco_sj90.clientes WHERE cpf = '999.888.777-55'), 260, '5105105105105100', 100000),
    ((SELECT id FROM banco_sj90.clientes WHERE cpf = '111.222.333-45'), 104, '6363681234567890', 20000),
    ((SELECT id FROM banco_sj90.clientes WHERE cpf = '999.888.777-55'), 341, '5234871920043381', 60000),
    ((SELECT id FROM banco_sj90.clientes WHERE cpf = '999.888.777-55'), 77,  '4539017726458820', 40000),
    ((SELECT id FROM banco_sj90.clientes WHERE cpf = '111.222.333-45'), 33,  '6362540098173345', 12000),
    ((SELECT id FROM banco_sj90.clientes WHERE cpf = '222.333.444-10'), 237, '5412093867741205', 25000),
    ((SELECT id FROM banco_sj90.clientes WHERE cpf = '222.333.444-10'), 260, '4716230981456672', 18000),
    ((SELECT id FROM banco_sj90.clientes WHERE cpf = '222.333.444-10'), 1,   '6504317782290156', 30000),
    ((SELECT id FROM banco_sj90.clientes WHERE cpf = '333.444.555-21'), 104, '4024007183920461', 9000),
    ((SELECT id FROM banco_sj90.clientes WHERE cpf = '333.444.555-21'), 341, '5278640193307814', 14000),
    ((SELECT id FROM banco_sj90.clientes WHERE cpf = '555.666.777-32'), 33,  '4929518036627703', 45000);

INSERT INTO banco_sj90.produtos_financeiros (nome_produto, taxa_rendimento) VALUES
    ('Fundo Horizon Multimercado', 12.5),
    ('Fundo de Ações Tech', 16),
    ('Letra Financeira Apex', 11.45),
    ('LCA Safira Sustentável', 10.2),
    ('CRI Vertex Imobiliário', 9.35);

INSERT INTO banco_sj90.clientes_produtos (id_cliente, id_produto) VALUES
    ((SELECT id FROM banco_sj90.clientes WHERE cpf = '444.555.777-96'),(SELECT id FROM banco_sj90.produtos_financeiros WHERE nome_produto = 'Fundo Horizon Multimercado')),
    ((SELECT id FROM banco_sj90.clientes WHERE cpf = '444.555.777-96'),(SELECT id FROM banco_sj90.produtos_financeiros WHERE nome_produto = 'Fundo de Ações Tech')),
    ((SELECT id FROM banco_sj90.clientes WHERE cpf = '999.888.777-55'),(SELECT id FROM banco_sj90.produtos_financeiros WHERE nome_produto = 'Fundo de Ações Tech')),
    ((SELECT id FROM banco_sj90.clientes WHERE cpf = '111.222.333-45'),(SELECT id FROM banco_sj90.produtos_financeiros WHERE nome_produto = 'Letra Financeira Apex')),
    ((SELECT id FROM banco_sj90.clientes WHERE cpf = '111.222.333-45'),(SELECT id FROM banco_sj90.produtos_financeiros WHERE nome_produto = 'CRI Vertex Imobiliário'));