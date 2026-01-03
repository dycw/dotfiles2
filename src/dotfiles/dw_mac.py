from __future__ import annotations

from click import command
from utilities.click import CONTEXT_SETTINGS

from dotfiles.common import setup_common
from dotfiles.logging import LOGGER


@command(**CONTEXT_SETTINGS)
def _main() -> None:
    LOGGER.info("Running 'DW-MacMini' installer...")
    setup_common()
    LOGGER.info("Finished running 'DW-MacMini' installer")


if __name__ == "__main__":
    _main()
