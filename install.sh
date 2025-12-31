#!/usr/bin/env sh

# echo
echo_date() { echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*" >&2; }

echo_usage() {
    cat >&2 <<EOF
Usage: $0 [--branch <name>]

Options:
  --branch <name>   Use the specified branch
  -h, --help        Show this help and exit
EOF
}

# parse arguments
BRANCH=""
while [ "$#" -gt 0 ]; do
    case "$1" in
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
        echo_date "Unknown argument: $1"
        echo_usage
        entry 2
        ;;
    esac
    shift
done

# main
echo_date "Running installer..."
LOCAL_BIN="${HOME}/.local/bin"
case "$(hostname)" in
DW-Swift)
    echo_date "This is 'DW-Swift'; running installer for 'DW-Swift'..."
    ./scripts/setup-uv.sh
    PATH="${LOCAL_BIN}${PATH:+:${PATH}}" ./scripts/script.py \
        DW-Swift \
        ${BRANCH:+--branch "$BRANCH"}
    echo_date "Finished running installer for 'DW-Swift'..."
    ;;
RH-MacBook)
    echo_date "This is 'RH-MacBook'; running installer for 'RH-MacBook'..."
    ./scripts/setup-uv.sh
    PATH="${LOCAL_BIN}${PATH:+:${PATH}}" ./scripts/script.py ${BRANCH:+--branch "$BRANCH"}
    echo_date "Finished running installer for 'RH-MacBook'..."
    ;;
*)
    echo_date "Unknown hostname '$(hostname)'; exiting..." && exit 1
    ;;
esac
