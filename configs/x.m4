CONFIG_FILE(x, ~/.xinitrc)

source /etc/X11/xinit/xinitrc.d/*
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
xterm*termName: xterm-256color

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

EXECUTABLE_FILE(x, ~/bin/setup_x)
#!/bin/bash
ON_COMPUTER(!NIX)
xrdb ~/.Xdefaults
xrdb -merge ~/.Xjellybeans
END_COMPUTER()

xset r rate 200 25
setxkbmap -layout IF_COMPUTER(MPC, us, gb) \
    -option '' \
    -option caps:escape \
    -option terminate:ctrl_alt_bksp

for id in $(xinput --list | grep "ThinkPad USB Keyboard.*slave.*keyboard" | grep -Po 'id=\K[0-9]+'); do
    setxkbmap -device $id -layout gb \
    -option '' \
    -option caps:escape \
    -option terminate:ctrl_alt_bksp
done

xset s 600 5

xset b off

for id in $(xinput --list | grep "TrackPoint" | grep -Po 'id=\K[0-9]+'); do
        xinput set-int-prop $id "Evdev Wheel Emulation" 8 1
        xinput set-int-prop $id "Evdev Wheel Emulation Button" 8 2
        xinput set-int-prop $id "Evdev Wheel Emulation Axes" 8 6 7 4 5
ON_COMPUTER(WORK_LAPTOP)
        xinput set-prop $id "Accel Speed" 0.5
        xinput set-prop $id "libinput Scrolling Pixel Distance" 10
END_COMPUTER()
done

ON_COMPUTER(LAPTOPS && !MPC)
xinput --disable "SynPS/2 Synaptics TouchPad"
END_COMPUTER()

ON_COMPUTER(MPC)
trackpad="pointer:AMR-4630-XXX-0- 0-1023 USB KEYBOARD Mouse"
xinput --set-prop "$trackpad" "libinput Middle Emulation Enabled" 1
xinput --set-prop "$trackpad" "libinput Button Scrolling Button" 2
xinput --set-prop "$trackpad" "libinput Scroll Method Enabled" 0 0 1
END_COMPUTER()

ON_COMPUTER(LAPTOP)
synclient TapButton1=1
synclient VertScrollDelta=300
synclient VertScrollDelta=200

synclient MaxSpeed=1
synclient MinSpeed=1

xinput  --set-prop "SynPS/2 Synaptics TouchPad" "Device Accel Constant Deceleration" 16
xinput  --set-prop "SynPS/2 Synaptics TouchPad" "Device Accel Adaptive Deceleration" 16
xinput  --set-prop "SynPS/2 Synaptics TouchPad" "Device Accel Velocity Scaling" 100
xinput  --set-prop "SynPS/2 Synaptics TouchPad" "Device Accel Profile" 2
END_COMPUTER()
