#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.12"
# dependencies = [
#   "click >=8.3.1, <8.4",
#   "dycw-utilities >=0.174.20, <0.175",
# ]
# ///

from __future__ import annotations

from logging import getLogger
from pathlib import Path
from typing import TYPE_CHECKING

import click
from click import group, option
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
    uv_run_cmd,
)

if TYPE_CHECKING:
    from utilities.types import PathLike

basic_config(obj=__name__)
_LOGGER = getLogger(__name__)


# CLI


_PATH_DEFAULT = Path.home() / "dotfiles"
_PATH_OPTION = option(
    "--path",
    type=click.Path(path_type=Path),
    default=_PATH_DEFAULT,
    help="Path to clone to",
)
_BRANCH_OPTION = option("--branch", type=str, default=None, help="Branch to use")


@group(**CONTEXT_SETTINGS)
def _main() -> None: ...


@_main.command(name="dw-swift", **CONTEXT_SETTINGS)
@_PATH_OPTION
@_BRANCH_OPTION
def dw_swift_sub_cmd(*, path: Path = _PATH_DEFAULT, branch: str | None = None) -> None:
    _LOGGER.info("Running 'DW-Swift' installer...")
    _install_curl()
    _install_git()
    _run_git_clone(path, branch=branch)
    run(*uv_run_cmd("dotfiles.dw_swift"), cwd=path)
    _LOGGER.info("Finished running 'DW-Swift' installer")


@_main.command(name="rh-macbook", **CONTEXT_SETTINGS)
@_PATH_OPTION
@_BRANCH_OPTION
def rh_macbook_sub_cmd(
    *, path: Path = _PATH_DEFAULT, branch: str | None = None
) -> None:
    _LOGGER.info("Running 'RH-MacBook' installer...")
    _run_git_clone(path, branch=branch)
    run(*uv_run_cmd("dotfiles.rh_macbook"), cwd=path)
    _LOGGER.info("Finished running 'RH-MacBook' installer")


# utilities


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


def _run_git_clone(path: PathLike, /, *, branch: str | None = None) -> None:
    path = Path(path)
    if path.is_dir():
        _LOGGER.info("Repo is already cloned to '%s'", path)
        _run_git_checkout(path, branch=branch)
        return
    _LOGGER.info("Cloning to '%s'...", path)
    git_clone("git@github.com:dycw/dotfiles2.git", path, branch=branch)
    _LOGGER.info("Finished cloning to '%s'", path)


def _run_git_checkout(path: PathLike, /, *, branch: str | None = None) -> None:
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
