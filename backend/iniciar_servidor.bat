@echo off
title 🚀 Servidor LucraPro - MODE DEBUG
cd /d "%~dp0"

:: Verifica se o Node.js está instalado
where node >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERRO CRÍTICO] Node.js não está instalado!
    echo Baixe em: https://nodejs.org/
    pause
    exit /b
)

:: Verifica dependências
if not exist "node_modules" (
    echo Instalando dependências...
    npm install
)

:: Inicia o servidor com tratamento de erros
echo Iniciando servidor Node.js...
echo Pasta atual: %cd%
npm run dev || (
    echo.
    echo [ERRO] O servidor falhou ao iniciar!
    echo Verifique:
    echo 1. Se o MongoDB está rodando (mongod)
    echo 2. Se a porta 5000 está livre
    echo 3. Erros no arquivo server.js
    echo.
    pause
)
pause