# ruff: noqa: INP001


from __future__ import annotations

config = get_config()  # type: ignore[] # noqa: F821

# ------------------------------------------------------------------------------
# InteractiveShellApp(Configurable) configuration
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# Application(SingletonConfigurable) configuration
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# BaseIPythonApplication(Application) configuration
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# TerminalIPythonApp(BaseIPythonApplication, InteractiveShellApp) configuration
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# InteractiveShell(SingletonConfigurable) configuration
# ------------------------------------------------------------------------------
config.InteractiveShell.ast_node_interactivity = "all"
config.InteractiveShell.autocall = 1
config.InteractiveShell.autoindent = True
config.InteractiveShell.automagic = True
config.InteractiveShell.show_rewritten_input = True

# ------------------------------------------------------------------------------
# TerminalInteractiveShell(InteractiveShell) configuration
# ------------------------------------------------------------------------------
config.TerminalInteractiveShell.confirm_exit = False
config.TerminalInteractiveShell.editing_mode = "vi"
config.TerminalInteractiveShell.highlight_matching_brackets = True
config.TerminalInteractiveShell.prompt_includes_vi_mode = True

# ------------------------------------------------------------------------------
# HistoryAccessor(HistoryAccessorBase) configuration
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# HistoryManager(HistoryAccessor) configuration
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# ProfileDir(LoggingConfigurable) configuration
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# BaseFormatter(Configurable) configuration
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# PlainTextFormatter(BaseFormatter) configuration
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# Completer(Configurable) configuration
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# IPCompleter(Completer) configuration
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# ScriptMagics(Magics) configuration
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# LoggingMagics(Magics) configuration
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# StoreMagics(Magics) configuration
# ------------------------------------------------------------------------------
