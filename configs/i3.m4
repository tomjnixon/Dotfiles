CONFIG_FILE(i3, ~/.i3/config)

define(ADD_PROGRAM, `bindsym $1 exec i3-exec $2; mode "default"')
define(upcase, `translit(`$*', `a-z', `A-Z')')
define(ADD_WORKSPACE,
`bindsym $mod+$1 workspace $2
bindsym $mod+Shift+upcase($1) move workspace $2')

ADD_WORKSPACE(i, im)
ADD_WORKSPACE(e, email)
ADD_WORKSPACE(m, music)
ADD_WORKSPACE(n, notes)

mode "program" {
    ADD_PROGRAM(c, chromium)
    ADD_PROGRAM(a, ario)
    ADD_PROGRAM(f, firefox)
    ADD_PROGRAM(t, xinput --enable "SynPS/2 Synaptics TouchPad")
    ADD_PROGRAM(Shift+T, xinput --disable "SynPS/2 Synaptics TouchPad")
    ADD_PROGRAM(v, gvim)
    ADD_PROGRAM(x, i3lock -c 000000)
    ADD_PROGRAM(k, setup_x)
    
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
bindsym $mod+h focus left
bindsym $mod+j focus down
bindsym $mod+k focus up
bindsym $mod+l focus right

# alternatively, you can use the cursor keys:
bindsym $mod+Left focus left
bindsym $mod+Down focus down
bindsym $mod+Up focus up
bindsym $mod+Right focus right

# move focused window
bindsym $mod+Shift+H move left
bindsym $mod+Shift+J move down
bindsym $mod+Shift+K move up
bindsym $mod+Shift+L move right

# alternatively, you can use the cursor keys:
bindsym $mod+Shift+Left move left
bindsym $mod+Shift+Down move down
bindsym $mod+Shift+Up move up
bindsym $mod+Shift+Right move right

# split in horizontal orientation
bindsym $mod+x split h

# split in vertical orientation
bindsym $mod+y split v

# enter fullscreen mode for the focused container
bindsym $mod+f fullscreen

# change container layout (stacked, tabbed, default)
bindsym $mod+s layout stacking
bindsym $mod+t layout tabbed
bindsym $mod+d layout default

# toggle tiling / floating
bindsym $mod+Shift+space floating toggle

# change focus between tiling / floating windows
bindsym $mod+space focus mode_toggle

# focus the parent container
bindsym $mod+a focus parent

# focus the child container
#bindcode $mod+d focus child

# switch to workspace
bindsym $mod+1 workspace 1
bindsym $mod+2 workspace 2
bindsym $mod+3 workspace 3
bindsym $mod+4 workspace 4
bindsym $mod+5 workspace 5
bindsym $mod+6 workspace 6
bindsym $mod+7 workspace 7
bindsym $mod+8 workspace 8
bindsym $mod+9 workspace 9
bindsym $mod+0 workspace 10

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
bindsym $mod+Escape workspace back_and_forth

bindsym XF86Launch1 exec xset dpms force off

# Music keys
bindsym XF86AudioPlay exec mpc toggle
bindsym XF86AudioStop exec mpc stop
bindsym XF86AudioPrev exec mpc prev
bindsym XF86AudioNext exec mpc next
bindsym XF86AudioMute exec amixer set Master toggle
bindsym XF86AudioLowerVolume exec amixer set Master 5%-; exec amixer set Master unmute
bindsym XF86AudioRaiseVolume exec amixer set Master 5%+; exec amixer set Master unmute
bindsym Shift+XF86AudioLowerVolume exec amixer set Master 1%-; exec amixer set Master unmute
bindsym Shift+XF86AudioRaiseVolume exec amixer set Master 1%+; exec amixer set Master unmute
bindsym $mod+XF86AudioLowerVolume exec amixer set Master 30%; exec amixer set Master unmute
bindsym $mod+XF86AudioRaiseVolume exec amixer set Master 100%; exec amixer set Master unmute

# Brightness keys
bindsym XF86MonBrightnessUp   exec --no-startup-id xbacklight -inc 5 -time 0
bindsym XF86MonBrightnessDown exec --no-startup-id xbacklight -dec 5 -time 0
bindsym Shift+XF86MonBrightnessUp   exec --no-startup-id xbacklight -inc 1 -time 0
bindsym Shift+XF86MonBrightnessDown exec --no-startup-id xbacklight -dec 1 -time 0

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
        interval = 5
}

order += "disk /"
order += "run_watch DHCP"
order += "run_watch VPN"
order += "wireless _first_"
order += "ethernet FIRST_ETH_NAME"
ON_COMPUTER(WORK_LAPTOP)
order += "ethernet eth1"
END_COMPUTER()
order += "battery 0"
order += "load"
order += "tztime local"

wireless _first_ {
        format_up = "W: (%quality at %essid) %ip"
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

run_watch VPN {
        pidfile = "/var/run/vpnc/pid"
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
