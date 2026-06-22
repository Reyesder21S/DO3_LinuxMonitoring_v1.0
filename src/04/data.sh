#!/bin/bash

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

print_system_info(){
  echo -e "${bg_title}${fg_title}HOSTNAME${RESET}=${bg_value}${fg_value}$HOSTNAME${RESET}"
  echo -e "${bg_title}${fg_title}TIMEZONE${RESET}=${bg_value}${fg_value}$TIMEZONE${RESET}"
  echo -e "${bg_title}${fg_title}USER${RESET}=${bg_value}${fg_value}$USER${RESET}"
  echo -e "${bg_title}${fg_title}OS${RESET}=${bg_value}${fg_value}$OS${RESET}"
  echo -e "${bg_title}${fg_title}DATE${RESET}=${bg_value}${fg_value}$DATE${RESET}"
  echo -e "${bg_title}${fg_title}UPTIME${RESET}=${bg_value}${fg_value}$UPTIME${RESET}"
  echo -e "${bg_title}${fg_title}UPTIME_SECONDS${RESET}=${bg_value}${fg_value}$UPTIME_SEC${RESET}"
  echo -e "${bg_title}${fg_title}IP${RESET}=${bg_value}${fg_value}$IP${RESET}"
  echo -e "${bg_title}${fg_title}MASK${RESET}=${bg_value}${fg_value}$MASK${RESET}"
  echo -e "${bg_title}${fg_title}GATEWAY${RESET}=${bg_value}${fg_value}$GATEWAY${RESET}"
  echo -e "${bg_title}${fg_title}RAM_TOTAL${RESET}=${bg_value}${fg_value}$RAM_TOTAL${RESET}"
  echo -e "${bg_title}${fg_title}RAM_USED${RESET}=${bg_value}${fg_value}$RAM_USED${RESET}"
  echo -e "${bg_title}${fg_title}RAM_FREE${RESET}=${bg_value}${fg_value}$RAM_FREE${RESET}"
  echo -e "${bg_title}${fg_title}SPACE_ROOT${RESET}=${bg_value}${fg_value}$SPACE_ROOT${RESET}"
  echo -e "${bg_title}${fg_title}SPACE_ROOT_USED${RESET}=${bg_value}${fg_value}$SPACE_ROOT_USED${RESET}"
  echo -e "${bg_title}${fg_title}SPACE_ROOT_FREE${RESET}=${bg_value}${fg_value}$SPACE_ROOT_FREE${RESET}"
}