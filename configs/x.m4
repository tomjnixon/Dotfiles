CONFIG_FILE(x, ~/.xinitrc)

source /etc/X11/xinit/xinitrc.d/*

xrdb ~/.Xdefaults
xrdb -merge ~/.Xjellybeans

mkdir -p ~/.supervisor_logs
supervisord -c ~/.supervisor

setup_keyboard

while true; do
        exec dbus-launch i3
        xmessage 'Restart the Window Manager?' \
                 -buttons 'Yes:1,No:0' -center \
                 -default 'Yes' -timeout 30    \
        && break
done

CONFIG_FILE(x, ~/.Xdefaults)
urxvt.urgentOnBell: true
xterm*bellIsUrgent: true

xterm*metaSendsEscape: true
urxvt.scrollBar: false
urxvt*termName: rxvt-unicode
urxvt.font: xft:Terminus:antialias=False:pixelsize=7
xterm*font: -*-terminus-*-*-*-*-12-*-*-*-*-*-iso10646-*
urxvt.fading: false
xterm*saveLines: 4096

! allow using shift in xterm to copy/paste to/from the clipboard
*VT100.Translations: #override \
                     Shift <Btn1Down>:   select-start()              \n\
                     Shift <Btn1Motion>: select-extend()             \n\
                     Shift <Btn1Up>:     select-end(CLIPBOARD)       \n\
                     Shift <Btn2Up>:     insert-selection(CLIPBOARD) \n\
                     Shift <Btn3Down>:   start-extend()              \n\
                     Shift <Btn3Motion>: select-extend()

CONFIG_FILE(x, ~/.Xjellybeans)
#define j_black    #3b3b3b
#define j_red      #cf6a4c
#define j_green    #99ad6a
#define j_yellow   #d8ad4c
#define j_blue     #597bc5
#define j_magenta  #a037b0
#define j_cyan     #71b9f8
#define j_white    #adadad

xterm*background:            #151515
xterm*foreground:            #e8e8d3
xterm*fading:                40
xterm*fadeColor:            #e8e8d3
xterm*cursorColor:           #b0d0f0

xterm*color0:                j_black
xterm*color1:                j_red
xterm*color2:                j_green
xterm*color3:                j_yellow
xterm*color4:                j_blue
xterm*color5:                j_magenta
xterm*color6:                j_cyan
xterm*color7:                j_white

CONFIG_FILE(x, ~/.Xmodmap)
clear Lock
keycode 0x42 = Escape

EXECUTABLE_FILE(x, ~/bin/setup_keyboard)
#!/bin/bash
xset r rate 200 25 &
setxkbmap gb
xmodmap ~/.Xmodmap

for id in $(xinput --list | grep "TrackPoint" | grep -Po 'id=\K[0-9]+'); do
        xinput set-int-prop $id "Evdev Wheel Emulation" 8 1
        xinput set-int-prop $id "Evdev Wheel Emulation Button" 8 2
        xinput set-int-prop $id "Evdev Wheel Emulation Axes" 8 6 7 4 5
done

xinput --disable "SynPS/2 Synaptics TouchPad"
