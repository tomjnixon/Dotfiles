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
ADD_TO_SCRIPT(mkdir -p env(HOME)/.pip/wheelhouse)
wheel-dir = env(HOME)/.pip/wheelhouse
find-links = env(HOME)/.pip/wheelhouse

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
wheel
tox
sympy
scikit-learn
requests
flake8
ansible
fabric
git+http://github.com/tomjnixon/ssh-key.git

CONFIG_FILE(matplotlib, ~/.config/matplotlib/matplotlibrc)
backend : TkAgg
