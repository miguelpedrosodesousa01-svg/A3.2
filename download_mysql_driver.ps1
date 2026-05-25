# Script para baixar MySQL Connector/J
# Execute com: powershell -ExecutionPolicy Bypass -File download_mysql_driver.ps1

$ErrorActionPreference = "Continue"

Write-Host "╔════════════════════════════════════════════════════════╗"
Write-Host "║ Download MySQL Connector/J para Java                  ║"
Write-Host "╚════════════════════════════════════════════════════════╝"
Write-Host ""

$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
$libPath = Join-Path $scriptPath "lib"
$jarFile = Join-Path $libPath "mysql-connector-java-8.0.33.jar"

# Criar pasta lib se não existir
if (-not (Test-Path $libPath)) {
    New-Item -ItemType Directory -Path $libPath | Out-Null
    Write-Host "✓ Pasta 'lib' criada"
}

# Verificar se já existe
if (Test-Path $jarFile) {
    Write-Host "✓ Driver MySQL já existe em: $jarFile"
    exit 0
}

Write-Host ""
Write-Host "Tentando baixar mysql-connector-java-8.0.33.jar..."
Write-Host ""

# Tentativa 1: Maven Central
Write-Host "[1/3] Tentando Maven Central..."
$url1 = "https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.33/mysql-connector-java-8.0.33.jar"

try {
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $client = New-Object System.Net.WebClient
    $client.DownloadFile($url1, $jarFile)
    Write-Host "✓ Download bem-sucedido (Maven Central)"
    Write-Host "✓ Salvo em: $jarFile"
    exit 0
} catch {
    Write-Host "✗ Falha (Maven Central)"
}

# Tentativa 2: Google Storage
Write-Host "[2/3] Tentando Google Storage..."
$url2 = "https://storage.googleapis.com/java-bucket/mysql-connector-java-8.0.33.jar"

try {
    $client = New-Object System.Net.WebClient
    $client.DownloadFile($url2, $jarFile)
    Write-Host "✓ Download bem-sucedido (Google Storage)"
    Write-Host "✓ Salvo em: $jarFile"
    exit 0
} catch {
    Write-Host "✗ Falha (Google Storage)"
}

# Tentativa 3: JCenter
Write-Host "[3/3] Tentando JCenter..."
$url3 = "https://jcenter.bintray.com/mysql/mysql-connector-java/8.0.33/mysql-connector-java-8.0.33.jar"

try {
    $client = New-Object System.Net.WebClient
    $client.DownloadFile($url3, $jarFile)
    Write-Host "✓ Download bem-sucedido (JCenter)"
    Write-Host "✓ Salvo em: $jarFile"
    exit 0
} catch {
    Write-Host "✗ Falha (JCenter)"
}

Write-Host ""
Write-Host "╔════════════════════════════════════════════════════════╗"
Write-Host "║ Não foi possível baixar o driver automaticamente       ║"
Write-Host "╚════════════════════════════════════════════════════════╝"
Write-Host ""
Write-Host "Solução manual:"
Write-Host ""
Write-Host "1. Acesse: https://dev.mysql.com/downloads/connector/j/"
Write-Host "2. Escolha versão: 8.0.33 (ou mais recente)"
Write-Host "3. Faça download do arquivo .jar"
Write-Host "4. Coloque em: $libPath"
Write-Host ""
Write-Host "Ou use alternativa (Maven instalado):"
Write-Host "  mvn dependency:copy-dependencies -DoutputDirectory=lib"
Write-Host ""

Read-Host "Pressione ENTER para fechar"
exit 1
