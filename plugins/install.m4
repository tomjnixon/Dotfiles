dnl directly install a file
define(INSTALL, `ADD_TO_SCRIPT(install_file $1 $2)')
define(INSTALL_EXECUTABLE, `ADD_TO_SCRIPT(install_file $1 $2 && chmod +x $2)')
