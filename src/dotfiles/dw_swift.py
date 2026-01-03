from __future__ import annotations

from click import command
from utilities.click import CONTEXT_SETTINGS

from dotfiles.logging import LOGGER


@command(**CONTEXT_SETTINGS)
def _main() -> None:
    LOGGER.info("Running 'DW-Swift' installer...")
    LOGGER.info("Finished running 'DW-Swift' installer")


if __name__ == "__main__":
    _main()
