CONFIG_FILE(i3, ~/.i3/config)

define(ADD_PROGRAM,
`divert(1)bindsym $1 exec i3-exec $2; mode "default"
divert')
define(upcase, `translit(`$*', `a-z', `A-Z')')
define(ADD_WORKSPACE,
`divert(2)bindsym $mod+$1 workspace $2
bindsym $mod+Shift+upcase($1) move workspace $2
undivert')

define(`pamix', `pamixer -s alsa_output.pci-0000_00_1b.0.analog-stereo')

ADD_WORKSPACE(i, im)
ADD_WORKSPACE(e, email)
ADD_WORKSPACE(m, music)

ADD_PROGRAM(c, google-chrome)
ADD_PROGRAM(a, ario)
ADD_PROGRAM(f, firefox)
ADD_PROGRAM(e, thunderbird)
ADD_PROGRAM(t, thunderbird)
ADD_PROGRAM(v, IF_COMPUTER(LAPTOP, i3-gvim, gvim))
IF_COMPUTER(LAPTOP,
	`ADD_PROGRAM(h, paswitch headphones; exec notify-send headphones-ext)
	ADD_PROGRAM(s, paswitch speakers; exec amixer sset Master 70%; exec shet /tom/speakers_on 1; exec notify-send speakers)
	ADD_PROGRAM(i, paswitch speakers; exec amixer sset Master 20%; exec notify-send headphones-int)')
IF_COMPUTER(UNI,
	`ADD_PROGRAM(l, xlock -bitmap $HOME/Documents/trollface.xbm -mode image -timeelapsed)')

set $mod Mod4

# font for window titles. ISO 10646 = Unicode
font -*-terminus-*-*-*-*-12-*-*-*-*-*-iso10646-*

# Use Mouse+$mod to drag floating windows to their wanted position
floating_modifier $mod

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

ON_COMPUTER(LAPTOP)
bindsym $mod+v output_move LVDS1
bindsym $mod+b output_move VGA1
END_COMPUTER()

workspace_auto_back_and_forth yes
bindsym $mod+Escape workspace back_and_forth

undivert(2)

ON_COMPUTER(MINE)
# SHET commands
bindsym $mod+F1 exec shet /tom/toggle_desk
bindsym $mod+F2 exec shet /tom/toggle_bedside

bindsym XF86Launch1 exec xset dpms force off

# Music keys
bindsym XF86AudioPlay exec mpc toggle
bindsym XF86AudioStop exec mpc stop
bindsym XF86AudioPrev exec mpc prev
bindsym XF86AudioNext exec mpc next
# set-volume doesn't work for some reason...
bindsym XF86AudioMute exec pamix --decrease 1000
bindsym XF86AudioLowerVolume exec pamix --decrease 5
bindsym XF86AudioRaiseVolume exec pamix --increase 5
bindsym Shift+XF86AudioLowerVolume exec pamix --decrease 1
bindsym Shift+XF86AudioRaiseVolume exec pamix --increase 1

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

mode "program" {
undivert(1)
bindsym Return mode "default"
bindsym Escape mode "default"
}
bindsym $mod+p mode "program"

bar {
	mode hide
	status_command i3status
}
