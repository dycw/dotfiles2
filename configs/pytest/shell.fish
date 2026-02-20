if not status is-interactive; or not type -q ghostty
    exit
end

###############################################################################

function coverage
    open .coverage/html/index.html
end
