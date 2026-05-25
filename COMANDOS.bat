@REM COMANDOS PRONTOS PARA COPIAR E COLAR
@REM Arquivo: COMANDOS_PRONTO_PARA_USAR.bat

@echo off
REM Você pode copiar e colar os comandos abaixo no Command Prompt (cmd) ou PowerShell

echo.
echo ========================================
echo COMANDOS PRONTOS PARA COPIAR E COLAR
echo ========================================
echo.

echo [OPÇÃO 1] Compilar e Executar (em um comando)
echo.
echo   cd "C:\Users\migue\Desktop\a3 final" ^& ^
echo   javac -encoding UTF-8 -d bin -cp lib\mysql-connector-java-8.0.33.jar ^
echo       src/model/*.java src/util/*.java src/dao/*.java ^
echo       src/service/*.java src/ui/*.java src/Main.java src/MainDemo.java ^
echo   && java -cp "bin;lib\mysql-connector-java-8.0.33.jar" Main
echo.

echo [OPÇÃO 2] Apenas compilar
echo.
echo   cd "C:\Users\migue\Desktop\a3 final" ^& compile_simple.bat
echo.

echo [OPÇÃO 3] Apenas executar (depois de compilado)
echo.
echo   cd "C:\Users\migue\Desktop\a3 final" ^& ^
echo   java -cp "bin;lib\mysql-connector-java-8.0.33.jar" Main
echo.

echo [OPÇÃO 4] Executar Demo (sem banco de dados)
echo.
echo   cd "C:\Users\migue\Desktop\a3 final" ^& java -cp bin MainDemo
echo.

echo [OPÇÃO 5] Baixar Driver MySQL automaticamente
echo.
echo   powershell -ExecutionPolicy Bypass -File "C:\Users\migue\Desktop\a3 final\download_mysql_driver.ps1"
echo.

echo ========================================
echo COMANDOS PARA CRIAR BANCO DE DADOS
echo ========================================
echo.

echo [CRIAR DATABASE]
echo.
echo   mysql -u root -p < "C:\Users\migue\Desktop\a3 final\database\schema.sql"
echo.

echo [OU MANUALMENTE - Abra MySQL primeiro]
echo.
echo   mysql -u root -p
echo   source C:\Users\migue\Desktop\a3 final\database\schema.sql;
echo.

pause
