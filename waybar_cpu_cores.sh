#!/bin/bash
# Dynamic per-core CPU usage display for waybar with scrolling history.
# Automatically adapts to any number of cores.

icons=("▁" "▂" "▃" "▄" "▅" "▆" "▇" "█")
HISTORY_FILE="/tmp/waybar_cpu_history_${USER}"
HISTORY_LENGTH=60  # Keep 60 seconds of history.

# Read CPU stats, skip the aggregate "cpu" line, get per-core lines.
read_cpu_stats() {
    grep '^cpu[0-9]' /proc/stat
}

# Calculate usage per core by comparing two samples.
get_usage() {
    local stats1=$(read_cpu_stats)
    sleep 0.1
    local stats2=$(read_cpu_stats)

    local cores_output=""
    local total_usage=0
    local core_count=0

    while IFS= read -r line1 && IFS= read -r line2 <&3; do
        # Parse: cpu0 user nice system idle iowait irq softirq steal guest guest_nice.
        read -r _ user1 nice1 system1 idle1 iowait1 irq1 softirq1 steal1 _ _ <<< "$line1"
        read -r _ user2 nice2 system2 idle2 iowait2 irq2 softirq2 steal2 _ _ <<< "$line2"

        # Calculate deltas.
        local idle_delta=$((idle2 - idle1 + iowait2 - iowait1))
        local total_delta=$((user2 - user1 + nice2 - nice1 + system2 - system1 + idle2 - idle1 + iowait2 - iowait1 + irq2 - irq1 + softirq2 - softirq1 + steal2 - steal1))

        if [ "$total_delta" -gt 0 ]; then
            local usage=$(( (total_delta - idle_delta) * 100 / total_delta ))
        else
            local usage=0
        fi

        # Map usage (0-100) to icon index (0-7).
        local icon_idx=$(( usage * 8 / 101 ))
        [ "$icon_idx" -gt 7 ] && icon_idx=7

        cores_output+="${icons[$icon_idx]}"
        total_usage=$((total_usage + usage))
        core_count=$((core_count + 1))
    done <<< "$stats1" 3<<< "$stats2"

    # Calculate average.
    if [ "$core_count" -gt 0 ]; then
        local avg=$((total_usage / core_count))
    else
        local avg=0
    fi

    # Update history buffer.
    local history=""
    if [ -f "$HISTORY_FILE" ]; then
        history=$(cat "$HISTORY_FILE")
    fi

    # Initialize with flatline if empty or too short.
    if [ ${#history} -lt $HISTORY_LENGTH ]; then
        local needed=$((HISTORY_LENGTH - ${#history}))
        local flatline=$(printf '%*s' "$needed" | tr ' ' "${icons[0]}")
        history="${flatline}${history}"
    fi

    # Map avg to icon for history.
    local avg_icon_idx=$(( avg * 8 / 101 ))
    [ "$avg_icon_idx" -gt 7 ] && avg_icon_idx=7

    # Append new sample to history.
    history="${history}${icons[$avg_icon_idx]}"

    # Trim history to HISTORY_LENGTH characters.
    if [ ${#history} -gt $HISTORY_LENGTH ]; then
        history="${history: -$HISTORY_LENGTH}"
    fi

    # Save history back to file.
    echo -n "$history" > "$HISTORY_FILE"

    # Build history display.
    local history_output="$history"

    # Output JSON for waybar custom module.
    printf '{"text": "%s  %s %2d%%", "tooltip": "CPU: %d cores, %d%% avg\\nHistory: %d seconds", "class": "cpu"}\n' \
        "$cores_output" "$history_output" "$avg" "$core_count" "$avg" "${#history}"
}

get_usage
