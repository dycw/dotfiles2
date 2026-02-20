#!/usr/bin/env sh

set -eu

###############################################################################

link() {
	mkdir -p "$(dirname -- "$2")"
	script_dir=$(cd -- "$(dirname -- "$0")" && pwd -P)
	ln -sfn "${script_dir}/$1" "${HOME}/.jupyter/$2"
}

###############################################################################

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Setting up 'jupyter'..."

link jupyter_lab_config.py jupyter_lab_config.py
link apputils/notification.jsonc lab/user-settings/@jupyterlab/apputils-extension/notification.jupyterlab-settings
link apputils/themes.jsonc lab/user-settings/@jupyterlab/apputils-extension/themes.jupyterlab-settings
link codemirror/plugin.jsonc lab/user-settings/@jupyterlab/codemirror-extension/plugin.jupyterlab-settings
link completer/manager.jsonc lab/user-settings/@jupyterlab/completer-extension/manager.jupyterlab-settings
link console/tracker.jsonc lab/user-settings/@jupyterlab/console-extension/tracker.jupyterlab-settings
link docmanager/plugin.jsonc lab/user-settings/@jupyterlab/docmanager-extension/plugin.jupyterlab-settings
link filebrowser/browser.jsonc lab/user-settings/@jupyterlab/filebrowser-extension/browser.jupyterlab-settings
link fileeditor/plugin.jsonc lab/user-settings/@jupyterlab/fileeditor-extension/plugin.jupyterlab-settings
link jupyterlab_code_formatter/settings.jsonc lab/user-settings/jupyterlab_code_formatter/settings.jupyterlab-settings
link notebook/tracker.jsonc lab/user-settings/@jupyterlab/notebook-extension/tracker.jupyterlab-settings
link shortcuts/shortcuts.jsonc lab/user-settings/@jupyterlab/shortcuts-extension/shortcuts.jupyterlab-settings
