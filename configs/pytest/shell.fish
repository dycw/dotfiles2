#!/usr/bin/env fish

if not status is-interactive; or not type -q ghostty
    exit
end

###############################################################################

function pyt
    __pytest $argv
end

function pytf
    __pytest --looponfail $argv
end

function pytfk
    if test (count $argv) -lt 1
        echo "'pytfk' expected [1..) arguments EXPRESSION; got $(count $argv)" >&2; and return 1
    end
    __pytest --looponfail -k $argv
end

function pytfn
    __pytest --looponfail --numprocesses auto $argv
end

function pytfnr
    __pytest --force-regen --looponfail --numprocesses auto $argv
end

function pytfnx
    __pytest -x --looponfail --numprocesses auto $argv
end

function pytfr
    __pytest --force-regen --looponfail $argv
end

function pytfx
    __pytest --exitfirst --looponfail $argv
end

function pytfxk
    if test (count $argv) -lt 1
        echo "'pytfxk' expected [1..) arguments EXPRESSION; got $(count $argv)" >&2; and return 1
    end
    __pytest --exitfirst --looponfail -k $argv
end

function pytk
    if test (count $argv) -lt 1
        echo "'pytk' expected [1..) arguments EXPRESSION; got $(count $argv)" >&2; and return 1
    end
    __pytest -k $argv
end

function pytn
    __pytest --numprocesses auto $argv
end

function pytnk
    if test (count $argv) -lt 1
        echo "'pytnk' expected [1..) arguments EXPRESSION; got $(count $argv)" >&2; and return 1
    end
    __pytest --numprocesses auto -k $argv
end

function pytnr
    __pytest --force-regen --numprocesses auto $argv
end

function pytnx
    __pytest --exitfirst --numprocesses auto $argv
end

function pytp
    __pytest --pdb $argv
end

function pytpk
    if test (count $argv) -lt 1
        echo "'pytpk' expected [1..) arguments EXPRESSION; got $(count $argv)" >&2; and return 1
    end
    __pytest --pdb -k $argv
end

function pytpx
    __pytest --exitfirst --pdb $argv
end

function pytpxk
    if test (count $argv) -lt 1
        echo "'pytpxk' expected [1..) arguments EXPRESSION; got $(count $argv)" >&2; and return 1
    end
    __pytest --exitfirst --pdb -k $argv
end

function pytr
    __pytest --force-regen $argv
end

function pytx
    __pytest --exitfirst $argv
end

function pytxk
    if test (count $argv) -lt 1
        echo "'pytxk' expected [1..) arguments EXPRESSION; got $(count $argv)" >&2; and return 1
    end
    __pytest --exitfirst -k $argv
end

function __pytest
    pytest --color=yes $argv
end
