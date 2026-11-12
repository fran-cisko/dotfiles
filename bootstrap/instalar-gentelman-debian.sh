#!/usr/bin/env bash
# Salir inmediatamente si un comando crítico falla
set -euo pipefail

echo "==> 1. Verificando requisitos previos en Debian / Loc-OS..."

# 1A. Verificar dependencias base de APT (Git, compiladores, SQLite)
DEPENDENCIAS="curl git build-essential sqlite3 libsqlite3-dev golang-go"
FALTANTES=""

for dep in $DEPENDENCIAS; do
    if ! dpkg -s $dep >/dev/null 2>&1; then
        FALTANTES="$FALTANTES $dep"
    fi
done

if [ -n "$FALTANTES" ]; then
    echo "Instalando dependencias faltantes vía APT:$FALTANTES"
    sudo apt-get update
    sudo apt-get install -y $FALTANTES
else
    echo "✅ Todas las dependencias base de APT ya están instaladas."
fi

# 1B. Verificar Node.js
if ! command -v node >/dev/null 2>&1; then
    echo "Node.js no encontrado. Instalando la versión 20 LTS..."
    curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
    sudo apt-get install -y nodejs
else
    echo "✅ Node.js ya está instalado: $(node -v)"
fi

echo "==> 2. Verificando pnpm (Gestor de paquetes para Gentle Shell)..."
if ! command -v pnpm >/dev/null 2>&1; then
    echo "pnpm no encontrado. Instalando vía npm global..."
    sudo npm install -g pnpm
else
    echo "✅ pnpm ya está instalado: $(pnpm -v)"
fi

# Directorio de trabajo
WORKSPACE="$HOME/code/gentle-stack"
mkdir -p "$WORKSPACE"
echo "==> Directorio de trabajo preparado en: $WORKSPACE"

echo "==> 3. Instalando Engram (Motor de Memoria)..."
cd "$WORKSPACE"
if [ ! -d "engram" ]; then
  git clone https://github.com/Gentleman-Programming/engram.git
fi
cd engram
echo "Compilando binario de Engram..."
go build -o engram .
sudo mv engram /usr/local/bin/
# Inicializar base de datos
engram doctor

echo "==> 4. Instalando Gentle-AI (Orquestador y CLI)..."
cd "$WORKSPACE"
if [ ! -d "gentle-ai" ]; then
  git clone https://github.com/Gentleman-Programming/gentle-ai.git
fi
cd gentle-ai
echo "Compilando binario de Gentle-AI..."
go build -o gentle-ai .
sudo mv gentle-ai /usr/local/bin/
# Inicializar entorno
gentle-ai init

echo "==> 5. Instalando Gentle Shell (Motor de ejecución Pi)..."
cd "$WORKSPACE"
if [ ! -d "gentle-shell" ]; then
  git clone https://github.com/Gentleman-Programming/gentle-shell.git
fi
cd gentle-shell
echo "Ejecutando bootstrap de Gentle Shell..."
sh scripts/bootstrap.sh

echo "========================================================"
echo "🎉 Instalación completada con éxito."
echo "   Ejecutá 'gentle-ai doctor' para comprobar tu entorno."
echo "========================================================"