#!/bin/sh

# battery module for dwm-bar
# theokrueger <git@gitlab.com/theokrueger>
# GNU GPLv3

# module dependencies:
# none

function dwm_battery()
{
        # prints battery in format:
        # <status>: <charge>%
        # for example:
        # Discharging: 69%

        # sometimes battery status might be 'UNKNOWN', and that is okay!
        echo "$( cat /sys/class/power_supply/BAT0/status ): $( cat /sys/class/power_supply/BAT0/capacity )%"
}
