from __future__ import annotations

from pathlib import Path

from utilities.importlib import files
from utilities.subprocess import ssh_keyscan, symlink

from dotfiles.logging import LOGGER

_CONFIGS = files("dotfiles") / "configs"


def setup_common() -> None:
    _setup_common_known_hosts()
    _setup_pdb()


def _setup_common_known_hosts() -> None:
    LOGGER.info("Adding 'github.com' to known hosts...")
    ssh_keyscan("github.com")


def _setup_pdb() -> None:
    LOGGER.info("Setting up 'pdb'...")
    symlink(_CONFIGS / "pdb/pdbrc", Path.home() / ".pdbrc")


__all__ = ["setup_common"]
