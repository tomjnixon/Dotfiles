CONFIG_FILE(i3, ~/.i3/config)

define(ADD_PROGRAM, `bindsym $1 exec i3-exec $2; mode "default"')
define(upcase, `translit(`$*', `a-z', `A-Z')')
define(ADD_WORKSPACE,
`bindsym $mod+$1 workspace $2; exec warp_cursor_to_centre
bindsym $mod+Shift+upcase($1) move workspace $2')

ADD_WORKSPACE(i, im)
ADD_WORKSPACE(e, email)
ADD_WORKSPACE(m, music)
ADD_WORKSPACE(n, notes)

mode "program" {
    ADD_PROGRAM(c, chromium)
    ADD_PROGRAM(a, cantata)
    ADD_PROGRAM(f, firefox-developer-edition)
    ADD_PROGRAM(t, xinput --enable "SynPS/2 Synaptics TouchPad")
    ADD_PROGRAM(Shift+T, xinput --disable "SynPS/2 Synaptics TouchPad")
    ADD_PROGRAM(v, gvim)
    ADD_PROGRAM(x, i3lock -c 000000)
    ADD_PROGRAM(k, setup_x)
    ADD_PROGRAM(o, xset dpms force off)
    ADD_PROGRAM(p, passmenu)
    ADD_PROGRAM(Shift+P, passmenu --type)
    ADD_PROGRAM(r, reference_menu)
    ADD_PROGRAM(s, screen_menu)
    
    bindsym Return mode "default"
    bindsym Escape mode "default"
}
bindsym $mod+p mode "program"

set $mod Mod4

# font for window titles. ISO 10646 = Unicode
font -*-terminus-*-*-*-*-12-*-*-*-*-*-iso10646-*

# Use Mouse+$mod to drag floating windows to their wanted position
floating_modifier $mod

# Always show windows as urgent for a short time.
force_display_urgency_hint 500ms

# start a terminal
bindsym $mod+Return exec i3-exec uxterm

# start a floating terminal
bindsym $mod+Shift+Return exec i3-exec uxterm -class xterm-float
for_window [class="xterm-float"] floating enable

# kill focused window
bindsym $mod+q kill

# start dmenu (a program launcher)
bindsym $mod+Shift+P exec i3-exec dmenu_run

# change focus
bindsym $mod+h focus left; exec warp_cursor_to_centre
bindsym $mod+j focus down; exec warp_cursor_to_centre
bindsym $mod+k focus up; exec warp_cursor_to_centre
bindsym $mod+l focus right; exec warp_cursor_to_centre

# alternatively, you can use the cursor keys:
bindsym $mod+Left focus left; exec warp_cursor_to_centre
bindsym $mod+Down focus down; exec warp_cursor_to_centre
bindsym $mod+Up focus up; exec warp_cursor_to_centre
bindsym $mod+Right focus right; exec warp_cursor_to_centre

# move focused window
bindsym $mod+Shift+H move left; exec warp_cursor_to_centre
bindsym $mod+Shift+J move down; exec warp_cursor_to_centre
bindsym $mod+Shift+K move up; exec warp_cursor_to_centre
bindsym $mod+Shift+L move right; exec warp_cursor_to_centre

# alternatively, you can use the cursor keys:
bindsym $mod+Shift+Left move left; exec warp_cursor_to_centre
bindsym $mod+Shift+Down move down; exec warp_cursor_to_centre
bindsym $mod+Shift+Up move up; exec warp_cursor_to_centre
bindsym $mod+Shift+Right move right; exec warp_cursor_to_centre

# split in horizontal orientation
bindsym $mod+x split h

# split in vertical orientation
bindsym $mod+y split v

# enter fullscreen mode for the focused container
bindsym $mod+f fullscreen; exec warp_cursor_to_centre

# change container layout (stacked, tabbed, default)
bindsym $mod+s layout stacking
bindsym $mod+t layout tabbed
bindsym $mod+d layout default

bindsym $mod+Shift+S sticky toggle

# toggle tiling / floating
bindsym $mod+Shift+space floating toggle; exec warp_cursor_to_centre

# change focus between tiling / floating windows
bindsym $mod+space focus mode_toggle; exec warp_cursor_to_centre

# focus the parent container
bindsym $mod+a focus parent

# focus the child container
#bindcode $mod+d focus child

# switch to workspace
bindsym $mod+1 workspace 1; exec warp_cursor_to_centre
bindsym $mod+2 workspace 2; exec warp_cursor_to_centre
bindsym $mod+3 workspace 3; exec warp_cursor_to_centre
bindsym $mod+4 workspace 4; exec warp_cursor_to_centre
bindsym $mod+5 workspace 5; exec warp_cursor_to_centre
bindsym $mod+6 workspace 6; exec warp_cursor_to_centre
bindsym $mod+7 workspace 7; exec warp_cursor_to_centre
bindsym $mod+8 workspace 8; exec warp_cursor_to_centre
bindsym $mod+9 workspace 9; exec warp_cursor_to_centre
bindsym $mod+0 workspace 10; exec warp_cursor_to_centre

# move focused container to workspace
bindsym $mod+Shift+exclam move workspace 1
bindsym $mod+Shift+quotedbl move workspace 2
bindsym $mod+Shift+sterling move workspace 3
bindsym $mod+Shift+dollar move workspace 4
bindsym $mod+Shift+percent move workspace 5
bindsym $mod+Shift+asciicircum move workspace 6
bindsym $mod+Shift+ampersand move workspace 7
bindsym $mod+Shift+asterisk move workspace 8
bindsym $mod+Shift+parenleft move workspace 9
bindsym $mod+Shift+parenright move workspace 10

bindsym $mod+v move workspace to output left
bindsym $mod+b move workspace to output right
bindsym $mod+Shift+V move workspace to output down
bindsym $mod+Shift+B move workspace to output up

workspace_auto_back_and_forth yes
bindsym $mod+Escape workspace back_and_forth; exec warp_cursor_to_centre

bindsym XF86Launch1 exec xset dpms force off

# Music keys
bindsym XF86AudioPlay exec mpc toggle
bindsym XF86AudioStop exec mpc stop
bindsym XF86AudioPrev exec mpc prev
bindsym XF86AudioNext exec mpc next
define(`AMIXER', `exec amixer -D pulse')
bindsym XF86AudioMute AMIXER set Master toggle
bindsym XF86AudioLowerVolume AMIXER set Master 5%-; AMIXER set Master unmute
bindsym XF86AudioRaiseVolume AMIXER set Master 5%+; AMIXER set Master unmute
bindsym Shift+XF86AudioLowerVolume AMIXER set Master 1%-; AMIXER set Master unmute
bindsym Shift+XF86AudioRaiseVolume AMIXER set Master 1%+; AMIXER set Master unmute
bindsym $mod+XF86AudioLowerVolume AMIXER set Master 30%; AMIXER set Master unmute
bindsym $mod+XF86AudioRaiseVolume AMIXER set Master 100%; AMIXER set Master unmute

dnl brightness keybindings seem to be built into modern X
ON_COMPUTER(!LAPTOP)
# Brightness keys
bindsym XF86MonBrightnessUp   exec --no-startup-id xbacklight -inc 5 -time 0
bindsym XF86MonBrightnessDown exec --no-startup-id xbacklight -dec 5 -time 0
bindsym Shift+XF86MonBrightnessUp   exec --no-startup-id xbacklight -inc 1 -time 0
bindsym Shift+XF86MonBrightnessDown exec --no-startup-id xbacklight -dec 1 -time 0
END_COMPUTER()

# Make various things behave
for_window [title="xfce4-notifyd"] floating enable; border none
for_window [class="MPlayer"] floating enable

# reload the configuration file
bindsym $mod+Shift+C reload
# restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
bindsym $mod+Shift+R restart
# exit i3 (logs you out of your X session)
# bindsym $mod+Shift+E exit

# resize window (you can also use the mouse for that)
mode "resize" {
bindsym h resize shrink left 10 px or 10 ppt
bindsym Shift+H resize grow   left 10 px or 10 ppt

bindsym j resize shrink down 10 px or 10 ppt
bindsym Shift+J resize grow   down 10 px or 10 ppt

bindsym k resize shrink up 10 px or 10 ppt
bindsym Shift+K resize grow   up 10 px or 10 ppt

bindsym l resize shrink right 10 px or 10 ppt
bindsym Shift+L resize grow   right 10 px or 10 ppt

        # same bindings, but for the arrow keys
bindsym Left resize shrink left 10 px or 10 ppt
bindsym Shift+Left resize grow   left 10 px or 10 ppt

bindsym Down resize shrink down 10 px or 10 ppt
bindsym Shift+Down resize grow   down 10 px or 10 ppt

bindsym Up resize shrink up 10 px or 10 ppt
bindsym Shift+Up resize grow   up 10 px or 10 ppt

bindsym Right resize shrink right 10 px or 10 ppt
bindsym Shift+Right resize grow   right 10 px or 10 ppt

        # back to normal: Enter or Escape
bindsym Return mode "default"
bindsym Escape mode "default"
}

bindsym $mod+r mode "resize"


bar {
	mode hide
	status_command i3status
}


exec mkdir -p ~/.supervisor_logs
exec_always supervisord -c ~/.supervisor
exec_always setup_x

CONFIG_FILE(i3status, ~/.i3status.conf)
define(`FIRST_ETH_NAME', IF_COMPUTER(LAPTOP, enp0s25, eth0))

# i3status configuration file.
# see "man i3status" for documentation.

# It is important that this file is edited as UTF-8.
# The following line should contain a sharp s:
# ß
# If the above line is not correctly displayed, fix your editor first!

general {
        colors = true
        interval = 2
}

order += "disk /"
order += "run_watch DHCP"
order += "ethernet tun0"
order += "wireless _first_"
order += "ethernet FIRST_ETH_NAME"
ON_COMPUTER(WORK_LAPTOP)
order += "ethernet eth1"
END_COMPUTER()
order += "battery 0"
order += "load"
order += "tztime local"

wireless _first_ {
        format_up = "W: (%quality at %essid, %bitrate / %frequency) %ip"
        format_down = "W: down"
}

ethernet FIRST_ETH_NAME {
        # if you use %speed, i3status requires root privileges
        format_up = "E0: %ip"
        format_down = "E0: down"
}

ON_COMPUTER(WORK_LAPTOP)
ethernet eth1 {
        # if you use %speed, i3status requires root privileges
        format_up = "E1: %ip"
        format_down = "E1: down"
}
END_COMPUTER()

battery 0 {
        format = "%status %percentage %remaining"
}

run_watch DHCP {
ON_COMPUTER(UBUNTU)
        pidfile = "/run/sendsigs.omit.d/network-manager.dhclient-*.pid"
ELSE_COMPUTER()
        pidfile = "/var/run/dhclient*.pid"
END_COMPUTER()
}

ethernet tun0 {
        format_up = "VPN: %ip"
        format_down = "VPN: down"
}

tztime local {
        format = "%Y-%m-%d %H:%M:%S"
}

load {
        format = "%1min"
}

disk "/" {
        format = "%avail"
}


EXECUTABLE_FILE(i3, ~/bin/i3-exec)
#!/bin/bash

desk=$(
        i3-msg -t GET_WORKSPACES |
        jshon -a -e focused -u -p -e name -u |
        grep -A 1 true | tail -n 1)

[ -f "$HOME/.i3/desks/$desk" ] && source "$HOME/.i3/desks/$desk"

exec "$@"

EXECUTABLE_FILE(i3, ~/bin/reference_menu)
#!/bin/bash

base="$HOME/Documents/reference"

doc=$(find "$base" -type f -printf '%P\n' | dmenu -i)

[[ -n "$doc" ]] && xdg-open "$base/$doc"

EXECUTABLE_FILE(i3, ~/bin/screen_menu)
#!/bin/bash

base="$HOME/.screenlayout/"

doc=$(find "$base" -type f -printf '%P\n' | sort | dmenu -i)

[[ -n "$doc" ]] && "$base/$doc"

EXECUTABLE_FILE(i3, ~/bin/warp_cursor_to_centre)
#!/bin/bash

WINDOW=$(xdotool getwindowfocus)

# this brings in variables WIDTH and HEIGHT
eval $(xdotool getwindowgeometry --shell $WINDOW)

TX=$(expr $WIDTH / 2)
TY=$(expr $HEIGHT / 2)

xdotool mousemove -window $WINDOW $TX $TY
