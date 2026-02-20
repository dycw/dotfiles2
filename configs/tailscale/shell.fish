#!/usr/bin/env fish

if not status is-interactive
    exit
end

#### auth key #################################################################

if set -q XDG_CONFIG_HOME
    export TAILSCALE_AUTH_KEY=$XDG_CONFIG_HOME/tailscale/auth-key.txt
else
    export TAILSCALE_AUTH_KEY=$HOME/.config/tailscale/auth-key.txt
end

#### ssh #####################################################################

function ssh-dw-mac
    ssh-auto derekwan@(ts-ip dw-mac)
end

function ssh-dw-swift
    ssh-auto derek@(ts-ip dw-swift)
end

function ssh-rh-mac
    ssh-auto derekwan@(ts-ip rh-mac)
end

function ssh-rh-macbook
    ssh-auto derekwan@(ts-ip rh-macbook)
end

function ts
    set -l args
    if not type -q tailscale; and type -q docker
        set args $args docker exec --interactive tailscale
    end
    set args $args tailscale status
    $args
end

function ts-exit-node
    set -l args
    if not type -q tailscale; and type -q docker
        set args $args docker exec --interactive tailscale
    end
    set args $args tailscale set --exit-node=qrt-nanode
    $args
end

function ts-ip
    if test (count $argv) -lt 1
        echo "'ts-ip' expected [1..) arguments HOSTNAME; got $(count $argv)" >&2; and return 1
    end
    set -l args
    if not type -q tailscale; and type -q docker
        set args $args docker exec --interactive tailscale
    end
    set args $args tailscale status --json
    $args 2>/dev/null \
        | jq .Peer \
        | jq values[] \
        | jq --arg hostname $argv[1] 'select(.HostName | ascii_downcase == ($hostname | ascii_downcase))' \
        | jq .TailscaleIPs[] \
        | jq 'select(contains("."))' \
        | jq --slurp --raw-output first
end

function ts-no-exit-node
    set -l args
    if not type -q tailscale; and type -q docker
        set args $args docker exec --interactive tailscale
    end
    set args $args tailscale set --exit-node=
    $args
end

function wts
    set -l args
    if not type -q tailscale; and type -q docker
        set args $args docker exec --interactive tailscale
    end
    set args $args watch --color --differences --interval=1 -- tailscale status
    $args
end
