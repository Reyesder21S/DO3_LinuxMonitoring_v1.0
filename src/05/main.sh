#!/bin/bash

source ./data.sh
chmod +x ./data.sh

if [ $# -ne 1 ] || [ "${1: -1}" != "/" ]; then
    echo "Usage: $0 <directory_path/>"
    exit 1
fi

d_path="$1"

if [ ! -d "$d_path" ]; then
    echo "Error: Directory '$d_path' does not exist."
    exit 1
fi

print_info