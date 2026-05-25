@echo off
color 0A
title SISTEMA DE GESTAO DE PROJETOS

echo.
echo ╔════════════════════════════════════════╗
echo ║  SISTEMA DE GESTÃO DE PROJETOS         ║
echo ║  Versão 1.0 - Pronto para Produção    ║
echo ╚════════════════════════════════════════╝
echo.

cd /d "%~dp0"

if not exist bin (
    echo ❌ Erro: Pasta 'bin' não encontrada!
    echo Execute compile.bat primeiro.
    pause
    exit /b 1
)

if not exist "lib\sqlite-jdbc-3.44.0.0.jar" (
    echo ❌ Erro: Driver SQLite não encontrado!
    pause
    exit /b 1
)

echo 🚀 Iniciando aplicação...
echo.

java -cp "bin;lib\*" Main

pause
