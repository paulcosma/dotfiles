#!/bin/bash
# Create a directory for each day in the last year to be used to test the backup-retention script.

base_dir="/tmp/test"
current_time=$(date "+%s")
one_year_ago=$((current_time - 365*24*60*60))

while [ "$current_time" -ge "$one_year_ago" ]; do
    dir_name=$(date -d "@$current_time" "+%Y%m%d")

    mkdir -p "$base_dir/testing-$dir_name"
    touch -t "$dir_name"0000 "$base_dir/testing-$dir_name" # Set the timestamp for the directory to reflect the date
    current_time=$((current_time - 24*60*60))  # Decrement the current_time by one day (in seconds)
done

echo "Directories created for each day in the last year."
