# Sistema de Gestão de Projetos e Equipes — Oracle

Um aplicativo Java completo para gerenciar projetos, tarefas, equipes e usuários com interface gráfica Swing e banco de dados MySQL.

## Estrutura do Projeto

```
src/
├── model/              # Classes de modelo (entidades)
│   ├── PerfilUsuario.java
│   ├── StatusProjeto.java
│   ├── StatusTarefa.java
│   ├── Usuario.java
│   ├── Projeto.java
│   ├── Tarefa.java
│   └── Equipe.java
├── dao/                # Data Access Objects (persistência)
│   ├── UsuarioDAO.java
│   ├── ProjetoDAO.java
│   ├── TarefaDAO.java
│   └── EquipeDAO.java
├── service/            # Camada de negócio
│   ├── UsuarioService.java
│   ├── ProjetoService.java
│   ├── TarefaService.java
│   └── EquipeService.java
├── ui/                 # Interface gráfica (Swing)
│   ├── MainFrame.java
│   ├── UsuarioPanel.java
│   ├── ProjetoPanel.java
│   ├── TarefaPanel.java
│   ├── EquipePanel.java
│   └── RelatorioPanel.java
├── util/               # Utilitários
│   ├── ConexaoDB.java
│   ├── ValidacaoUtil.java
│   └── NegocioException.java
└── Main.java           # Ponto de entrada

database/
└── schema.sql          # Script de criação do banco de dados
```

## Requisitos

- **Java 11+**
- **MySQL 5.7+**
- **MySQL Connector/J** (driver JDBC)

## Configuração

### 1. Banco de Dados

Execute o script SQL para criar o banco de dados:

```sql
-- Executar o arquivo: database/schema.sql
```

Ou via linha de comando MySQL:

```bash
mysql -u root -p < database/schema.sql
```

### 2. Dependências

Adicione o driver MySQL ao classpath:

```bash
# Baixar MySQL Connector/J
# https://dev.mysql.com/downloads/connector/j/
```

### 3. Configuração de Conexão

Edite `src/util/ConexaoDB.java` com suas credenciais MySQL:

```java
private static final String URL  = "jdbc:mysql://localhost:3306/gestao_projetos";
private static final String USER = "root";
private static final String PASS = "sua_senha";
```

## Compilação e Execução

### Compilar

```bash
javac -cp ".:lib/mysql-connector-java-x.x.x.jar" \
  -d bin \
  src/model/*.java \
  src/util/*.java \
  src/dao/*.java \
  src/service/*.java \
  src/ui/*.java \
  src/Main.java
```

### Executar

```bash
java -cp "bin:lib/mysql-connector-java-x.x.x.jar" Main
```

## Funcionalidades

### 👥 Usuários
- Criar, editar e excluir usuários
- Validação de CPF, email e senha
- Gerenciamento de perfis (Administrador, Gerente, Colaborador)
- Autenticação por login

### 📁 Projetos
- Criar e gerenciar projetos
- Associar gerentes aos projetos
- Acompanhar status (Planejado, Em Andamento, Concluído, Cancelado)
- Calcular progresso automaticamente

### 🏷 Tarefas
- Criar tarefas vinculadas a projetos
- Atribuir responsáveis
- Definir prazos
- Gerenciar status (Pendente, Em Andamento, Concluída, Bloqueada)

### 🤝 Equipes
- Criar equipes
- Adicionar/remover membros
- Associar equipes a projetos

### 📊 Relatórios
- Visualizar resumo de projetos
- Acompanhar progresso de execução
- Exibir informações de gerentes e prazos

## Padrões de Design

- **DAO Pattern**: Camada de acesso a dados isolada
- **Service Layer**: Lógica de negócio centralizada
- **MVC**: Separação entre interface e lógica
- **Exception Handling**: Tratamento customizado com `NegocioException`

## Validações

- **CPF**: Validação de formato e dígitos verificadores
- **Email**: Validação de formato
- **Senha**: Mínimo 6 caracteres
- **Projetos**: Data de término posterior à data de início
- **Tarefas**: Título obrigatório e vínculo com projeto

## Notas

- Senhas são armazenadas em texto plano (considere usar hash em produção)
- O banco de dados usa `CHARACTER SET utf8mb4` para suportar caracteres especiais
- A interface utiliza Swing com Look and Feel do sistema operacional

## Licença

Este projeto é fornecido como está, sem garantias.
