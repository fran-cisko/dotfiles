#!/usr/bin/env bash
# Exit immediately if a critical command fails
set -euo pipefail

echo "==> 1. Checking prerequisites on Nobara Linux..."

# 1A. Check and install base DNF packages (Compilers, SQLite, Go)
PACKAGES_TO_CHECK=("git" "gcc" "gcc-c++" "make" "sqlite-devel" "golang" "curl")
PACKAGES_TO_INSTALL=""

for pkg in "${PACKAGES_TO_CHECK[@]}"; do
    # rpm -q checks if the package is installed quietly
    if ! rpm -q "$pkg" &> /dev/null; then
        PACKAGES_TO_INSTALL="$PACKAGES_TO_INSTALL $pkg"
    fi
done

if [ -n "$PACKAGES_TO_INSTALL" ]; then
    echo "Installing missing dependencies via DNF:$PACKAGES_TO_INSTALL"
    sudo dnf install -y $PACKAGES_TO_INSTALL
else
    echo "✅ All base DNF dependencies (Git, Go, GCC, SQLite, etc.) are already installed."
fi

# 1B. Check for Node.js
if ! command -v node >/dev/null 2>&1; then
    echo "Node.js not found. Installing via DNF..."
    sudo dnf install -y nodejs
else
    echo "✅ Node.js is already installed: $(node -v)"
fi

echo "==> 2. Checking pnpm (Package Manager for Gentle Shell)..."
if ! command -v pnpm >/dev/null 2>&1; then
    echo "pnpm not found. Installing via global npm..."
    sudo npm install -g pnpm
else
    echo "✅ pnpm is already installed: $(pnpm -v)"
fi

# Workspace directory
WORKSPACE="$HOME/code/gentle-stack"
mkdir -p "$WORKSPACE"
echo "==> Workspace prepared at: $WORKSPACE"

echo "==> 3. Installing Engram (Memory Engine)..."
cd "$WORKSPACE"
if [ ! -d "engram" ]; then
  git clone https://github.com/Gentleman-Programming/engram.git
fi
cd engram
echo "Building Engram binary..."
go build -o engram .
sudo mv engram /usr/local/bin/
# Initialize database
engram doctor

echo "==> 4. Installing Gentle-AI (Orchestrator and CLI)..."
cd "$WORKSPACE"
if [ ! -d "gentle-ai" ]; then
  git clone https://github.com/Gentleman-Programming/gentle-ai.git
fi
cd gentle-ai
echo "Building Gentle-AI binary..."
go build -o gentle-ai .
sudo mv gentle-ai /usr/local/bin/
# Initialize environment
gentle-ai init

echo "==> 5. Installing Gentle Shell (Pi Execution Engine)..."
cd "$WORKSPACE"
if [ ! -d "gentle-shell" ]; then
  git clone https://github.com/Gentleman-Programming/gentle-shell.git
fi
cd gentle-shell
echo "Running Gentle Shell bootstrap..."
sh scripts/bootstrap.sh

echo "========================================================"
echo "🎉 Installation completed successfully."
echo "   Run 'gentle-ai doctor' to verify your environment."
echo "========================================================"
