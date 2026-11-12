# Plantillas

Scaffolds para empezar scripts nuevos sin reescribir la estructura base.
No se enlazan con Stow: se copian al proyecto o a `~/.local/bin/`.

| Plantilla | Para qué |
|---|---|
| `bash/script.sh` | Utilidades de terminal en Bash |
| `python-cli/cli.py` | CLIs en Python con dependencias declaradas (PEP 723) |

## Uso

```bash
# Bash
cp ~/dotfiles/templates/bash/script.sh ~/.local/bin/mi-script
chmod +x ~/.local/bin/mi-script

# Python (requiere uv)
cp ~/dotfiles/templates/python-cli/cli.py ./mi-cli.py
chmod +x ./mi-cli.py
./mi-cli.py --help
```

Después cambia el nombre, la descripción, el uso y los argumentos de la
plantilla. Ambas incluyen `--help`, validación básica y códigos de salida.
