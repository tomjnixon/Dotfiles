CONFIG_FILE(ssh, ~/.ssh/config)

define(`PRINT_ARGS', `ifelse(eval($#<2),1, `	$1'
,`	$1
PRINT_ARGS(shift($@))')')

define(`HOST', `Host $1
PRINT_ARGS(shift($@))')

define(`HOST_HOME', `HOST($@)
HOST($1-server, shift($@), ProxyCommand ssh server "/bin/nc $1 22")')

define(`U_TOM', `User tom')
define(`U_UNI', `User nixont9')

define(`TRUSTED', `ForwardX11 yes,ForwardX11Trusted yes')
define(`AUTO', `ServerAliveInterval 1, ServerAliveCountMax 2')

define(`N', `Hostname $1')
define(`N_UNI', `Hostname $1.cs.man.ac.uk')

HOST(server, N(18sg.net), TRUSTED, U_TOM)
HOST(serverauto, N(18sg.net), TRUSTED, U_TOM, AUTO)
HOST(jobs, N(18sg.net), TRUSTED, User jobs)
HOST_HOME(tom-tp, N(tom-tp), TRUSTED, U_TOM)
HOST_HOME(shelf, N(shelf), TRUSTED, User shelf)
HOST_HOME(pre, N(pre), TRUSTED, U_TOM)

HOST(*.cs.man.ac.uk, U_UNI)
HOST(uni, N_UNI(lf042), U_UNI)
HOST(rightArm, N_UNI(rightArm), U_TOM)
HOST(leftArm, N_UNI(rightArm), U_TOM)

define(`NFS_HOST', `HOST($1, N(ssh.phx.nearlyfreespeech.net), User $2)')
NFS_HOST(misc, tomn_tomnmisc)
NFS_HOST(tomn, tomn_tomn)
NFS_HOST(git, tomn_tomngit)



