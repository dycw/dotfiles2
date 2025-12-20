#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.14"
# dependencies = [
#   "click >= 8.3.1, < 8.4",
#   "dycw-utilities >= 0.170.1, < 0.172",
#   "pytest-xdist >= 3.8.0, < 3.9",
#   "pyyaml >= 6.0.3, < 6.1",
#   "rich >= 14.2.0, < 14.3",
#   "tomlkit >= 0.13.3, < 0.14",
#   "typed-settings[attrs, click] >= 25.3.0, < 25.4",
#   "xdg-base-dirs >= 6.0.2, < 6.1",
# ]
# ///

from __future__ import annotations

import json
import sys
from contextlib import contextmanager, suppress
from contextvars import ContextVar
from logging import getLogger
from pathlib import Path
from re import escape, search
from string import Template
from subprocess import CalledProcessError, check_call, check_output
from typing import TYPE_CHECKING, Any, Literal, assert_never
from string import Template
import tomlkit
import yaml
from click import command
from rich.pretty import pretty_repr
from tomlkit import TOMLDocument, aot, array, document, table
from tomlkit.exceptions import NonExistentKey
from tomlkit.items import AoT, Array, Table
from typed_settings import EnvLoader, click_options, option, settings
from utilities.atomicwrites import writer
from utilities.click import CONTEXT_SETTINGS
from utilities.functions import ensure_class
from utilities.iterables import OneEmptyError, OneNonUniqueError, one
from shutil import which
from utilities.logging import basic_config
from utilities.pathlib import get_repo_root
from utilities.tempfile import TemporaryFile
from utilities.subprocess import run
from utilities.version import ParseVersionError, Version, parse_version
from utilities.whenever import HOUR, get_now
from whenever import ZonedDateTime
from xdg_base_dirs import xdg_cache_home

if TYPE_CHECKING:
    from collections.abc import Callable, Iterable, Iterator

    from tomlkit.container import Container
    from utilities.types import PathLike


type HasAppend = Array | list[Any]
type HasSetDefault = Container | StrDict | Table
type StrDict = dict[str, Any]
_LOGGER = getLogger(__name__)



@command(**CONTEXT_SETTINGS)
def _main()->None:
    _LOGGER.info("Running 'RH-MacBook' installer...")
    _install_bump_my_version()
    _install_pre_commit()
    _LOGGER.info("Finished running 'RH-MacBook' installer")


def _install_bump_my_version()->None:
    if which('bump-my-version') is None:
         _LOGGER.info("Installing 'bump-my-version'...")
         run('uv', 'tool', 'install', 'bump-my-version', print=True)
    else:
         _LOGGER.info("'pre-commit' is already installed")


def _install_pre_commit()->None:
    if which('pre-commit') is None:
         _LOGGER.info("Installing 'pre-commit'...")
         run('uv', 'tool', 'install', 'pre-commit', print=True)
    else:
         _LOGGER.info("'pre-commit' is already installed")


if __name__ == "__main__":
    basic_config(obj=__name__)
    _main()

################ utilities ####################

@contextmanager
def yield_github_latest_download(
    owner: str, repo: str, filename_template: str, /
) -> Iterator[Path]:
    tag = get_latest_tag(owner, repo)
    filename = Template(filename_template).substitute(
        tag=tag, tag_without_v=tag.lstrip("v")
    )
    url = f"https://github.com/{owner}/{repo}/releases/download/{tag}/{filename}"
    with yield_download(url) as temp_file:
        yield temp_file
