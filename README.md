# dotfiles

Configuración personal de la máquina, versionada con git y enlazada con GNU Stow.

## Contenido

| Paquete | Se enlaza a | Qué incluye |
|---|---|---|
| `bash` | `~/.bashrc`, `~/.profile`, `~/.bash_profile`, `~/.bash_logout` | Shell, PATH, alias |
| `git` | `~/.gitconfig` | Identidad y credential helper de `gh` |
| `gtk` | `~/.config/gtk-3.0/`, `~/.config/gtk-4.0/` | Tema, fuentes y decoración |
| `fontconfig` | `~/.config/fontconfig/fonts.conf` | Reglas de fuentes |
| `autostart` | `~/.config/autostart/` | Apps al iniciar sesión |
| `systemd` | `~/.config/systemd/user/` | Servicios de usuario |
| `vscode` | `~/.config/Code/User/settings.json` | Ajustes del editor |
| `restic` | `~/.config/restic/excludes.txt` | Exclusiones del backup (la contraseña va aparte) |
| `scripts` | `~/.local/bin/` | Utilidades de terminal |

`bootstrap/` no se enlaza: son scripts de instalación de un solo uso.
`templates/` tampoco: son plantillas que se copian al empezar un script nuevo.

## Instalación en una máquina nueva

```bash
git clone https://github.com/fran-cisko/dotfiles.git ~/dotfiles
cd ~/dotfiles
sudo dnf install stow        # Nobara/Fedora
./install.sh --dry-run       # ver qué haría
./install.sh                 # aplicar
```

## Scripts

| Comando | Qué hace |
|---|---|
| `anki-update` | Actualiza Anki en `~/.local` sin sudo, verificando SHA256 |
| `cambiar-texto-md` | Reemplaza texto en archivos `.md` (simula por defecto) |
| `libro-a-md` | Convierte un PDF a Markdown para Obsidian (Docling) |
| `paste-handy` | Pega texto en Wayland con `wl-copy` + `ydotool` |
| `oracle-apply` | Reintenta el apply de un stack de Oracle hasta tener capacidad |
| `vault-backup` | Backup con restic de la bóveda a Shadow Drive (`init`, `backup`, `prune`, `check`, `restore`) |

## Backup de la bóveda

`vault-backup` usa **restic** sobre el remote `shadow:` de rclone (Shadow Drive),
con snapshots incrementales, deduplicación y cifrado en cliente.

Shadow Drive autentica cada petición en ~25 s, así que el script levanta
`rclone --use-cookies serve restic` en un puerto local y restic habla por HTTP
con 8 conexiones: la primera petición paga la autenticación y el resto
reutilizan la cookie de sesión (~0,7 s). Backup completo: 12 min 40 s.
Incremental: ~40 s.

```bash
vault-backup init                                  # una sola vez
vault-backup backup                                # snapshot manual
vault-backup snapshots                             # ver qué hay
vault-backup restore /tmp/restaurado latest        # recuperar
vault-backup restore /tmp/x latest --include '/home/cisco/Documents/My_Obsidian_Vault/350_Automatizations/docs'
vault-backup check                                 # verificar integridad
vault-backup forget <id> --prune                   # borrar un snapshot y sus datos
vault-backup unlock --remove-all                   # limpiar locks huérfanos
```

Automatizado con tres timers de usuario: backup diario (03:15), retención
semanal (`forget --prune`) y verificación mensual.

| Archivo | Dónde | Se versiona |
|---|---|---|
| `excludes.txt` | `~/.config/restic/` | sí |
| `vault.pass` | `~/.config/restic/` | **no** (copia en tu gestor de contraseñas) |

Si pierdes `vault.pass`, el backup es irrecuperable.

## Plantillas

| Plantilla | Para qué |
|---|---|
| `templates/bash/script.sh` | Utilidades de terminal en Bash |
| `templates/python-cli/cli.py` | CLIs en Python (PEP 723, ejecutables con `uv`) |

```bash
cp ~/dotfiles/templates/bash/script.sh ~/.local/bin/mi-script
cp ~/dotfiles/templates/python-cli/cli.py ./mi-cli.py
```

Incluyen `--help`, validación de argumentos y códigos de salida. No se enlazan
con Stow.

## Bootstrap

```bash
./bootstrap/instalar-gentelman-nobara.sh
./bootstrap/instalar-gentelman-debian.sh
```

## Añadir un paquete

```bash
mkdir -p ~/dotfiles/nvim/.config/nvim
mv ~/.config/nvim/init.lua ~/dotfiles/nvim/.config/nvim/init.lua
cd ~/dotfiles && stow nvim
```

## Deshacer

```bash
cd ~/dotfiles
stow -D scripts      # borra los symlinks, no los archivos del repo
```
