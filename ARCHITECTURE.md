# Documentação Técnica - Arquitetura e Design

## 🏗️ Arquitetura em Camadas

```
┌─────────────────────────────────────────────────────────────┐
│                    Presentation Layer (UI)                  │
│  MainFrame | UsuarioPanel | ProjetoPanel | TarefaPanel...  │
└──────────────────────┬──────────────────────────────────────┘
                       │
┌──────────────────────▼──────────────────────────────────────┐
│                 Business Logic Layer (Service)              │
│  UsuarioService | ProjetoService | TarefaService...         │
└──────────────────────┬──────────────────────────────────────┘
                       │
┌──────────────────────▼──────────────────────────────────────┐
│              Data Access Layer (DAO + Util)                 │
│  UsuarioDAO | ProjetoDAO | TarefaDAO | EquipeDAO            │
└──────────────────────┬──────────────────────────────────────┘
                       │
┌──────────────────────▼──────────────────────────────────────┐
│                  Database Layer (MySQL)                     │
│              gestao_projetos (Database)                     │
└─────────────────────────────────────────────────────────────┘
```

## 📊 Diagrama de Entidades e Relacionamentos (ER)

```
┌──────────────────────┐         ┌──────────────────────┐
│      USUARIOS        │         │    EQUIPES           │
├──────────────────────┤         ├──────────────────────┤
│ PK id                │    N    │ PK id                │
│    nome_completo     │◄────────┤    nome              │
│ UQ cpf               │  1      │    descricao         │
│ UQ email             │   (N:N) │                      │
│    cargo             │  através│                      │
│ UQ login             │ de      │                      │
│    senha             │ EQUIPE_ │                      │
│    perfil            │ MEMBROS │                      │
└──────────────────────┘         └──────────────────────┘
         ▲                                ▲
         │                                │
       1 │                                │ N
         │                                │
         │ (N:N)                          │
         │       ┌──────────────────┐     │
         └───────┤ EQUIPE_MEMBROS   ├─────┘
                 ├──────────────────┤
                 │ FK equipe_id     │
                 │ FK usuario_id    │
                 │ PK (equipe_id,   │
                 │     usuario_id)  │
                 └──────────────────┘

┌──────────────────────┐         ┌──────────────────────┐
│     PROJETOS         │         │       TAREFAS        │
├──────────────────────┤         ├──────────────────────┤
│ PK id                │    1    │ PK id                │
│    nome              │◄────────┤    titulo            │
│    descricao         │  N      │    descricao         │
│    data_inicio       │         │    status            │
│    data_termino_p.   │         │    prazo             │
│    status            │         │ FK projeto_id        │
│ FK gerente_id        │         │ FK responsavel_id    │
│ (referencia USUARIOS)│         │ (referencia USUARIOS)│
└──────────────────────┘         └──────────────────────┘
         ▲
         │ N
         │
    (N:N)│ através de EQUIPE_PROJETOS
         │
         ▼
    ┌────────────────┐
    │ EQUIPE_PROJETOS│
    ├────────────────┤
    │ FK equipe_id   │
    │ FK projeto_id  │
    │ PK (equipe_id, │
    │     projeto_id)│
    └────────────────┘
```

## 🔄 Fluxo de Dados

### Exemplo: Salvando um Usuário

```
UI (UsuarioPanel)
   └─ Coleta dados do formulário
   └─ Cria objeto Usuario
   └─ Chama service.salvar(usuario)
        │
        ▼
Service (UsuarioService)
   └─ Valida dados:
        └─ Validação de CPF
        └─ Validação de Email
        └─ Validação de Senha
        └─ Verifica duplicatas
   └─ Chama dao.inserir(usuario) ou dao.atualizar(usuario)
        │
        ▼
DAO (UsuarioDAO)
   └─ Monta SQL
   └─ Executa via JDBC
   └─ Retorna ID gerado
   └─ Atualiza objeto Usuario
        │
        ▼
Database (MySQL)
   └─ INSERT/UPDATE na tabela usuarios
   └─ Retorna resultado
        │
        ▼
Service (volta)
   └─ Retorna controle
        │
        ▼
UI (UsuarioPanel)
   └─ Recarrega tabela
   └─ Fecha diálogo
```

## 🎯 Padrões de Design Utilizados

### 1. **DAO Pattern (Data Access Object)**
- Isolamento da lógica de persistência
- Facilita testes e manutenção
- Exemplo: `UsuarioDAO`, `ProjetoDAO`

### 2. **Service Layer Pattern**
- Concentra lógica de negócio
- Valida dados antes de persistir
- Gerencia exceções
- Exemplo: `UsuarioService`, `ProjetoService`

### 3. **MVC (Model-View-Controller)**
- **Model**: Classes em `model/`
- **View**: Classes em `ui/` (Panels)
- **Controller**: Implícito nas Services

### 4. **Exception Handling Customizado**
- `NegocioException` para erros de negócio
- Mensagens amigáveis ao usuário
- Stack trace para debug

## 📋 Relacionamentos

### Usuário - Projeto (1:N)
- Um usuário pode gerenciar vários projetos
- Cada projeto tem um gerente

### Usuário - Tarefa (1:N)
- Um usuário pode ser responsável por várias tarefas
- Cada tarefa tem um responsável (opcional)

### Projeto - Tarefa (1:N)
- Um projeto contém várias tarefas
- Cada tarefa pertence a um projeto

### Usuário - Equipe (N:N)
- Um usuário pode estar em várias equipes
- Uma equipe pode ter vários usuários
- Tabela de junção: `equipe_membros`

### Equipe - Projeto (N:N)
- Uma equipe pode trabalhar em vários projetos
- Um projeto pode ter várias equipes
- Tabela de junção: `equipe_projetos`

## 🔐 Validações Implementadas

### UsuarioService
```java
validar(Usuario u):
  - Nome não vazio
  - CPF válido (dígitos verificadores)
  - Email válido (formato)
  - Senha mínimo 6 caracteres
  - CPF não duplicado
  - Email não duplicado
```

### ProjetoService
```java
validar(Projeto p, Usuario usuario):
  - Nome não vazio
  - Data de início obrigatória
  - Data de término posterior a início
  - Gerente responsável obrigatório
```

### TarefaService
```java
validar(Tarefa t):
  - Título não vazio
  - Vínculo com projeto obrigatório
```

## 🗂️ Estrutura de Pacotes

```
model/
  ├─ Enums: PerfilUsuario, StatusProjeto, StatusTarefa
  └─ Entidades: Usuario, Projeto, Tarefa, Equipe

dao/
  ├─ UsuarioDAO (CRUD + buscas)
  ├─ ProjetoDAO (CRUD + listas)
  ├─ TarefaDAO (CRUD + filtros por projeto)
  └─ EquipeDAO (CRUD + gerenciamento de membros)

service/
  ├─ UsuarioService (validações, autenticação)
  ├─ ProjetoService (validações, controle de exclusão)
  ├─ TarefaService (validações)
  └─ EquipeService (validações)

ui/
  ├─ MainFrame (container principal)
  ├─ UsuarioPanel (CRUD usuários)
  ├─ ProjetoPanel (CRUD projetos)
  ├─ TarefaPanel (CRUD tarefas com filtro)
  ├─ EquipePanel (CRUD equipes)
  └─ RelatorioPanel (visualização de dados)

util/
  ├─ ConexaoDB (gerenciador de conexões)
  ├─ ValidacaoUtil (validações diversas)
  └─ NegocioException (exceção customizada)
```

## 💾 Operações de Banco de Dados

### CRUD Completo
- **Create (C)**: `inserir()` em DAOs
- **Read (R)**: `buscarPorId()`, `listarTodos()`, etc
- **Update (U)**: `atualizar()` em DAOs
- **Delete (D)**: `deletar()` em DAOs

### Consultas Especializadas
```
UsuarioDAO:
  └─ buscarPorLogin(String login)
  └─ cpfExiste(String cpf, int ignorarId)
  └─ emailExiste(String email, int ignorarId)

TarefaDAO:
  └─ listarPorProjeto(int projetoId)
  └─ temTarefasEmAndamentoPorProjeto(int projetoId)

EquipeDAO:
  └─ listarMembros(int equipeId)
  └─ adicionarMembro(int equipeId, int usuarioId)
  └─ removerMembro(int equipeId, int usuarioId)
```

## 🔗 Dependências

```
java.sql (JDBC)
  └─ Connection, PreparedStatement, ResultSet

java.time
  └─ LocalDate (para datas)

javax.swing (GUI)
  └─ JFrame, JPanel, JTable, JDialog, etc

java.util
  └─ ArrayList, List, Stream API
```

## ⚠️ Considerações de Segurança

- **Senhas**: Armazenadas em texto plano (implementar hash em produção)
- **SQL Injection**: Prevenido com `PreparedStatement`
- **Validação**: Input validation em cada camada
- **Autorização**: Perfis definidos mas não implementados na UI

## 🚀 Melhorias Futuras

1. Implementar criptografia de senhas (bcrypt, Argon2)
2. Adicionar autenticação/autorização real
3. Implementar transações ACID
4. Adicionar logs centralizados
5. Criar testes unitários
6. Implementar paginação
7. Adicionar auditoria de mudanças
8. Usar ORM (Hibernate) para persistência
