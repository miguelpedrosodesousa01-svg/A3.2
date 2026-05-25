@echo off
REM Compilacao simples do projeto Java
REM Autor: Sistema de Gestao de Projetos
REM Data: 25/05/2026

cd /d "%~dp0"
cls

echo.
echo ================================================
echo    COMPILACAO - Sistema Gestao Projetos
echo ================================================
echo.

REM Criar diretorios
if not exist bin mkdir bin
if not exist lib mkdir lib

echo [STEP 1] Compilando classes base...
javac -encoding UTF-8 -d bin ^
    src/model/*.java ^
    src/util/*.java
    
if %ERRORLEVEL% NEQ 0 (
    echo ERRO na compilacao das classes base
    exit /b 1
)
echo OK

REM Verificar se driver MySQL existe
if not exist "lib\mysql-connector-java-8.0.33.jar" (
    echo.
    echo [AVISO] Driver MySQL nao encontrado
    echo.
    echo Para funcionalidade completa:
    echo 1. Baixe: https://dev.mysql.com/downloads/connector/j/
    echo 2. Coloque em: lib\mysql-connector-java-8.0.33.jar
    echo.
    echo Continuando com compilacao limitada...
    echo.
    
    REM Compilar sem DAO/Service/UI (apenas model/util)
    echo.
    echo Aplicacao compilada com sucesso (modo limitado).
    echo Jars gerados em bin/
    
    pause
    exit /b 0
)

echo [STEP 2] Compilando com driver MySQL...
javac -encoding UTF-8 -cp bin;lib\mysql-connector-java-8.0.33.jar -d bin ^
    src/dao/*.java ^
    src/service/*.java ^
    src/ui/*.java ^
    src/Main.java ^
    src/MainDemo.java

if %ERRORLEVEL% NEQ 0 (
    echo ERRO na compilacao
    echo Verifique se mysql-connector-java.jar esta em lib/
    exit /b 1
)

echo OK

echo.
echo ================================================
echo    Compilacao concluida com sucesso!
echo ================================================
echo.
echo Para executar:
echo.
echo  1. Com banco de dados:
echo     java -cp bin;lib\mysql-connector-java-8.0.33.jar Main
echo.
echo  2. Demo (sem banco de dados):
echo     java -cp bin Main Demo
echo.

pause
