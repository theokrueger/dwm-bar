#!/bin/sh

# complete rewrite of [dwm-bar](https://github.com/joestandring/dwm-bar), a modular statusbar for dwm
# theokrueger <git@gitlab.com/theokrueger>
# GNU GPLv3

# dependencies:
# * xorg-xsetroot (base)
# * playerctl (track)
# * brightnessctl (brightness)

#######################
# CONFIGURABLE VALUES #
#######################

# minimum bar update rate, always make it a factor of 1 (no 0.33)
UPDATE_RATE='0.5'

# separator between each module
SEPARATOR=' | '

# update function, rearrange modules as needed
function update()
{
        # $UPDATE_RATE second(s) update
        #

        # 1 second update
        if [ $(echo "$TIME % 1" | bc) = "0" ]; then
                TRACK=$(dwm_track)
                ISO_TIME=$(dwm_iso_time)
                $IS_LAPTOP && BRIGHTNESS=$(dwm_brightness)

                # 5 second update
                if [ $(echo "$TIME % 5" | bc) = "0" ]; then
                        MEMORY=$(dwm_memory)
                        DRIVES=$(dwm_drives $(echo "$TIME / 5" | bc) )
                        # 10 second update
                        if [ $(echo "$TIME % 10" | bc) = "0" ]; then
                                $IS_LAPTOP && BATTERY=$(dwm_battery)
                        fi
                fi
        fi
}

###############################################
# you probably don't need to touch below here #
###############################################

# test laptop based on if theres a battery or not because i cant think of a better way
IS_LAPTOP=false #cat /sys/class/power_supply/BAT0/status && true || false
if [ $(cat /sys/class/power_supply/BAT0/status > /dev/null) ]; then
        IS_LAPTOP=true
fi

DIR=$(dirname $0)

TIME=0

# import universal functions
TRACK=''
source "$DIR/functions/track.sh"
ISO_TIME=''
source "$DIR/functions/iso_time.sh"
MEMORY=''
source "$DIR/functions/memory.sh"
DRIVES=''
source "$DIR/functions/drives.sh"
# import laptop only functions
BRIGHTNESS=''
source "$DIR/functions/brightness.sh"
BATTERY=''
source "$DIR/functions/battery.sh"

# add separators to input unless input is nil
function add_sep()
{
        if [ "$1" != '' ]; then
                echo "$2$1$3"
        fi
}

# update loop
while true; do
        update
        xsetroot -name "$( add_sep "$TRACK" '' "$SEPARATOR" )$( add_sep "$MEMORY" '' "$SEPARATOR" )$( add_sep "$DRIVES" '' "$SEPARATOR" )$( add_sep "$BRIGHTNESS" '' "$SEPARATOR" )$( add_sep "$BATTERY" '' "$SEPARATOR" )$( add_sep "$ISO_TIME" '' '' )"
        TIME=$( echo "$TIME + $UPDATE_RATE" | bc )
        sleep $UPDATE_RATE
done
