[supervisord]
childlogdir=/home/tom/.supervisor_logs
directory=/home/tom/

[rpcinterface:supervisor]
supervisor.rpcinterface_factory = supervisor.rpcinterface:make_main_rpcinterface

[supervisorctl]
serverurl=unix:///home/tom/.supervisor.sock

[unix_http_server]
file=/home/tom/.supervisor.sock

[inet_http_server]
port = 127.0.0.1:9001


[program:hc-server]
command=node node_modules/hc-server/hc-server.js

[program:dpms]
command=python2 dev/SHET/src/clients/dpms.py /tom/dpms

[program:mpd]
command=mpd --no-daemon

[program:mpd-ctl]
command=python2 dev/SHET/src/clients/mpd_ctl.py /tom/mpd/

[program:notify]
command=python2 dev/SHET/src/clients/libnotify.py /tom/notify

[program:ssh-vps]
command=autossh -M 0 -q -N -R 10022:localhost:22 vps

[program:ssh-shet]
command=autossh -M 0 -q -N -L 11235:localhost:11235 server

[program:nm-applet]
command=nm-applet

[program:mpdscribble]
command=mpdscribble -D --conf .mpdscribble

[program:dropbox]
command=dropboxd
