#!/usr/bin/env bash
# Bootstrap de dotfiles con GNU Stow.
#
# Uso:
#   ./install.sh              aplica los symlinks
#   ./install.sh --dry-run    muestra qué haría, sin tocar nada
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DOTFILES_DIR"

PACKAGES=(bash scripts)
DRY_RUN=0

for arg in "$@"; do
    case "$arg" in
        -n|--dry-run)
            DRY_RUN=1
            ;;
        -h|--help)
            echo "Uso: ./install.sh [--dry-run]"
            echo "Paquetes: ${PACKAGES[*]}"
            exit 0
            ;;
        *)
            echo "Opción desconocida: $arg" >&2
            exit 1
            ;;
    esac
done

if ! command -v stow >/dev/null 2>&1; then
    echo "ERROR: GNU Stow no está instalado." >&2
    echo "  Nobara/Fedora: sudo dnf install stow" >&2
    echo "  Debian/Ubuntu: sudo apt install stow" >&2
    exit 1
fi

mkdir -p "$HOME/.local/bin"

STOW_OPTS=()
if [[ $DRY_RUN -eq 1 ]]; then
    STOW_OPTS+=(-n -v)
    echo "==> Modo dry-run: no se crea nada"
fi

echo "==> Dotfiles: $DOTFILES_DIR"
echo "==> Paquetes: ${PACKAGES[*]}"

for pkg in "${PACKAGES[@]}"; do
    echo
    echo "==> stow $pkg"
    stow "${STOW_OPTS[@]}" "$pkg"
done

echo
if [[ $DRY_RUN -eq 1 ]]; then
    echo "Dry-run completado. Ejecuta sin --dry-run para aplicar."
else
    echo "Listo. Abre una shell nueva o ejecuta: source ~/.bashrc"
fi
