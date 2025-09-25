#!/usr/bin/env bash

SRVPORT=4499

prerequisites() {
    if ! command -v /usr/games/cowsay >/dev/null 2>&1 || ! command -v /usr/games/fortune >/dev/null 2>&1; then
        echo "cowsay not installed! Install cowsay and fortune."
        exit 1
    fi
}

main() {
    prerequisites
    echo "Wisdom served on port=$SRVPORT..."

    while true; do
        # Listen for one connection at a time
        { 
            read request
            response="<pre>$(/usr/games/cowsay "$(/usr/games/fortune)")</pre>"
            printf "HTTP/1.1 200 OK\r\nContent-Length: %d\r\n\r\n%s" "${#response}" "$response"
        } | nc -l -p $SRVPORT -q 1
    done
}

main
