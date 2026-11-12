# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment

# --- RUTAS DE EJECUCIÓN (PATH) ---
# Se agregan las carpetas personales estándar (~/.local/bin y ~/bin)
# más tus dos carpetas personalizadas al final.

export PATH="$PATH:$HOME/.local/bin:$HOME/bin:$HOME/Documents/My_Obsidian_Vault/350_Automatizations/Scripts_sh"
# siquisiera agregar otra ruta más sería export PATH="$PATH:$HOME/.local/bin:$HOME/bin:$HOME/Documents/My_Obsidian_Vault/350_Automatizations/Scripts_sh:$HOME/Ruta_Personalizada_2"

# --- cambio de path anterior, no agregaba bien a las rutas originales ---
#if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
#    PATH="$HOME/.local/bin:$HOME/bin:$PATH:$HOME/Documents/My_Obsidian_Vault/350_Automatizations/Scripts_sh"
#fi
#export PATH

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
    flatpak run --command=yazi io.github.sxyazi.yazi $@
}

function ya() {
    # share=network habilita la red para descargar temas y plugins
    flatpak --share=network run --command=ya io.github.sxyazi.yazi $@
}



export PATH=/home/cisco/bin:$PATH
export EDITOR=/usr/bin/vim

[[ -e "/home/cisco/lib/oracle-cli/lib/python3.14/site-packages/oci_cli/bin/oci_autocomplete.sh" ]] && source "/home/cisco/lib/oracle-cli/lib/python3.14/site-packages/oci_cli/bin/oci_autocomplete.sh"


# opencode
export PATH=/home/cisco/.opencode/bin:$PATH
