# ⚡ GUIA RÁPIDO - Fazer o Código Rodar

## 📋 Checklist de Requisitos

- [ ] **Java 11+** instalado  
  - Verificar: `java -version`

- [ ] **MySQL 5.7+** rodando
  - Windows: Iniciar MySQL via Services
  - Mac/Linux: `brew services start mysql` ou `sudo systemctl start mysql`

- [ ] **Driver MySQL JDBC** (`mysql-connector-java-8.0.33.jar`)
  - Baixar: https://dev.mysql.com/downloads/connector/j/
  - Colocar em: `lib/mysql-connector-java-8.0.33.jar`

## 🚀 PASSO 1: Preparar o Banco de Dados

### Windows
```bash
# Abrir Command Prompt e conectar ao MySQL
mysql -u root -p

# Colar no MySQL:
```

```sql
CREATE DATABASE IF NOT EXISTS gestao_projetos CHARACTER SET utf8mb4;
USE gestao_projetos;

CREATE TABLE usuarios (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome_completo VARCHAR(150) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    cargo VARCHAR(80),
    login VARCHAR(50) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL,
    perfil ENUM('ADMINISTRADOR','GERENTE','COLABORADOR') NOT NULL
);

CREATE TABLE projetos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(150) NOT NULL,
    descricao TEXT,
    data_inicio DATE NOT NULL,
    data_termino_prevista DATE,
    status ENUM('PLANEJADO','EM_ANDAMENTO','CONCLUIDO','CANCELADO') DEFAULT 'PLANEJADO',
    gerente_id INT NOT NULL,
    FOREIGN KEY (gerente_id) REFERENCES usuarios(id)
);

CREATE TABLE equipes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT
);

CREATE TABLE equipe_membros (
    equipe_id INT,
    usuario_id INT,
    PRIMARY KEY (equipe_id, usuario_id),
    FOREIGN KEY (equipe_id) REFERENCES equipes(id),
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

CREATE TABLE equipe_projetos (
    equipe_id INT,
    projeto_id INT,
    PRIMARY KEY (equipe_id, projeto_id),
    FOREIGN KEY (equipe_id) REFERENCES equipes(id),
    FOREIGN KEY (projeto_id) REFERENCES projetos(id)
);

CREATE TABLE tarefas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(200) NOT NULL,
    descricao TEXT,
    projeto_id INT NOT NULL,
    responsavel_id INT,
    prazo DATE,
    status ENUM('PENDENTE','EM_ANDAMENTO','CONCLUIDA','BLOQUEADA') DEFAULT 'PENDENTE',
    FOREIGN KEY (projeto_id) REFERENCES projetos(id),
    FOREIGN KEY (responsavel_id) REFERENCES usuarios(id)
);

INSERT INTO usuarios (nome_completo, cpf, email, cargo, login, senha, perfil)
VALUES ('Administrador', '000.000.000-00', 'admin@oracle.com', 'Admin', 'admin', 'admin123', 'ADMINISTRADOR');
```

Ou execute o arquivo `database/schema.sql`:
```bash
mysql -u root -p gestao_projetos < database/schema.sql
```

## 🔧 PASSO 2: Configurar Credenciais

Edite `src/util/ConexaoDB.java`:

```java
private static final String URL  = "jdbc:mysql://localhost:3306/gestao_projetos?useSSL=false&serverTimezone=UTC";
private static final String USER = "root";              // Seu usuário MySQL
private static final String PASS = "sua_senha";        // Sua senha MySQL (deixe vazio se não tem)
```

## 📦 PASSO 3: Compilar

Clique duas vezes em:
```
compile_simple.bat  (Windows)
```

Ou via terminal:
```bash
cd "C:\Users\migue\Desktop\a3 final"
compile_simple.bat
```

## ▶️ PASSO 4: Executar

### Opção A: Com banco de dados (recomendado)
```bash
java -cp "bin;lib/mysql-connector-java-8.0.33.jar" Main
```

### Opção B: Demo (sem banco de dados)
```bash
java -cp bin MainDemo
```

---

## ❌ TROUBLESHOOTING

### "Driver MySQL not found"
**Solução**: Baixe o driver em https://dev.mysql.com/downloads/connector/j/ e coloque em `lib/`

### "Access denied for user 'root'"
**Solução**: Verifique sua senha MySQL em `src/util/ConexaoDB.java`

### "Unknown database 'gestao_projetos'"
**Solução**: Execute o script SQL `database/schema.sql` no MySQL

### "The type Java.lang.CharSequence cannot be resolved"
**Solução**: Atualize Java: `java -version` (precisa 11+)

---

## ✅ Sucesso!

Se tudo funcionou, você verá:
- Interface gráfica com 5 abas (Usuários, Projetos, Tarefas, Equipes, Relatórios)
- Login com `admin` / `admin123`
- Possibilidade de criar usuários, projetos e tarefas

---

## 📞 Próximos Passos

1. **Faça login** com `admin`/`admin123`
2. **Crie usuários** na aba "Usuários"
3. **Crie projetos** na aba "Projetos"
4. **Crie tarefas** na aba "Tarefas"
5. **Acompanhe** na aba "Relatórios"

---

**Duvidas?** Verifique `README.md`, `SETUP.md` ou `ARCHITECTURE.md`
