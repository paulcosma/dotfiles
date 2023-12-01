#!/bin/bash
set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
GREY='\033[0;37m'
NC='\033[0m' # No Color

backup_folder="/tmp/test"
daily_backup_days=7
weekly_backup_weeks=5
monthly_backup_months=12

# Check if the backup folder exists
if [ ! -d "$backup_folder" ]; then
    echo -e "${RED}Backup folder not found: ${YELLOW}$backup_folder${NC}"
    exit 1
fi

current_date=$(date +%s)
declare -A keep_dirs
declare -A week_dirs
declare -A month_dirs

function age_in_days() {
    local dir=$1
    local modification_date=$(date -r "$dir" +%s)
    echo $(( ($current_date - $modification_date) / 86400 ))
}

function age_in_weeks() {
    local dir=$1
    echo $(( $(age_in_days "$dir") / 7 ))
}

function month_number() {
    local dir=$1
    echo $(date -r "$dir" +%Y%m)
}

function mark_directories() {
    local dir=$1
    local age_days=$(age_in_days "$dir")
    local age_weeks=$(age_in_weeks "$dir")
    local month_num=$(month_number "$dir")

    # Mark directories for daily backups
    if [ $age_days -le $daily_backup_days ]; then
        keep_dirs["$dir"]=1
    fi

    # Mark directories for weekly backups
    if [ $age_weeks -gt 0 ] && [ $age_weeks -le $weekly_backup_weeks ]; then
        # Determine the Modification Date of the Stored Directory for the Same Week. If the date command fails defaults to 0
        local current_week_mod_date=$(date -r "${week_dirs[$age_weeks]}" +%s 2>/dev/null || echo 0) 
        # Get the modification date of the current directory
        local dir_mod_date=$(date -r "$dir" +%s) 
        # If the directory currently being examined is newer updates the entry for that week in the week_dirs associative array to point to this directory.
        if [ $current_week_mod_date -lt $dir_mod_date ]; then
            week_dirs[$age_weeks]="$dir"
        fi
    fi

    # Mark directories for monthly backups
    if [ $(date -d "-$monthly_backup_months months" +%Y%m) -le $month_num ]; then
        local current_month_mod_date=$(date -r "${month_dirs[$month_num]}" +%s 2>/dev/null || echo 0)
        local dir_mod_date=$(date -r "$dir" +%s)
        if [ $current_month_mod_date -lt $dir_mod_date ]; then
            month_dirs[$month_num]="$dir"
        fi
    fi
}

# Traverse the backup directory and mark directories for retention
find "$backup_folder" -mindepth 1 -maxdepth 1 -type d | while read -r dir; do
    mark_directories "$dir"
done

# Update the keep_dirs array based on week_dirs and month_dirs
for dir in "${week_dirs[@]}" "${month_dirs[@]}"; do
    keep_dirs["$dir"]=1
done

echo -e "${GREEN}Directories to be kept:${NC}"
for dir in "${!keep_dirs[@]}"; do
    if [ ${keep_dirs["$dir"]} -eq 1 ]; then
        echo -e "${YELLOW}$dir"
    fi
done | sort

for dir in "$backup_folder"/*/; do
    if [ -z "${keep_dirs["$dir"]}" ] || [ ${keep_dirs["$dir"]} -eq 0 ]; then
        echo -e "${RED}Removing ${NC}$dir"
        rm -rf "$dir"
    fi
done
