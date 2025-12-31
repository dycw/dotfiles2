#!/usr/bin/env sh

# echo
echo_date() { echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*" >&2; }

# defaults and usage

HOSTNAME_USE="$(hostname)"
PATH_USE="${HOME}/dotfiles"

echo_usage() {
    cat >&2 <<EOF
Usage: $0 [--hostname <str>] [--path <path>] [--branch <str>]

Options:
  --hostname <str>  Hostname to use (default: ${HOSTNAME_USE})
  --path <path>     Path to clone to (default: ${PATH_USE})
  --branch <str>    Branch to use
  -h, --help        Show this help and exit
EOF
}

# parse arguments
HOSTNAME_USE="$(hostname)"
PATH_USE="${HOME}/dotfiles"
BRANCH=""
while [ "$#" -gt 0 ]; do
    case "$1" in
    --hostname)
        shift
        if [ "$#" -eq 0 ]; then
            echo_date "--hostname requires an argument" && exit 1
        fi
        HOSTNAME_USE="$1"
        ;;
    --path)
        shift
        if [ "$#" -eq 0 ]; then
            echo_date "--path requires an argument" && exit 1
        fi
        PATH_USE="$1"
        ;;
    --branch)
        shift
        if [ "$#" -eq 0 ]; then
            echo_date "--branch requires an argument" && exit 1
        fi
        BRANCH="$1"
        ;;
    -h | --help)
        echo_usage
        exit 0
        ;;
    *)
        echo_date "Invalid argument '$1'; exiting.."
        echo_usage
        exit 1
        ;;
    esac
    shift
done

# main
echo_date "Running installer..."
LOCAL_BIN="${HOME}/.local/bin"
case "${HOSTNAME_USE}" in
DW-Swift | RH-MacBook)
    echo_date "Running installer for '${HOSTNAME_USE}'..."
    ./scripts/setup-uv.sh
    HOSTNAME_LOWER=$(printf '%s' "${HOSTNAME_USE}" | tr '[:upper:]' '[:lower:]')
    PATH="${LOCAL_BIN}${PATH:+:${PATH}}" ./scripts/script.py \
        "${HOSTNAME_LOWER}" \
        ${PATH_USE:+--path "${PATH_USE}"} \
        ${BRANCH:+--branch "${BRANCH}"}
    echo_date "Finished running installer for '${HOSTNAME_USE}'..."
    ;;
*)
    echo_date "Invalid hostname '${HOSTNAME_USE}'; exiting..." && exit 1
    ;;
esac
