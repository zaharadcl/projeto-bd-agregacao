---
-- IMPLEMENTAÇÃO SQL COMPLETA (POSTGRESQL)
-- 100% FIEL AO DIAGRAMA MERMAID
---

-- 1. Funcionários (Com Autorelacionamento e atributos completos)
CREATE TABLE funcionario (
    id_funcionario SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    data_nascimento DATE,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE,
    cargo VARCHAR(50),
    salario DECIMAL(10, 2),
    data_admissao DATE,
    id_gerente INTEGER REFERENCES funcionario(id_funcionario) ON DELETE SET NULL
);

-- 2. Dependentes (Entidade Fraca com Atributos Completos)
CREATE TABLE dependente (
    id_funcionario INTEGER REFERENCES funcionario(id_funcionario) ON DELETE CASCADE,
    id_sequencial INTEGER,
    nome VARCHAR(100) NOT NULL,
    parentesco VARCHAR(20),
    data_nascimento DATE,
    PRIMARY KEY (id_funcionario, id_sequencial)
);

-- 3. Projetos (Com Descrição e Datas)
CREATE TABLE projeto (
    id_projeto SERIAL PRIMARY KEY,
    nome_projeto VARCHAR(100) NOT NULL,
    descricao TEXT,
    data_inicio DATE,
    data_fim DATE,
    orcamento DECIMAL(12, 2)
);

-- 4. Alocação (Agregação Parte 1: Com Carga Horária e Data de Saída)
CREATE TABLE alocacao (
    id_alocacao SERIAL PRIMARY KEY,
    id_funcionario INTEGER NOT NULL REFERENCES funcionario(id_funcionario),
    id_projeto INTEGER NOT NULL REFERENCES projeto(id_projeto),
    data_entrada DATE DEFAULT CURRENT_DATE,
    data_saida DATE,
    funcao_no_projeto VARCHAR(50),
    carga_horaria_semanal INTEGER
);

-- 5. Equipamentos (Com Tipo, Status e Descrição)
CREATE TABLE equipamento (
    id_equipamento SERIAL PRIMARY KEY,
    nome_equipamento VARCHAR(100) NOT NULL,
    tipo VARCHAR(50),
    patrimonio VARCHAR(50) UNIQUE NOT NULL,
    descricao TEXT,
    status VARCHAR(20) DEFAULT 'Disponível'
);

-- 6. Uso de Equipamento (Agregação Parte 2: Com Observação e Data Fim)
CREATE TABLE uso_equipamento (
    id_uso SERIAL PRIMARY KEY,
    id_alocacao INTEGER NOT NULL REFERENCES alocacao(id_alocacao) ON DELETE CASCADE,
    id_equipamento INTEGER NOT NULL REFERENCES equipamento(id_equipamento),
    data_inicio_uso TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_fim_uso TIMESTAMP,
    observacao TEXT
);
