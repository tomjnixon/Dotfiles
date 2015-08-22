CONFIG_FILE(supervisor, ~/.supervisor)
[supervisord]
childlogdir=%(here)s/.supervisor_logs
directory=%(here)s

[rpcinterface:supervisor]
supervisor.rpcinterface_factory = supervisor.rpcinterface:make_main_rpcinterface

[supervisorctl]
serverurl=unix://%(here)s/.supervisor.sock

[unix_http_server]
file=%(here)s/.supervisor.sock

[inet_http_server]
port = 127.0.0.1:9001

sinclude(supervisor_priv.inc.m4)

ON_COMPUTER(LAPTOPS)
[program:nm-applet]
command=nm-applet
END_COMPUTER()

ON_COMPUTER(LAPTOP)
[program:mpd]
command=mpd --no-daemon

[program:mpdscribble]
command=mpdscribble -D --conf .mpdscribble

# [program:redshift]
# command=redshift  -l 53.3656:-2.2280 -t 6500:3700
END_COMPUTER()

