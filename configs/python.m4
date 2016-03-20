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

CONFIG_FILE(wheels, ~/.pip/wheels.txt)
numpy
scipy
pandas
enum34
pytest
mock
matplotlib
jupyter
seaborn
pip
virtualenv
wheen
tox

CONFIG_FILE(matplotlib, ~/.config/matplotlib/matplotlibrc)
backend : TkAgg
