#!/bin/bash

upower_path=$(upower -e | grep battery)
notified=0
prev_state=""
last_notify_time=0
interval=10

check_battery() {
  battery_pct=$(upower -i $upower_path | grep percentage | awk '{print int($2)}')
  state=$(upower -i $upower_path | grep state | awk '{print $2}')
  now=$(date +%s)

  if [[ "$state" != "$prev_state" ]]; then
    if [[ "$state" == "charging" ]]; then
      notify-send -u normal "Battery Status" "Battery is now charging."
    elif [[ "$state" == "discharging" ]]; then
      notify-send -u normal "Battery Status" "Battery is now discharging."
    fi
    prev_state=$state
  fi

  if [[ "$state" == "discharging" ]]; then
    if (( battery_pct <= 10 )); then
      if [[ $notified -ne 1 ]] || (( now - last_notify_time >= 20 )); then
        notify-send -u critical "Battery Alert" "Battery is critically low! ($battery_pct%)"
        zenity --warning --text="Battery is critically low! ($battery_pct%)" --title="Battery Alert"
        hyprctl notify 65535 5000 1 "Battery critically low! ($battery_pct%)"
        notified=1
        last_notify_time=$now
      fi
    elif (( battery_pct <= 20 )); then
      if [[ $notified -ne 2 ]] || (( now - last_notify_time >= 20 )); then
        notify-send -u normal "Battery Warning" "Battery is low! ($battery_pct%)"
        hyprctl notify 16776960 5000 2 "Battery low! ($battery_pct%)"  
        notified=2
        last_notify_time=$now
      fi
    else
      if [[ $notified -ne 0 ]]; then
        echo "Battery okay, resetting notification flag"
      fi
      notified=0
    fi
  else
    if [[ $notified -ne 0 ]]; then
      echo "Battery not discharging, resetting notification flag"
    fi
    notified=0
  fi
}

while true; do
  check_battery
  sleep $interval
done
