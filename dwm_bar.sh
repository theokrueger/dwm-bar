#!/bin/sh

# heavily personalised fork of [dwm-bar](https://github.com/joestandring/dwm-bar), a modular statusbar for dwm
# Theo Krueger <git@github.com/theokrueger>
# GNU GPLv3
# dependencies: xorg-xsetroot playerctl

# define our functions

#dwm_track: a dwm_bar function to display now playing track
dwm_track () { # depends on playerctl
    # prints now playing track in format:
    # <status>: <track title> <positon>/<length>
    # for example:
    # Playing: Touhiron 3:42/4:35
    # IMPORTANT NOTE, since this can return nothing we add the separation between modules in this function instead of the concatenation during xsetroot
    status=$(playerctl status -s)
    if [ $status = "Playing" ]; then
        pos=$(playerctl position -s | sed 's/..\{6\}$//')
        len=$(playerctl metadata mpris:length -s | sed 's/.\{6\}$//')
        printf "$status: $(playerctl metadata title -s) %02d:%02d/%02d:%02d | " $((pos / 60)) $((pos % 60)) $((len / 60)) $((len % 60))
    fi
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
