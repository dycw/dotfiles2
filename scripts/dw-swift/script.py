#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.14"
# dependencies = [
#   "click >=8.3.1, <8.4",
#   "dycw-utilities >=0.174.17, <0.175",
#   "typed-settings[attrs, click] >=25.3.0, <25.4",
# ]
# ///

from __future__ import annotations

from logging import getLogger
from pathlib import Path
from shutil import which

from click import command
from utilities.click import CONTEXT_SETTINGS
from utilities.subprocess import apt_install_cmd, git_clone_cmd, run, sudo_cmd

_LOGGER = getLogger(__name__)
_CLONE_LOCATION = Path.home() / "dotfiles-wip"


@command(**CONTEXT_SETTINGS)
def _main() -> None:
    _LOGGER.info("Running 'DW-Swift' installer...")
    _install_git()
    _clone_repo()
    _LOGGER.info("Finished running 'DW-Swift' installer")


def _install_git() -> None:
    if which("git") is not None:
        _LOGGER.info("'git' is already installed")
        return
    _LOGGER.info("Installing 'git'...")
    run(*sudo_cmd(*apt_install_cmd("git")))
    _LOGGER.info("Finished installing 'git'")


def _clone_repo() -> None:
    if _CLONE_LOCATION.is_dir():
        _LOGGER.info("Repo already cloned to '%s'", _CLONE_LOCATION)
        return
    _LOGGER.info("Cloning to '%s'...", _CLONE_LOCATION)
    run(*git_clone_cmd("git@github.com:dycw/dotfiles2.git", _CLONE_LOCATION))
    _LOGGER.info("Finished cloning to '%s'", _CLONE_LOCATION)


if __name__ == "__main__":
    _main()
