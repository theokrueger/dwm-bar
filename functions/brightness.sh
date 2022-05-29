#!/bin/sh

# brightness module for dwm-bar
# theokrueger <git@gitlab.com/theokrueger>
# GNU GPLv3

# module dependencies:
# brightnessctl

function dwm_brightness()
{
        # prints brightness in format:
        # BL: <brightness>%
        # for example:
        # BL: 69%

        # out always be 3 characters (05% instead of 5%, MAX instead of 100%) because it looks better that way
        BRIGHTNESS=$( printf "%02d%%" "$(( $( brightnessctl get ) * 100 / $( brightnessctl max ) ))" )
        if [ $BRIGHTNESS = "100%" ]; then
                BRIGHTNESS="MAX"
        fi
        echo "BL: $BRIGHTNESS"
}
