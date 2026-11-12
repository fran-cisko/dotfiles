# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment

# --- RUTAS DE EJECUCIÓN (PATH) ---
# ~/.local/bin: scripts de dotfiles (Stow) y binarios de usuario.
# ~/bin: binarios propios.
# scripts/vault-bin: solo los scripts que viven dentro de la bóveda.

export PATH="$PATH:$HOME/.local/bin:$HOME/bin:$HOME/Documents/My_Obsidian_Vault/350_Automatizations/scripts/vault-bin"

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

# --- ENTORNO CARGO (RUST) ---
if [ -f "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
fi

# --- ATAJOS PERSONALIZADOS ---

# Atajos para Yazi instalado vía Flatpak
function yazi() {
    flatpak run --command=yazi io.github.sxyazi.yazi "$@"
}

function ya() {
    # share=network habilita la red para descargar temas y plugins
    flatpak --share=network run --command=ya io.github.sxyazi.yazi "$@"
}

export PATH="$HOME/bin:$PATH"
export EDITOR=/usr/bin/vim

ORACLE_AUTOCOMPLETE="$HOME/lib/oracle-cli/lib/python3.14/site-packages/oci_cli/bin/oci_autocomplete.sh"
[[ -e "$ORACLE_AUTOCOMPLETE" ]] && source "$ORACLE_AUTOCOMPLETE"

# opencode
export PATH="$HOME/.opencode/bin:$PATH"
