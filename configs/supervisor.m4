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

sinclude(../configs_priv/supervisor.m4)

ON_COMPUTER(LAPTOPS)
[program:nm-applet]
command=nm-applet

[program:batt_mon]
command=batt_mon

[program:xss-lock]
command=xss-lock
    -n "notify-send -t 5000 -u low 'going to sleep'"
    -- i3lock -n -e -c 000000
END_COMPUTER()

ON_COMPUTER(LAPTOP)
[program:mpd]
command=mpd --no-daemon

[program:mpdscribble]
command=mpdscribble -D --conf .mpdscribble

[program:redshift]
command=redshift  -l 53.3656:-2.2280 -t 6500:3700
END_COMPUTER()
