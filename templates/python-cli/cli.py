#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.11"
# dependencies = []
# ///
"""<descripción breve de qué hace la CLI>.

Uso:
    ./cli.py --help
    ./cli.py <ruta>
"""
from __future__ import annotations

import argparse
import logging
import sys
from pathlib import Path

log = logging.getLogger(__name__)


def parse_args(argv: list[str] | None = None) -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("path", type=Path, help="ruta de entrada")
    parser.add_argument(
        "-v", "--verbose", action="store_true", help="muestra detalles de depuración"
    )
    return parser.parse_args(argv)


def run(args: argparse.Namespace) -> int:
    if not args.path.exists():
        log.error("no existe: %s", args.path)
        return 1

    log.info("procesando %s", args.path)
    # --- lógica ---
    return 0


def main(argv: list[str] | None = None) -> int:
    args = parse_args(argv)
    logging.basicConfig(
        level=logging.DEBUG if args.verbose else logging.INFO,
        format="%(levelname)s: %(message)s",
    )
    try:
        return run(args)
    except KeyboardInterrupt:
        return 130


if __name__ == "__main__":
    sys.exit(main())
