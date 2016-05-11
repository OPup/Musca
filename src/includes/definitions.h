#include <iostream>
#include <ac_int.h>

//SIZE definitions
#define ROWS 16
#define COLS 32
#define SCREEN_WIDTH 1280
#define SCREEN_HEIGHT 1024
#define CELL_SIZE 15


//MOVEMENT Definitions
ac_int<3,false>NO_MOVE = 0;
ac_int<3,false>UP = 1;
ac_int<3,false>RIGHT = 2;
ac_int<3,false>DOWN = 3;
ac_int<3,false>LEFT = 4;

//ERROR Definitions
bool NO_ERROR = false;
bool ERROR = true;

//MAZE Definitions
ac_int<3, false>EMPTY_CELL = 0;
ac_int<3, false>WALL = 1;
ac_int<3, false>START_POINT_P1 = 2;
ac_int<3, false>START_POINT_P2 = 3;
ac_int<3, false>END_POINT = 4;
ac_int<3, false>P1 = 5;
ac_int<3, false>P2 = 6;
