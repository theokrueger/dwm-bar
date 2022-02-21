#!/bin/sh

# complete rewrite of [dwm-bar](https://github.com/joestandring/dwm-bar), a modular statusbar for dwm
# Theo Krueger <git@github.com/theokrueger>
# GNU GPLv3
# dependencies: xorg-xsetroot playerctl

# add a loop number variable so we can loop through some things nicely
dwm_bar_loops=0

#dwm_track: a dwm_bar function to display now playing track
dwm_track() { # depends on playerctl
    # prints now playing track in format:
    # <status>: <track title> <positon>/<length>
    # for example:
    # Playing: Touhiron 03:42/04:35
    # IMPORTANT NOTE, since this can return nothing we add the separation between modules in this function instead of the concatenation during xsetroot
    status=$(playerctl status -s)
    if [ $status = "Playing" 2> /dev/null ]; then # if playerctl cannot hook into anything then it throws errors so we just throw stderr into the void
        pos=$(playerctl position -s | sed 's/..\{6\}$//')
        len=$(playerctl metadata mpris:length -s | sed 's/.\{6\}$//')
        # dumb print setup because i do not care
        printf "$status: $(playerctl metadata title -s) %02d:%02d/%02d:%02d | " $((pos / 60)) $((pos % 60)) $((len / 60)) $((len % 60))
    fi
}

# dwm_memory: a dwm_bar function to display used memory
dwm_memory() {
    # prints memory usage in format:
    # mem: <usedmem><unit of storage>
    # for example:
    # mem: 6.9Gi
    printf "mem: %s" "$(free -h | grep Mem | awk '{print $3}')"
}

# dwm_storage: a dwm_bar function to display used storage
# IMPORTANT: cycles through all storages mounted before execution of this script ONLY
dwm_storage_drives="$(df -h | awk '{ print $1 }' | grep /dev/ | cut -c 6-)"
dwm_storage_len="$(($(df -h | awk '{ print $1 }' | grep /dev/ | cut -c 6- | awk '{print length, $0}' | sort -nr | head -n 1 | awk '{print $1;}')))"
dwm_storage_nod="$(echo $dwm_storage_drives | wc -w)"
dwm_storage_drives=($dwm_storage_drives)
# here is the entire process so i can actually understand what i wrote:
    # upon launching script, get a list of all drives, taking only the names with a leading /dev/, then substringing out the /dev/
    # save the length of the longest name to a variable
    # then we save the total number of drives to another variable so we dont have to do that calculation again
    # and finally to finish the setup we assign all drives to an array for later use
    # when dwm_storage is called, we extract the drive we want to print the info of based off which cycle we are on.
        # this is done by using the array of all drives, getting what drive we should be at by modding cycles by 3*nod then dividing out 3
        # this makes the same drive stay for 3 cycles
    # we then calculate the number of spaces so that we do not disturb the positions of everything else on the bar every 3 cycles.
        # take the maximum length minus current length of storage and printf that many spaces
    # then we add the % storage use with df <drive>, taking out the % to make <10% use still 2 digits long and readding it
    # finally we print in format "<disk><spacing><percent used>"
dwm_storage() {
    # cycles printing all storage drives and their % usage in format:
    # <disk><spacing><percent used>
    # for example:
    # sda 42%
    temp="$(echo ${dwm_storage_drives[$(( $dwm_bar_loops % ($dwm_storage_nod * 3) / 3 ))]})"
    echo "$temp$(printf "%*s" $(($dwm_storage_len - ${#temp}))) $(printf "%02d" "$(df -h /dev/$(echo $temp) | tail -1 | awk '{print $5}' | sed 's/.$//' )")%"
}

# dwm_date: a dwm_bar function to display current time
dwm_date() {
    # prints date in format:
    # [<weekday>] <fullyear>-<month>-<day> <time>
    # for example:
    # [4] 1970-01-01 00:00
    echo "$(date "+[%u] %F %R")"
}

# update loop
while true; do
    # set name to our new info and do it again 1 second(s) later
    # IMPORTANT NOTE, since dwm_track can return nothing we add the separation in its function, if you change order of things please modify dwm_track accordingly
    xsetroot -name "$(dwm_track)$(dwm_memory) | $(dwm_storage) | $(dwm_date)"
    # oincrement our number of loops
    dwm_bar_loops=$(($dwm_bar_loops + 1))
    sleep 1
done
