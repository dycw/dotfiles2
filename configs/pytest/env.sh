#!/usr/bin/env sh

set -eu
if ! case $- in *i*) true ;; *) false ;; esac then
	exit 0
fi

###############################################################################

export PY_COLORS='1'
