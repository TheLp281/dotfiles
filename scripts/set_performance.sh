echo "Current cpu state is:"
cat /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
for cpu in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do echo performance | sudo tee $cpu; done
