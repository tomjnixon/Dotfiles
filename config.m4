DEFINE_COMPUTER(LAPTOP)
DEFINE_COMPUTER(WORK_LAPTOP)
DEFINE_COMPUTER(DESKTOP)
DEFINE_COMPUTER(SERVER)
DEFINE_GROUP(MINE, LAPTOP | WORK_LAPTOP | DESKTOP | SERVER)
DEFINE_GROUP(LAPTOPS, LAPTOP | WORK_LAPTOP)
