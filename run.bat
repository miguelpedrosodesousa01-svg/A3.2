@echo off
REM Script de compilação e execução - Windows

cd /d "%~dp0"

echo.
echo ===============================================
echo Sistema de Gestao de Projetos
echo ===============================================
echo.

REM Criar diretórios
if not exist bin mkdir bin
if not exist lib mkdir lib

echo [1/4] Compilando classes model e util...
javac -encoding UTF-8 -d bin src/model/*.java src/util/ValidacaoUtil.java src/util/NegocioException.java 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo ERRO ao compilar model/util
    pause
    exit /b 1
)

echo [2/4] Verificando driver MySQL...
if not exist "lib\mysql-connector-java-8.0.33.jar" (
    echo.
    echo AVISO: Driver MySQL nao encontrado!
    echo.
    echo Opcoes:
    echo 1. Baixar: https://dev.mysql.com/downloads/connector/j/
    echo 2. Colocar em: lib\mysql-connector-java-8.0.33.jar
    echo.
    pause
    exit /b 1
)

echo [3/4] Compilando DAO, Service e UI...
javac -encoding UTF-8 -cp bin;lib/mysql-connector-java-8.0.33.jar -d bin ^
    src/dao/*.java src/service/*.java src/ui/*.java src/Main.java 2>nul

if %ERRORLEVEL% NEQ 0 (
    echo ERRO ao compilar DAO/Service/UI
    echo Verifique se o driver MySQL esta em lib/
    pause
    exit /b 1
)

echo [4/4] Iniciando aplicacao...
echo.
echo IMPORTANTE: Certifique-se de que:
echo   1. MySQL esta rodando (porta 3306)
echo   2. Banco 'gestao_projetos' foi criado
echo   3. Credenciais em src/util/ConexaoDB.java estao corretas
echo.
pause

java -cp bin;lib/mysql-connector-java-8.0.33.jar Main

pause
