#!/bin/bash
# Dynamic per-core CPU usage display for waybar.
# Automatically adapts to any number of cores.

icons=("▁" "▂" "▃" "▄" "▅" "▆" "▇" "█")

# Read CPU stats, skip the aggregate "cpu" line, get per-core lines.
read_cpu_stats() {
    grep '^cpu[0-9]' /proc/stat
}

# Calculate usage per core by comparing two samples.
get_usage() {
    local stats1=$(read_cpu_stats)
    sleep 0.1
    local stats2=$(read_cpu_stats)

    local output=""
    local total_usage=0
    local core_count=0

    while IFS= read -r line1 && IFS= read -r line2 <&3; do
        # Parse: cpu0 user nice system idle iowait irq softirq steal guest guest_nice
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

        output+="${icons[$icon_idx]}"
        total_usage=$((total_usage + usage))
        core_count=$((core_count + 1))
    done <<< "$stats1" 3<<< "$stats2"

    # Calculate average.
    if [ "$core_count" -gt 0 ]; then
        local avg=$((total_usage / core_count))
    else
        local avg=0
    fi

    # Output JSON for waybar custom module.
    printf '{"text": "%s %2d%%", "tooltip": "CPU: %d cores, %d%% avg", "class": "cpu"}\n' "$output" "$avg" "$core_count" "$avg"
}

get_usage
