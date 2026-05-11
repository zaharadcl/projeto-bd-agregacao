-- 1. Inserindo Funcionários (Primeiro o Gerente, depois os Subordinados)
INSERT INTO funcionario (nome, data_nascimento, cpf, email, cargo, salario, data_admissao, id_gerente) VALUES
('Ana Silva', '1985-03-20', '111.222.333-44', 'ana.silva@empresa.com', 'Diretora de TI', 15000.00, '2020-01-10', NULL),
('Bruno Costa', '1992-07-15', '555.666.777-88', 'bruno.costa@empresa.com', 'Gerente de Projetos', 8500.00, '2021-05-20', 1),
('Carla Souza', '1998-11-02', '999.888.777-66', 'carla.souza@empresa.com', 'Desenvolvedora Senior', 7000.00, '2022-03-15', 2);

-- 2. Inserindo Dependentes (Entidade Fraca vinculada aos funcionários)
INSERT INTO dependente (id_funcionario, id_sequencial, nome, parentesco, data_nascimento) VALUES
(1, 1, 'Alice Silva', 'Filha', '2015-06-12'),
(1, 2, 'Arthur Silva', 'Filho', '2018-09-30'),
(2, 1, 'Mariana Costa', 'Cônjuge', '1994-01-25');

-- 3. Inserindo Projetos
INSERT INTO projeto (nome_projeto, descricao, data_inicio, data_fim, orcamento) VALUES
('Sistema de Gestão 2.0', 'Migração do legado para PostgreSQL', '2026-01-01', '2026-12-31', 500000.00),
('App Mobile', 'Desenvolvimento de aplicativo para clientes', '2026-03-01', NULL, 150000.00);

-- 4. Inserindo Alocações (Agregação Parte 1: Vinculando Pessoas a Projetos)
INSERT INTO alocacao (id_funcionario, id_projeto, data_entrada, funcao_no_projeto, carga_horaria_semanal) VALUES
(2, 1, '2026-01-05', 'Líder Técnico', 40),
(3, 1, '2026-01-10', 'Desenvolvedora SQL', 40),
(3, 2, '2026-04-15', 'Consultora de Banco de Dados', 10);

-- 5. Inserindo Equipamentos
INSERT INTO equipamento (nome_equipamento, tipo, patrimonio, descricao, status) VALUES
('MacBook Pro M3', 'Notebook', 'PAT-001', 'Chip M3, 32GB RAM', 'Em Uso'),
('Monitor Dell 27"', 'Monitor', 'PAT-002', 'Resolução 4K', 'Em Uso'),
('Servidor de Testes', 'Hardware', 'PAT-003', 'Servidor Rack 1U', 'Disponível');

-- 6. Inserindo Uso de Equipamento (Agregação Parte 2: O vínculo entre Alocação e Equipamento)
INSERT INTO uso_equipamento (id_alocacao, id_equipamento, data_inicio_uso, observacao) VALUES
(1, 1, '2026-01-05', 'Entregue com mouse e teclado'),
(2, 2, '2026-01-12', 'Instalado na estação de trabalho da Carla'),
(2, 3, '2026-02-01', 'Acesso remoto liberado para testes de carga');
