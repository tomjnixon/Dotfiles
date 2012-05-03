CONFIG_FILE(python, ~/.pythonrc)
try:
    import readline
except ImportError:
    pass
else:
    import rlcompleter
    readline.parse_and_bind("tab: complete")
                

def c(*args):
	return reduce(lambda a, b: (lambda arg: a(b(arg))), reversed(args))
