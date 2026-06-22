#!/bin/bash

source display_info.sh

HOSTNAME=$(hostname)
TIMEZONE=$(timedatectl|grep "Time zone"|awk '{print $3, $4, $5}')
USER=$(whoami)
OS=$(awk 'BEGIN {ORS=" "} {print $1, $2, $3}' /etc/issue)
DATE=$(date "+%d %B %Y %T")
UPTIME=$(uptime -p)
UPTIME_SEC=$(awk '{print $1}' /proc/uptime)
IP=$(hostname -I | awk '{print $1}')
MASK=$(ifconfig|grep netmask|awk '{print $4}'|awk 'NR==1')
GATEWAY=$(ip route | awk '{print $3}' | head -n 1)
RAM_TOTAL=$(free -m | awk '/Mem:/ {printf "%.3f GB", $2/1024}')
RAM_USED=$(free -m | awk '/Mem:/ {printf "%.3f GB", $3/1024}')
RAM_FREE=$(free -m | awk '/Mem:/ {printf "%.3f GB", $4/1024}')
SPACE_ROOT=$(df -h / | awk '/\// {printf "%.2f MB", $2*1024}')
SPACE_ROOT_USED=$(df -h / | awk '/\// {printf "%.2f MB", $3*1024}')
SPACE_ROOT_FREE=$(df -h / | awk '/\// {printf "%.2f MB", $4*1024}')

display_info

read -p "Do you want to save this information to a file? (y/n) " choice
if [[ "$choice" == "Y" || "$choice" == "y" ]]; then
    TIMESTAMP=$(date "+%d_%m_%y_%H_%M_%S")
    FILENAME="${TIMESTAMP}.status"
    {
        display_info
    } > "$FILENAME"
    echo "The data is saved to a file $FILENAME"
else
    echo "The data is not saved"
fi