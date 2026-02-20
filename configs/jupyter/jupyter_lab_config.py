from __future__ import annotations  # noqa: INP001

from contextlib import suppress

with suppress(NameError):
    c = get_config()  # type: ignore[reportIgnoreUndefinedVariable]  # noqa: F821
