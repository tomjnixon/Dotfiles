dnl same as CONFIF_FILE, but make it executable
define(EXECUTABLE_FILE, `CONFIG_FILE($@)
ADD_TO_SCRIPT(chmod +x $2)dnl')
