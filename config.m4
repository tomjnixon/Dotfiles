DEFINE_COMPUTER(LAPTOP)
DEFINE_COMPUTER(MPC)
DEFINE_COMPUTER(WORK_LAPTOP)
DEFINE_COMPUTER(DESKTOP)
DEFINE_COMPUTER(SERVER)
DEFINE_GROUP(MINE, MPC | LAPTOP | WORK_LAPTOP | DESKTOP | SERVER)
DEFINE_GROUP(LAPTOPS, MPC | LAPTOP | WORK_LAPTOP)
DEFINE_GROUP(UBUNTU, 0)
DEFINE_GROUP(NIX, ifdef(`USING_NIX', 1, 0))
