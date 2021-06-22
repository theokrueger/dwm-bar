#!/bin/sh

# heavily personalised fork of [dwm-bar](https://github.com/joestandring/dwm-bar), a modular statusbar for dwm
# Theo Krueger <git@github.com/theokrueger>
# GNU GPLv3
# dependencies: xorg-xsetroot playerctl

# define our functions

#dwm_track: a dwm_bar function to display now playing track
dwm_track () { # depends on playerctl
    # prints now playing track:
    # <status>: <track title> <positon>/<length>
    # for example:
    # Playing: Touhiron 3:42/4:35
    # IMPORTANT NOTE, since this can return nothing we add the separation between modules in this function instead of the concatenation during xsetroot
    track=$(playerctl metadata title -s)
    if ! [ ${#track} = "0" ]; then
        printf "$(playerctl status): $track $(dwm_track_time) | "
    fi
}
dwm_track_time () { # helper function for dwm_track to format time
    pos=$(playerctl position | sed 's/..\{6\}$//')
    len=$(playerctl metadata mpris:length | sed 's/.\{6\}$//')
    # format time as minute:second if minute will not be zero 
    if ! [ $((pos / 60)) = 0 ]; then
        printf "%i:" $((pos / 60))
    fi
    printf "%02d/" $((pos % 60))
    if ! [ $((len / 60)) = 0 ]; then
        printf "%i:" $((len / 60))
    fi
    printf "%02d" $((len % 60))
    # this technically breaks at things less than 10 seconds by displaying a padded zero when it shouldnt but thats hoesntly not worth implementing a fix for
    # also breaks with tracks > 1 hour, easy enough to fix im just lazy
}

# dwm_memory: a dwm_bar function to display used memory
dwm_memory () {
    # prints memory usage in format:
    # mem: <usedmem>Gi
    # for example:
    # mem: 6.9Gi
	printf "mem: %s" "$(free -h | grep Mem | awk '{print $3}')"
}

# dwm_date: a dwm_bar function to display current time
dwm_date () { 
    # prints date in format:
    # [<weekday>] <fullyear>-<month>-<day> <time>
    # for example:
    # [4] 1970-01-01 00:00
    printf "$(date "+[%u] %F %R")"
}

# update loop
while true
do
    # set name to our new info and do it again 1 second later
    xsetroot -name "$(dwm_track)$(dwm_memory) | $(dwm_date)"
    # IMPORTANT NOTE, since dwm_track can return nothing we add the separation in its function, if you change order of things please modify dwm_track accordingly
    sleep 1
done
