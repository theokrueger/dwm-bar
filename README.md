# dwm-bar

complete rewrite (for the worse) of [dwm-bar](https://github.com/joestandring/dwm-bar), a now unmodular statusbar for dwm

at this point its so far detatched its hardly even a fork of the original, you should use the original anyways.

## directory

- [goals](#goals)
- [current-functions](#functions)
  - [dwm_track](#dwm_track)
  - [dwm_memory](#dwm_memory)
  - [dwm_storage](#dwm_storage)
  - [dwm_battery](#dwm_battery)
  - [dwm_brightness](#dwm_brightness)
  - [dwm_date](#dwm_date)
- [installation](#installation)
- [usage](#usage)
- [customisation](#customisation)
- [contribution](#contribution)
- [acknowledgements](#acknowledgements)

## goals

- show status of various functions 
  - fixed width
    - except for media player
  - actually useful information
- be minimalistic and boring
- ignore as many edge cases as possible

## functions

### `dwm_track`

displays what is now playing using playerctl metadata

format:
```
<status>: <track title> <pos>/<len>
```

display:
```
Playing: Touhiron 3:42/4:35
```

dependencies: `playerctl`

### `dwm_memory`

displays used memory

format:
```
mem: <usedmem><unit of storage>
```

display:
```
mem: 6.9Gi
```

### `dwm_drives`

cycles printing all storage drives and their % usage

format:
```
<disk><spacing><percent used>
```

display:
```
sda 42%
```

### `dwm_battery`

displays current battery status and charge %

format
```
<status>: <percentage>%
```

display:
```
Charging: 69%
```

### `dwm_brightness`

displays current screen brightness (for laptops)

format
```
BL: <brightness>%
```

display:
```
BL: 13%
```

dependencies: `brightnessctl`

### `dwm_iso_time`

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
$ git clone https://gitlab.com/theokrueger/dwm-bar
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

3. make the script and modules executable

```
$ chmod +x dwm_bar.sh functions/*
```

## usage

simply run the script and dwm should display your bar:

```
$ ./dwm_bar.sh
```

if you would like your bar to be displayed when x starts, add it to your `.xinitrc` before launching dwm

## customisation

look at the files and figure it out yourself

## contribution

contributing to this is a simple 1-step process:
* don't

## acknowledgements

* [Klemens Nanni](https://notabug.org/kl3)
* [@boylemic](https://github.com/boylemic/configs/blob/master/dwm_status)
* [Parket Johnson](https://github.com/ronno/scripts/blob/master/xsetcmus)
* [suckless.org](https://dwm.suckless.org/status_monitor/)
* [@mcallistertyler95](https://github.com/mcallistertyler95/dwm-bar)
* [@joestandring](https://github.com/joestandring/dwm-bar)
