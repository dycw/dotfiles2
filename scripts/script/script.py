#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.14"
# dependencies = [
#   "click >=8.3.1, <8.4",
#   "dycw-utilities >=0.174.19, <0.175",
#   "typed-settings[attrs, click] >=25.3.0, <25.4",
# ]
# ///

from __future__ import annotations

from logging import getLogger
from pathlib import Path
from typing import TYPE_CHECKING

from click import command, option
from utilities.click import CONTEXT_SETTINGS
from utilities.logging import basic_config
from utilities.shutil import which
from utilities.subprocess import (
    apt_install_cmd,
    git_branch_current,
    git_checkout,
    git_clone,
    run,
    sudo_cmd,
)

if TYPE_CHECKING:
    from utilities.types import PathLike

basic_config(obj=__name__)
_LOGGER = getLogger(__name__)
_CLONE_LOCATION = Path.home() / "dotfiles-wip"


@command(**CONTEXT_SETTINGS)
@option("--branch", type=str, default=None, help="Branch to run")
def _main(*, branch: str | None = None) -> None:
    _LOGGER.info("Running 'DW-Swift' installer...")
    _install_curl()
    _install_git()
    _clone_repo(branch=branch)
    _LOGGER.info("Finished running 'DW-Swift' installer")


def _install_curl() -> None:
    if which("curl") is not None:
        _LOGGER.info("'curl' is already installed")
        return
    _LOGGER.info("Installing 'curl'...")
    run(*sudo_cmd(*apt_install_cmd("curl")))
    _LOGGER.info("Finished installing 'curl'")


def _install_git() -> None:
    if which("git") is not None:
        _LOGGER.info("'git' is already installed")
        return
    _LOGGER.info("Installing 'git'...")
    run(*sudo_cmd(*apt_install_cmd("git")))
    _LOGGER.info("Finished installing 'git'")


def _clone_repo(path: PathLike, /, *, branch: str | None = None) -> None:
    if _CLONE_LOCATION.is_dir():
        _LOGGER.info("Repo is already cloned to '%s'", _CLONE_LOCATION)
        _checkout_branch(_CLONE_LOCATION, branch=branch)
        return
    _LOGGER.info("Cloning to '%s'...", _CLONE_LOCATION)
    git_clone("git@github.com:dycw/dotfiles2.git", _CLONE_LOCATION, branch=branch)
    _LOGGER.info("Finished cloning to '%s'", _CLONE_LOCATION)


def _checkout_branch(path: PathLike, /, *, branch: str | None = None) -> None:
    if branch is None:
        return
    current = git_branch_current(path)
    if current == branch:
        _LOGGER.info("Branch '%s' is already checked out", branch)
        return
    _LOGGER.info("Checking out '%s'...", branch)
    git_checkout(branch, path)


if __name__ == "__main__":
    _main()
