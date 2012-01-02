CONFIG_FILE(x, ~/.xinitrc)

source /etc/X11/xinit/xinitrc.d/*

xset r rate 200 25 &
setxkbmap gb
xmodmap ~/.Xmodmap
xrdb -merge ~/.Xdefaults
xrdb -merge ~/.Xsolarized

ON_COMPUTER(LAPTOP)
xinput set-int-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation" 8 1
xinput set-int-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Button" 8 2
xinput set-int-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Axes" 8 6 7 4 5

mpd &
nm-applet &
angel ~/.angel &
mpdscribble -D --conf ~/.mpdscribble &
dropbox start &
END_COMPUTER()

while true; do
        IF_COMPUTER(!UNI, `ck-launch-session ')i3
        xmessage 'Restart the Window Manager?' \
                 -buttons 'Yes:1,No:0' -center \
                 -default 'Yes' -timeout 30    \
        && break
done
