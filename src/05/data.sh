#!/bin/bash

d_path="$1"

START_TIME=$(date +%s)
TOTAL_FOLDERS=$(find "$d_path" -type d | wc -l)
TOP_5_FOLDERS=$(du -h "$d_path" 2>/dev/null | sort -hr | head -n 5 | awk '{print NR " - " $2 ", " $1}')
TOTAL_FILES=$(find "$d_path" -type f | wc -l)
CONF_FILES=$(find "$d_path" -type f -name "*.conf" | wc -l)
TEXT_FILES=$(find "$d_path" -type f -exec file {} \; | grep -i "text" | wc -l)
EXECUTABLE_FILES=$(find "$d_path" -type f -executable | wc -l)
LOG_FILES=$(find "$d_path" -type f -name "*.log" | wc -l)
ARCHIVE_FILES=$(find "$d_path" -type f \( -name "*.zip" -o -name "*.tar" -o -name "*.gz" -o -name "*.7z" -o -name "*.bz2" -o -name "*.rar" \) | wc -l)
SYMLINKS=$(find "$d_path" -type l | wc -l)

TOP_10_FILES=$(find "$d_path" -type f -exec du -h {} + 2>/dev/null | sort -hr | head -n 10 | while read -r size path; do
    type=$(file -b "$path" | cut -d ',' -f1)
    echo "$path, $size, $type"
done)

TOP_10_EXEC_FILES=$(find "$d_path" -type f -executable -exec du -h {} + 2>/dev/null | sort -hr | head -n 10 | while read -r size path; do
    hash=$(md5sum "$path" | awk '{print $1}')
    echo "$path, $size, $hash"
done)

END_TIME=$(date +%s)
EXECUTION_TIME=$((END_TIME - START_TIME))

print_info() {
    echo "Total number of folders (including all nested ones) = $((TOTAL_FOLDERS - 1))"
    echo "TOP 5 folders of maximum size arranged in descending order (path and size):"
    echo "$TOP_5_FOLDERS"
    echo "Total number of files = $TOTAL_FILES"
    echo "Number of:"
    echo "Configuration files (with the .conf extension) = $CONF_FILES"
    echo "Text files = $TEXT_FILES"
    echo "Executable files = $EXECUTABLE_FILES"
    echo "Log files (with the extension .log) = $LOG_FILES"
    echo "Archive files = $ARCHIVE_FILES"
    echo "Symbolic links = $SYMLINKS"
    echo "TOP 10 files of maximum size arranged in descending order (path, size and type):"
    echo "$TOP_10_FILES" | awk '{print NR " - " $0}'
    echo "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file):"
    echo "$TOP_10_EXEC_FILES" | awk '{print NR " - " $0}'
    echo "Script execution time (in seconds) = $EXECUTION_TIME"
}