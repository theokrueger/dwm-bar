#!/bin/sh

# track module for dwm-bar
# theokrueger <git@gitlab.com/theokrueger>
# GNU GPLv3

# module dependencies:
# playerctl

# display currently playing track and its volume
function dwm_track()
{
        # prints now playing track in format:
        # <status>: <track title> <pos>/<len> [<vol>%]
        # for example:
        # Playing: Touhiron 3:42/4:35 [69%]
        STATUS=$(playerctl status -s)
        if [ $STATUS = 'Playing' 2> /dev/null ]; then # if playerctl cannot hook into anything then it throws errors so we just throw stderr into the void
                POS=$( \
                        playerctl position -s \
                        | sed 's/..\{6\}$//' \
                )
                LEN=$( \
                        playerctl metadata mpris:length -s \
                        | sed 's/.\{6\}$//' \
                )
                #      <status>: <track title>                    <pos>/<len>     [<vol>%]
                printf "$STATUS: $( playerctl metadata title -s ) %d:%02d/%d:%02d [%0.0f%%]" \
                   $(( POS / 60 )) $(( POS % 60 )) \
                   $(( LEN / 60 )) $(( LEN % 60 )) \
                   $( echo "100 * $( playerctl volume )" | bc )
        fi
}
