#!/bin/bash
# Per-CPU usage bar script for i3blocks
# Similar to waybar's CPU bar visualization

# Bar characters from empty to full
ICONS=("▁" "▂" "▃" "▄" "▅" "▆" "▇" "█")

# Get per-CPU usage from /proc/stat
cpu_data=$(grep '^cpu[0-9]' /proc/stat)

# Store current values
echo "$cpu_data" > /tmp/cpu_stat_$$

# If previous data exists, calculate usage
if [ -f /tmp/cpu_stat_prev ]; then
    output=""
    total_usage=0
    cpu_count=0
    
    while IFS= read -r line; do
        cpu_num=$(echo "$line" | awk '{print $1}' | sed 's/cpu//')
        curr_vals=$(echo "$line" | awk '{print $2,$3,$4,$5,$6,$7,$8}')
        prev_vals=$(grep "^cpu$cpu_num " /tmp/cpu_stat_prev | awk '{print $2,$3,$4,$5,$6,$7,$8}')
        
        if [ -n "$prev_vals" ]; then
            # Calculate CPU usage
            curr=($curr_vals)
            prev=($prev_vals)
            
            curr_idle=${curr[3]}
            prev_idle=${prev[3]}
            
            curr_total=0
            prev_total=0
            for val in "${curr[@]}"; do curr_total=$((curr_total + val)); done
            for val in "${prev[@]}"; do prev_total=$((prev_total + val)); done
            
            total_diff=$((curr_total - prev_total))
            idle_diff=$((curr_idle - prev_idle))
            
            if [ $total_diff -gt 0 ]; then
                usage=$((100 * (total_diff - idle_diff) / total_diff))
            else
                usage=0
            fi
            
            # Map usage to icon (0-100% -> 0-7 index)
            icon_idx=$((usage * 7 / 100))
            [ $icon_idx -gt 7 ] && icon_idx=7
            output+="${ICONS[$icon_idx]}"
            
            total_usage=$((total_usage + usage))
            cpu_count=$((cpu_count + 1))
        fi
    done <<< "$cpu_data"
    
    # Calculate average
    if [ $cpu_count -gt 0 ]; then
        avg_usage=$((total_usage / cpu_count))
    else
        avg_usage=0
    fi
    
    # Output format: [bars] avg%
    echo "$output ${avg_usage}%"
else
    echo "CPU --"
fi

# Move current to previous for next iteration
mv /tmp/cpu_stat_$$ /tmp/cpu_stat_prev
