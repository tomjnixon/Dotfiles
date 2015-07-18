CONFIG_FILE(python, ~/.pythonrc)
try:
    import readline
except ImportError:
    pass
else:
    import rlcompleter
    readline.parse_and_bind("tab: complete")

CONFIG_FILE(pip, ~/.pip/pip.conf)
[global]
wheel-dir = ~/.pip/wheelhouse
find-links = ~/.pip/wheelhouse
