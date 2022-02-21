# dwm-bar
complete rewrite (for the worse) of [dwm-bar](https://github.com/joestandring/dwm-bar), a now unmodular statusbar for dwm
## directory
- [current-functions](#current-functions)
  - [dwm_track](#dwm_track)
  - [dwm_memory](#dwm_memory)
  - [dwm_storage](#dwm_storage)
  - [dwm_date](#dwm_date)
- [installation](#installation)
- [usage](#usage)
- [customisation](#customisation)
- [contribution](#contribution)
- [acknowledgements](#acknowledgements)
## current-functions
### dwm_track
displays what is now playing using playerctl metadata

format:
```
<status>: <track title> <positon>/<length>
```
display:
```
Playing: Touhiron 03:42/04:35
```
dependencies: `playerctl`
### dwm_memory
displays used memory

format:
```
mem: <usedmem><unit of storage>
```
display:
```
mem: 6.9Gi
```
### dwm_storage
cycles printing all storage drives and their % usage

this module tries to keep using the same amount of space on the bar so it does not distrub other modules

format:
```
<spacing><disk> <percent used>
```
display:
```
sda 42%
```
### dwm_battery
displays current battery status and charge %

format
```
<status>: <percentage>%
```
display:
```
Charging: 69%
```
### dwm_brighness
displays current screen brightness (for laptops mostly)

format
```
BL: <brightness>%
```
display:
```
BL: 13%
```
### dwm_date
displays current date and time

format:
```
[<weekday>] <fullyear>-<month>-<day> <time>
```
display:
```
[4] 1970-01-01 00:00
```

## installation
1. clone and enter the repository:
```
$ git clone https://github.com/theokrueger/dwm-bar
$ cd dwm-bar
```
2. install dependencies
archlinux
```
$ pacman -S xorg-xsetroot playerctl brighnessctl
```
gentoo
```
$ emerge -a x11-apps/xsetroot media-sound/playerctl app-misc/brightnessctl
```
brightnessctl can be found in the [guru](https://wiki.gentoo.org/wiki/Project:GURU) overlay

3. make the script executable
```
$ chmod +x dwm_bar.sh
```
## usage
simply run the script and dwm should display your bar:
```
$ ./dwm_bar.sh
```
if you would like your bar to be displayed when x starts, add it to your `.xinitrc` before launching dwm
## customisation
my personalisation of dwm_bar includes stripping it of its modularity in favour of simplicity. creating many modules may cause headache, but i prefer it this way.

you define functions in `dwm_bar.sh` and add them to the `xsetroot` loop with manual spacing and order.
## contribution
contributing to this is a simple 3-step process:
* use echo instead of printf wherever possible
* no capitalisation
* constantly question why you made this when dwm-bar is outright better and easier to modify
## acknowledgements
* [Klemens Nanni](https://notabug.org/kl3)
* [@boylemic](https://github.com/boylemic/configs/blob/master/dwm_status)
* [Parket Johnson](https://github.com/ronno/scripts/blob/master/xsetcmus)
* [suckless.org](https://dwm.suckless.org/status_monitor/)
* [@mcallistertyler95](https://github.com/mcallistertyler95/dwm-bar)
* [@joestandring](https://github.com/joestandring/dwm-bar)
