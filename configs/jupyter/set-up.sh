#!/usr/bin/env sh

set -eu
if ! case $- in *i*) true ;; *) false ;; esac then
	exit 0
fi

###############################################################################

link() {
	mkdir -p "$(dirname -- "$2")"
	script_dir=$(cd -- "$(dirname -- "$0")" && pwd -P)
	ln -sfn "${script_dir}/$1" "$2"
}

###############################################################################

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Setting up 'jupyter'..."

link jupyter_lab_config.py "${HOME}/.jupyter/jupyter_lab_config.py"
link apputils/notification.jsonc "${HOME}/.jupyter/lab/user-settings/@jupyterlab/apputils-extension/notification.jupyterlab-settings"
link apputils/themes.jsonc "${HOME}/.jupyter/lab/user-settings/@jupyterlab/apputils-extension/themes.jupyterlab-settings"
link codemirror/plugin.jsonc "${HOME}/.jupyter/lab/user-settings/@jupyterlab/codemirror-extension/plugin.jupyterlab-settings"
link completer/manager.jsonc "${HOME}/.jupyter/lab/user-settings/@jupyterlab/completer-extension/manager.jupyterlab-settings"
link console/tracker.jsonc "${HOME}/.jupyter/lab/user-settings/@jupyterlab/console-extension/tracker.jupyterlab-settings"
link docmanager/plugin.jsonc "${HOME}/.jupyter/lab/user-settings/@jupyterlab/docmanager-extension/plugin.jupyterlab-settings"
link filebrowser/browser.jsonc "${HOME}/.jupyter/lab/user-settings/@jupyterlab/filebrowser-extension/browser.jupyterlab-settings"
link fileeditor/plugin.jsonc "${HOME}/.jupyter/lab/user-settings/@jupyterlab/fileeditor-extension/plugin.jupyterlab-settings"
link jupyterlab_code_formatter/settings.jsonc "${HOME}/.jupyter/lab/user-settings/jupyterlab_code_formatter/settings.jupyterlab-settings"
link notebook/tracker.jsonc "${HOME}/.jupyter/lab/user-settings/@jupyterlab/notebook-extension/tracker.jupyterlab-settings"
link shortcuts/shortcuts.jsonc "${HOME}/.jupyter/lab/user-settings/@jupyterlab/shortcuts-extension/shortcuts.jupyterlab-settings"
