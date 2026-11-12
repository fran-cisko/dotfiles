# dotfiles

Configuración personal de la máquina, versionada con git y enlazada con GNU Stow.

## Contenido

| Paquete | Se enlaza a | Qué incluye |
|---|---|---|
| `bash` | `~/.bashrc` | Shell, PATH, alias |
| `scripts` | `~/.local/bin/` | Utilidades de terminal |

`bootstrap/` no se enlaza: son scripts de instalación de un solo uso.

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
| `obsidian-sync` | Abre Obsidian y sincroniza la bóveda con rclone al cerrar |
| `paste-handy` | Pega texto en Wayland con `wl-copy` + `ydotool` |
| `oracle-apply` | Reintenta el apply de un stack de Oracle hasta tener capacidad |

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
