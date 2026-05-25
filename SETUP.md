# Guia de Configuração - Sistema de Gestão de Projetos

## ⚙️ Pré-Requisitos

1. **Java Development Kit (JDK) 11+**
   - Download: https://www.oracle.com/java/technologies/downloads/
   - Verificar: `java -version`

2. **MySQL Server 5.7+**
   - Download: https://www.mysql.com/downloads/
   - Verificar: `mysql --version`

3. **MySQL Connector/J (JDBC Driver)**
   - Download: https://dev.mysql.com/downloads/connector/j/
   - Versão recomendada: 8.0.33+

## 📦 Instalação do MySQL Connector/J

### Windows
1. Baixe o arquivo `mysql-connector-java-x.x.x.jar`
2. Copie para uma pasta conhecida, ex: `C:\lib\`
3. Configure as variáveis de classpath

### Linux/Mac
```bash
# Via Homebrew (Mac)
brew install mysql-connector-java

# Via apt (Ubuntu/Debian)
sudo apt-get install libmysql-java
```

## 🗄️ Configuração do Banco de Dados

### 1. Criar o banco de dados

```bash
# Abrir o MySQL
mysql -u root -p

# Executar o script
source database/schema.sql;

# Verificar criação
SHOW DATABASES;
USE gestao_projetos;
SHOW TABLES;
```

### 2. Credenciais Padrão

| Campo | Valor |
|-------|-------|
| Usuário | admin |
| Senha | admin123 |
| Login | admin |
| Perfil | ADMINISTRADOR |

## 🔧 Configuração de Conexão

### Editar `src/util/ConexaoDB.java`

```java
private static final String URL  = "jdbc:mysql://localhost:3306/gestao_projetos?useSSL=false&serverTimezone=UTC";
private static final String USER = "root";           // Seu usuário MySQL
private static final String PASS = "sua_senha";     // Sua senha MySQL
```

### Parâmetros Importantes

- `useSSL=false`: Desabilita SSL (desenvolvimento)
- `serverTimezone=UTC`: Define zona de tempo

## 📂 Estrutura de Diretórios

Crie a seguinte estrutura antes de compilar:

```
projeto/
├── src/
│   ├── model/
│   ├── dao/
│   ├── service/
│   ├── ui/
│   ├── util/
│   └── Main.java
├── bin/                    # (será criado após compilação)
├── lib/
│   └── mysql-connector-java-x.x.x.jar
├── database/
│   └── schema.sql
└── README.md
```

## 🔨 Compilação

### Windows (PowerShell)

```powershell
# Criar diretório bin
mkdir bin

# Compilar com MySQL Connector
javac -cp ".;lib/mysql-connector-java-8.0.33.jar" -d bin `
  src/model/*.java `
  src/util/*.java `
  src/dao/*.java `
  src/service/*.java `
  src/ui/*.java `
  src/Main.java
```

### Linux/Mac (Terminal)

```bash
# Criar diretório bin
mkdir -p bin

# Compilar com MySQL Connector
javac -cp ".:lib/mysql-connector-java-8.0.33.jar" -d bin \
  src/model/*.java \
  src/util/*.java \
  src/dao/*.java \
  src/service/*.java \
  src/ui/*.java \
  src/Main.java
```

## ▶️ Execução

### Windows (PowerShell)

```powershell
java -cp "bin;lib/mysql-connector-java-8.0.33.jar" Main
```

### Linux/Mac (Terminal)

```bash
java -cp "bin:lib/mysql-connector-java-8.0.33.jar" Main
```

## 🐛 Troubleshooting

### Erro: "com.mysql.cj.jdbc.Driver not found"
- **Causa**: Falta o driver MySQL no classpath
- **Solução**: Certifique-se de incluir o `.jar` ao compilar e executar

### Erro: "Access denied for user 'root'"
- **Causa**: Credenciais incorretas
- **Solução**: Verifique `ConexaoDB.java` e suas credenciais MySQL

### Erro: "Unknown database 'gestao_projetos'"
- **Causa**: Banco de dados não foi criado
- **Solução**: Execute `database/schema.sql` no MySQL

### Erro: "No suitable driver found"
- **Causa**: Classpath incorreto
- **Solução**: Use ponto-e-vírgula (`;`) no Windows e dois-pontos (`:`) no Linux/Mac

## ✅ Verificação

Após executar, você deve ver:
1. Interface gráfica com 5 abas
2. Mensagens indicando sucesso de conexão
3. Possibilidade de fazer login com `admin`/`admin123`

## 📝 Próximos Passos

1. Faça login com as credenciais padrão
2. Crie usuários adicionais
3. Crie projetos e tarefas
4. Acompanhe o progresso nos relatórios

## 🚀 Dicas de Desenvolvimento

- Use IDEs como IntelliJ IDEA ou Eclipse para facilitar compilação
- Configure variáveis de ambiente JAVA_HOME e CLASSPATH
- Use ferramentas como Maven ou Gradle para gerenciar dependências (versão futura)
