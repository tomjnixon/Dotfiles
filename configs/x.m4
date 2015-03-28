CONFIG_FILE(x, ~/.xinitrc)

source /etc/X11/xinit/xinitrc.d/*

xrdb -merge ~/.Xdefaults
xrdb -merge ~/.Xjellybeans

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
UXTerm*vt100.bellIsUrgent: true

XTerm*metaSendsEscape: true
urxvt.scrollBar: false
urxvt*termName: rxvt-unicode
ON_COMPUTER(MINE)
urxvt.font: xft:Terminus:antialias=False:pixelsize=7
UXTerm*font: -*-terminus-*-*-*-*-12-*-*-*-*-*-iso10646-*
END_COMPUTER()
urxvt.fading: false

CONFIG_FILE(x, ~/.Xjellybeans)
#define j_black    #3b3b3b
#define j_red      #cf6a4c
#define j_green    #99ad6a
#define j_yellow   #d8ad4c
#define j_blue     #597bc5
#define j_magenta  #a037b0
#define j_cyan     #71b9f8
#define j_white    #adadad

*background:            #151515
*foreground:            #e8e8d3
*fading:                40
*fadeColor:            #e8e8d3
*cursorColor:           #b0d0f0

*color0:                j_black
*color1:                j_red
*color2:                j_green
*color3:                j_yellow
*color4:                j_blue
*color5:                j_magenta
*color6:                j_cyan
*color7:                j_white

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
