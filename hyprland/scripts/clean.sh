#!/bin/bash

echo "### Temporary File Space Estimator ###"
echo

# Variable to accumulate total reclaimable space in megabytes (MB)
total_reclaimable_space=0

# Function to check space usage of a directory and accumulate reclaimable space
check_space() {
    dir=$1
    # Check if the directory exists and is readable
    if [ -d "$dir" ] && [ -r "$dir" ]; then
        size=$(du -sh "$dir" 2>/dev/null | awk '{print $1}')
        # Convert size to MB for easier accumulation
        size_in_mb=$(du -sm "$dir" 2>/dev/null | awk '{print $1}')
        total_reclaimable_space=$((total_reclaimable_space + size_in_mb))
        echo "$dir: $size"
    elif [ -d "$dir" ]; then
        echo "$dir: Directory exists but is not readable."
    else
        echo "$dir: Directory not found."
    fi
}

# 1. Check the size of common temporary directories
echo "Checking the size of common temporary directories..."
check_space "/tmp"
check_space "/var/tmp"
check_space "/home/$USER/.cache"
check_space "/var/cache/pacman/pkg"
check_space "/var/log"

# 2. Check for orphaned packages (packages no longer needed)
echo
echo "Checking for orphaned packages (no longer needed)..."
orphaned_packages=$(pacman -Qdtq)
if [ -n "$orphaned_packages" ]; then
    orphaned_size=$(pacman -Qdtq | xargs pacman -Qi | awk '/Installed Size/ {s+=$3} END {print s}')
    total_reclaimable_space=$((total_reclaimable_space + orphaned_size))
    echo "Orphaned packages (can be removed): $orphaned_size MB"
else
    echo "No orphaned packages found."
fi

# 3. Estimate space that can be freed by cleaning the package cache (pacman)
echo
echo "Checking pacman package cache..."
package_cache_size=$(du -sh /var/cache/pacman/pkg 2>/dev/null | awk '{print $1}')
package_cache_size_mb=$(du -sm /var/cache/pacman/pkg 2>/dev/null | awk '{print $1}')
if [ -n "$package_cache_size" ]; then
    total_reclaimable_space=$((total_reclaimable_space + package_cache_size_mb))
    echo "Pacman package cache size: $package_cache_size"
else
    echo "/var/cache/pacman/pkg: Directory not accessible or empty."
fi

# 4. Clean up old log files (journal logs)
echo
echo "Checking system journal logs..."
log_size=$(journalctl --disk-usage 2>/dev/null | awk '{print $3 " " $4}')
log_size_mb=$(journalctl --disk-usage 2>/dev/null | awk '{print $3}')
if [ -n "$log_size" ]; then
    total_reclaimable_space=$((total_reclaimable_space + log_size_mb))
    echo "Current journal log size: $log_size."
   
else
    echo "Journal logs are not accessible or empty."
fi

# Print total reclaimable space
echo
echo "### Total Reclaimable Space ###"
echo "Total reclaimable space (from temp files, caches, orphaned packages, etc.):"
echo "$total_reclaimable_space MB"

# Prompt for cleanup
echo
read -p "Do you want to clean up the reclaimable space? (y/n): " cleanup_choice

# If user confirms, clean up the reclaimable space
if [[ "$cleanup_choice" == "y" || "$cleanup_choice" == "Y" ]]; then
    echo "Cleaning up reclaimable space..."

    # Clean up pacman cache (needs sudo)
    if [ $(id -u) -eq 0 ]; then
        yes | sudo pacman -Scc
    else
        echo "You need root (sudo) privileges to clean up pacman cache."
    fi

    # Clean up orphaned packages (needs sudo)
    if [ $(id -u) -eq 0 ]; then
        sudo pacman -Rns $(pacman -Qdtq) --noconfirm
    else
        echo "You need root (sudo) privileges to remove orphaned packages."
    fi

    # Clean up system logs (needs sudo)
    if [ $(id -u) -eq 0 ]; then
        sudo journalctl --vacuum-time=3days
    else
        echo "You need root (sudo) privileges to clean up system logs."
    fi

    # Clean user-level cache (no sudo needed)
    rm -rf ~/.cache/*

    # Clean temporary files
    rm -rf /tmp/*
    rm -rf /var/tmp/*

    echo "Cleanup complete."
else
    echo "Cleanup aborted. No files were deleted."
fi

