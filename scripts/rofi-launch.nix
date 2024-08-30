{ pkgs }:

pkgs.writeShellScriptBin "rofi-launch" ''
    #!/usr/bin/env bash
    if pgrep -x "rofi" > /dev/null; then
        # Rofi is running, kill it
        pkill -x rofi
        exit 0
    fi
    rofi -show drun
''
