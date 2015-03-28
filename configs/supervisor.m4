CONFIG_FILE(supervisor, ~/.supervisor)
[supervisord]
childlogdir=/home/tom/.supervisor_logs
directory=%(here)s

[rpcinterface:supervisor]
supervisor.rpcinterface_factory = supervisor.rpcinterface:make_main_rpcinterface

[supervisorctl]
serverurl=unix:///home/tom/.supervisor.sock

[unix_http_server]
file=/home/tom/.supervisor.sock

[inet_http_server]
port = 127.0.0.1:9001

sinclude(supervisor_priv.inc.m4)

[program:nm-applet]
command=nm-applet

ON_COMPUTER(LAPTOP)
[program:mpd]
command=mpd --no-daemon

[program:mpdscribble]
command=mpdscribble -D --conf .mpdscribble

# [program:redshift]
# command=redshift  -l 53.3656:-2.2280 -t 6500:3700
END_COMPUTER()

