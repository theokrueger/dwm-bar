#!/bin/sh

# display used storage for all drives
# theokrueger <git@gitlab.com/theokrueger>
# GNU GPLv3

# module dependencies:
# none

# get list of all drives, only taking actualy devices, and substring out /dev/
STORAGE_DRIVES="$( df -h | awk '{ print $1 }' | grep /dev/ | cut -c 6- )"

# get the length of the longest drive name
STORAGE_LENGTH="$(( $( printf "$STORAGE_DRIVES" | awk '{ print length, $0 }' | sort -nr | head -n 1 | awk '{ print $1; }' ) ))"

# get the total number of drives
STORAGE_NUM="$( echo $STORAGE_DRIVES | wc -w )"

# turn storage drives into a list
STORAGE_DRIVES=( $STORAGE_DRIVES )

# cycles through all storages mounted before execution of this script ONLY
dwm_drives()
{
    # cycles printing all storage drives and their % usage in format:
    # <disk><spacing><percent used>
    # for example:
    # sda 42%

    DRIVE="$( echo ${STORAGE_DRIVES[ $(( $1 % $STORAGE_NUM )) ]} )"
    echo "$DRIVE$( printf "%*s" $(( $STORAGE_LENGTH - ${#DRIVE} )) ) $( printf "%02d" "$( df -h /dev/$( echo $DRIVE ) | tail -1 | awk '{ print $5 }' | sed 's/.$//' )" )%"
}
