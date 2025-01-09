#!/bin/bash
echo "### Temporary File Space Estimator ###"
echo
total_reclaimable_space=0
check_space() {
    dir=$1
    if [ -d "$dir" ] && [ -r "$dir" ]; then
        size=$(du -sh "$dir" 2>/dev/null | awk '{print $1}')
        size_in_mb=$(du -sm "$dir" 2>/dev/null | awk '{print $1}')
        total_reclaimable_space=$((total_reclaimable_space + size_in_mb))
        echo "$dir: $size"
    elif [ -d "$dir" ]; then
        echo "$dir: Directory exists but is not readable."
    else
        echo "$dir: Directory not found."
    fi
}
echo "Checking the size of common temporary directories..."
check_space "/tmp"
check_space "/var/tmp"
check_space "/var/cache/pacman/pkg"
check_space "/var/log"
echo "Checking user cache directories..."
for user_home in $(awk -F: '$3 >= 1000 {print $6}' /etc/passwd); do
    if [ -d "$user_home/.cache" ]; then
        check_space "$user_home/.cache"
    fi
done
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
echo
echo "### Total Reclaimable Space ###"
echo "Total reclaimable space (from temp files, caches, orphaned packages, etc.):"
echo "$total_reclaimable_space MB"
echo
read -p "Do you want to clean up the reclaimable space? (y/n): " cleanup_choice
if [[ "$cleanup_choice" == "y" || "$cleanup_choice" == "Y" ]]; then
    echo "Cleaning up reclaimable space..."
    if [ $(id -u) -eq 0 ]; then
        yes | pacman -Scc
        pacman -Rns $(pacman -Qdtq) --noconfirm
        journalctl --vacuum-time=3days
    else
        echo "You need root privileges to clean system-level files."
    fi
    for user_home in $(awk -F: '$3 >= 1000 {print $6}' /etc/passwd); do
        if [ -d "$user_home/.cache" ]; then
            rm -rf "$user_home/.cache"/*
        fi
    done
    rm -rf /tmp/*
    rm -rf /var/tmp/*
    echo "Cleanup complete."
else
    echo "Cleanup aborted. No files were deleted."
fi
