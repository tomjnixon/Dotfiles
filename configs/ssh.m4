CONFIG_FILE(ssh, ~/.ssh/config)

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

define(`U_TOM', `User tom')

define(`TRUSTED', `ForwardX11 yes,ForwardX11Trusted yes')
define(`AUTO', `ServerAliveInterval 1, ServerAliveCountMax 2')

define(`N', `Hostname $1')


define(`NFS_HOST', `HOST($1, N(ssh.phx.nearlyfreespeech.net), User $2)')
NFS_HOST(misc, tomn_tomnmisc)
NFS_HOST(tomn, tomn_tomn)
NFS_HOST(git, tomn_tomngit)

HOST(vps, N(vps.tomn.co.uk), U_TOM)
HOST(vps_console, N(rehnquist.prgmr.com), User tomn, IdentityFile ~/.ssh/vps)

HOST(tom-tp-vps, N(localhost), U_TOM, ProxyCommand ssh vps "/bin/nc %h 10022")

sinclude(ssh_priv.inc.m4)
