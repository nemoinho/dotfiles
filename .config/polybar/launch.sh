#!/bin/bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use
# polybar-msg cmd quit

# Launch Polybar on each monitor, using default config location (~/.config/polybar/config)
for m in $(polybar --list-monitors | cut -d: -f1)
do
    MONITOR=$m polybar felix 2>&1 >> /tmp/polybar-$m.log &
done

# detach all running polybar-jobs from the current shell
disown -a

echo "Polybar launched..."
