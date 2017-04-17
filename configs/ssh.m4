CONFIG_FILE(ssh, ~/.ssh/config.head)

# Make SSH *quick*.
ControlMaster auto
ControlPath ~/.ssh/sock_%h_%p_%r
ControlPersist yes

# Ping the remote side every 30 seconds, and disconnect if more than 2
# packets are lost.
ServerAliveInterval 30
ServerAliveCountMax 2

define(`PRINT_ARGS', `ifelse(eval($#<2),1, `	$1'
,`	$1
PRINT_ARGS(shift($@))')')

define(`HOST', `Host $1
PRINT_ARGS(shift($@))')

define(`MATCH', `Match $1
PRINT_ARGS(shift($@))')

define(`ALIAS', `HOST($1, Hostname $2)')

sinclude(../configs_priv/ssh.m4)

ADD_TO_SCRIPT(ssh-key config)
