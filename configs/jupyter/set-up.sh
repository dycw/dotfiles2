#!/usr/bin/env sh

set -eu
SCRIPT_DIR=$(cd -- "$(dirname -- "$0")" && pwd -P)

###############################################################################

link() {
	mkdir -p "$(dirname -- "$2")"
	ln -sfn "$1" "$2"
}

###############################################################################

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Setting up 'jupyter'..."

link "${SCRIPT_DIR}"/jupyter_lab_config.py \
	"${HOME}"/.jupyter/jupyter_lab_config.py
link "${SCRIPT_DIR}"/apputils/notification.jsonc \
	"${HOME}"/.jupyter/lab/user-settings/@jupyterlab/apputils-extension/notification.jupyterlab-settings
link "${SCRIPT_DIR}"/apputils/themes.jsonc \
	"${HOME}"/.jupyter/lab/user-settings/@jupyterlab/apputils-extension/themes.jupyterlab-settings
link "${SCRIPT_DIR}"/codemirror/plugin.jsonc \
	"${HOME}"/.jupyter/lab/user-settings/@jupyterlab/codemirror-extension/plugin.jupyterlab-settings
link "${SCRIPT_DIR}"/completer/manager.jsonc \
	"${HOME}"/.jupyter/lab/user-settings/@jupyterlab/completer-extension/manager.jupyterlab-settings
link "${SCRIPT_DIR}"/console/tracker.jsonc \
	"${HOME}"/.jupyter/lab/user-settings/@jupyterlab/console-extension/tracker.jupyterlab-settings
link "${SCRIPT_DIR}"/docmanager/plugin.jsonc \
	"${HOME}"/.jupyter/lab/user-settings/@jupyterlab/docmanager-extension/plugin.jupyterlab-settings
link "${SCRIPT_DIR}"/filebrowser/browser.jsonc \
	"${HOME}"/.jupyter/lab/user-settings/@jupyterlab/filebrowser-extension/browser.jupyterlab-settings
link "${SCRIPT_DIR}"/fileeditor/plugin.jsonc \
	"${HOME}"/.jupyter/lab/user-settings/@jupyterlab/fileeditor-extension/plugin.jupyterlab-settings
link "${SCRIPT_DIR}"/notebook/tracker.jsonc \
	"${HOME}"/.jupyter/lab/user-settings/@jupyterlab/notebook-extension/tracker.jupyterlab-settings
link "${SCRIPT_DIR}"/shortcuts/shortcuts.jsonc \
	"${HOME}"/.jupyter/lab/user-settings/@jupyterlab/shortcuts-extension/shortcuts.jupyterlab-settings
link "${SCRIPT_DIR}"/jupyterlab_code_formatter/settings.jsonc \
	"${HOME}"/.jupyter/lab/user-settings/jupyterlab_code_formatter/settings.jupyterlab-settings

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Finished setting up 'jupyter'"
