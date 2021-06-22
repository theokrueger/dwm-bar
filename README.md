# dwm-bar
personalised fork of [dwm-bar](https://github.com/joestandring/dwm-bar), a modular statusbar for dwm
## table-of-contents
- [current functions](#current-functions)
  - [dwm_playerctl](#dwm_playerctl)
  - [dwm_resources](#dwm_resources)
  - [dwm_date](#dwm_date)
- [installation](#installation)
- [usage](#usage)
- [customisation](#customizing)
- [acknowledgements](#acknowledgements)
##current-functions
### dwm_track
displays what is now playing using playerctl metadata
```
prints now playing track:
<status>: <track title> <positon>/<length>
for example:
Playing: Touhiron 3:42/4:35
```
dependencies: ```playerctl```
### dwm_resources
displays used memory
```
format:
mem: <usedmem>Gi
display:
mem: 6.9Gi
```
### dwm_date
displays current date and time
```
format:
[<weekday>] <fullyear>-<month>-<day> <time>
display:
[4] 1970-01-01 00:00
```
## installation
1. clone and enter the repository:
```
$ git clone https://github.com/theokrueger/dwm-bar
$ cd dwm-bar
```
2. install dependencies
```
sudo pacman -S xorg-xsetroot playerctl
```
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
## acknowledgements
* [Klemens Nanni](https://notabug.org/kl3)
* [@boylemic](https://github.com/boylemic/configs/blob/master/dwm_status)
* [Parket Johnson](https://github.com/ronno/scripts/blob/master/xsetcmus)
* [suckless.org](https://dwm.suckless.org/status_monitor/)
* [@mcallistertyler95](https://github.com/mcallistertyler95/dwm-bar)
* [@joestandring](https://github.com/joestandring/dwm-bar)
