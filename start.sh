#!/bin/bash

rm -f /tmp/.X99-lock

echo "[start] Starting Xvfb on $DISPLAY"
Xvfb "$DISPLAY" -screen 0 1280x720x24 -ac +extension GLX +render -noreset &
for i in $(seq 1 20); do
    if xdpyinfo -display "$DISPLAY" >/dev/null 2>&1; then
        echo "[start] Xvfb ready after ${i}s"
        break
    fi
    sleep 1
done

echo "[start] Starting Boterdrop Solver on port ${PORT:-8080}..."
exec python api_server.py
