#!/bin/sh

TIMEZONE_FILE="/mnt/SDCARD/spruce/config/timezone_offset"

check_timezone() {
    if [ -f "$TIMEZONE_FILE" ]; then
        cat "$TIMEZONE_FILE"
    else
        echo "UTC0"
    fi
}

set_timezone() {
    timezone="$1"
    case "$timezone" in
        UTC0)  echo "0" > "$TIMEZONE_FILE" ;;
        UTC+*) echo "${timezone#UTC+}" > "$TIMEZONE_FILE" ;;
        UTC-*) echo "-${timezone#UTC-}" > "$TIMEZONE_FILE" ;;
        *)     echo "Invalid timezone: $timezone" >&2; exit 1 ;;
    esac
}

if [ "$1" = "check" ]; then
    check_timezone
elif [ -n "$1" ]; then
    set_timezone "$1"
else
    echo "Usage: $0 [check|UTC0|UTC+n|UTC-n]"
    exit 1
fi
