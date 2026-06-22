#!/bin/bash

source ./color.sh
source ./data.sh
chmod +x ./data.sh ./color.sh 

if [ $# -ne 4 ]; then
  echo "There should be 4 parameters."
  exit
fi

if [ $1 -eq $2 ] || [ $3 -eq $4 ]; then
  echo "colors must be different, try again"
  exit
fi

print_color