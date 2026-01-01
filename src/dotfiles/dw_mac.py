from __future__ import annotations

from logging import getLogger

from click import command
from utilities.click import CONTEXT_SETTINGS
from utilities.logging import basic_config

basic_config(obj=__name__)
_LOGGER = getLogger(__name__)


@command(**CONTEXT_SETTINGS)
def _main() -> None:
    _LOGGER.info("Running 'DW-MacMini' installer...")
    _LOGGER.info("Finished running 'DW-MacMini' installer")


if __name__ == "__main__":
    _main()
