#!/usr/bin/env sh

# echo
echo_date() { echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*" >&2; }

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
    --*)
        echo_date "Unknown option: $1" && exit 1
        ;;
    *)
        echo_date "Unexpected argument: $1" && exit 1
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
    PATH="${LOCAL_BIN}${PATH:+:${PATH}}" ./scripts/dw-swift/script.py ${BRANCH:+--branch "$BRANCH"}
    echo_date "Finished running installer for 'DW-Swift'..."
    ;;
RH-MacBook)
    echo_date "This is 'RH-MacBook'; running installer for 'RH-MacBook'..."
    ./scripts/setup-uv.sh
    PATH="${LOCAL_BIN}${PATH:+:${PATH}}" ./scripts/rh-macbook/script.py ${BRANCH:+--branch "$BRANCH"}
    echo_date "Finished running installer for 'RH-MacBook'..."
    ;;
*)
    echo_date "Unknown hostname '$(hostname)'; exiting..." && exit 1
    ;;
esac
