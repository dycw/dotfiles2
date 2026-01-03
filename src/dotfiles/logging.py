from __future__ import annotations

from logging import getLogger

from utilities.logging import basic_config

LOGGER = getLogger("dotfiles")
basic_config(obj=LOGGER)


__all__ = ["LOGGER"]
