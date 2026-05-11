# Projeto BD - Agregação e Autorrelação

## 📚 Descrição do Projeto

Este projeto simula um sistema de gerenciamento de funcionários, projetos e equipamentos em uma empresa, aplicando conceitos de Banco de Dados Relacional, incluindo:

- Autorrelação (funcionário que gerencia outro funcionário)
- Agregação (relação entre funcionário, projeto e uso de equipamentos)
- Normalização e integridade referencial

---

## 🧩 Diagrama MER (Mermaid)
```mermaid
---
config:
  layout: elk
---
erDiagram
    %% 1. Autorelacionamento (Hierarquia)
    %% O funcionário pode ou não gerenciar outros (o{)
    FUNCIONARIO ||--o{ FUNCIONARIO : "gerencia (id_gerente)"

    %% 2. Dependência de Existência (Entidade Fraca)
    %% Mudança para |{ indica que o dependente NÃO existe sem o funcionário
    %% A PK de DEPENDENTE na teoria deveria ser composta por (id_funcionario, id_sequencial)
    FUNCIONARIO ||--|{ DEPENDENTE : possui

    %% 3. Agregação (Relação Funcionário + Projeto -> Equipamento)
    %% ALOCACAO centraliza essa abstração
    FUNCIONARIO ||--o{ ALOCACAO : participa
    PROJETO ||--o{ ALOCACAO : contem
    ALOCACAO ||--o{ USO_EQUIPAMENTO : registra
    EQUIPAMENTO ||--o{ USO_EQUIPAMENTO : utilizado

    FUNCIONARIO {
        int id_funcionario PK
        string nome
        date data_nascimento
        string cpf UK
        string email UK
        string cargo
        decimal salario
        date data_admissao
        int id_gerente FK "Auto-relacionamento"
    }

    DEPENDENTE {
        int id_funcionario FK "PK Composta / Dep. Existência"
        int id_sequencial PK
        string nome
        string parentesco
        date data_nascimento
    }

    PROJETO {
        int id_projeto PK
        string nome_projeto
        string descricao
        date data_inicio
        date data_fim
        decimal orcamento
    }

    ALOCACAO {
        int id_alocacao PK
        int id_funcionario FK
        int id_projeto FK
        date data_entrada
        date data_saida
        string funcao_no_projeto
        int carga_horaria_semanal
    }

    EQUIPAMENTO {
        int id_equipamento PK
        string nome_equipamento
        string tipo
        string patrimonio UK
        string descricao
        string status
    }

    USO_EQUIPAMENTO {
        int id_uso PK
        int id_alocacao FK "Referência à Agregação"
        int id_equipamento FK
        date data_inicio_uso
        date data_fim_uso
        string observacao
    }

```

---
🔁 Autorrelação (Supervisor)

A tabela FUNCIONARIO possui um autorrelacionamento através do campo id_gerente, onde:

Um funcionário pode ser gerente de outros funcionários.
Esse relacionamento é representado por uma FK que referencia a própria tabela.
Exemplo de consulta:
SELECT 
    f.nome AS funcionario,
    g.nome AS supervisor
FROM funcionario f
LEFT JOIN funcionario g
ON f.id_gerente = g.id_funcionario;
🧠 Agregação (Funcionário + Projeto + Equipamento)

A agregação ocorre quando o relacionamento entre funcionário e projeto (ALOCACAO) precisa ser expandido para incluir o uso de equipamentos.

Assim, a entidade USO_EQUIPAMENTO representa:

O uso de um equipamento por um funcionário dentro de um projeto específico.

Isso resolve o problema de rastrear qual equipamento foi usado, por quem e em qual projeto.
