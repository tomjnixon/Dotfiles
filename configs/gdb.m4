CONFIG_FILE(gdb, ~/.gdbinit)
set history filename ~/.gdb_history
set history save

define xxd
    dump binary memory /tmp/dump.bin $arg0 $arg0+$arg1
    eval "shell xxd -o %p /tmp/dump.bin", $arg0
end
