#!/usr/bin/env bash
# <descripción breve de qué hace el script>
#
# Uso:
#   <nombre> [opciones] <argumento>
set -euo pipefail

readonly SCRIPT_NAME="$(basename "${BASH_SOURCE[0]}")"

usage() {
    cat <<EOF
Uso: $SCRIPT_NAME [opciones] <argumento>

Opciones:
  -h, --help    Muestra esta ayuda

Ejemplo:
  $SCRIPT_NAME ejemplo
EOF
}

die() {
    echo "ERROR: $*" >&2
    exit 1
}

main() {
    local arg=""

    while [[ $# -gt 0 ]]; do
        case "$1" in
            -h|--help)
                usage
                exit 0
                ;;
            -*)
                die "opción desconocida: $1"
                ;;
            *)
                [[ -z "$arg" ]] || die "solo se admite un argumento"
                arg="$1"
                ;;
        esac
        shift
    done

    [[ -n "$arg" ]] || { usage >&2; exit 2; }

    # --- lógica ---
    echo "Procesando: $arg"
}

main "$@"
