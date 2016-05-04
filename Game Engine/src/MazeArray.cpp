#include <iostream>
#include <ac_int.h>
#include "includes/definitions.h"

ac_int<4, false> maze[ROWS][COLS];

/*
* ROW - THE ROW ADDRESS
* COL- THE COL ADDRESS
* value - the value you want to write to the array
* write - Read or Write
* OUTPUT - value at the address
*/
void maze(ac_int<5, false>row, ac_int<5, false>col, ac_int<4, false>value, bool write, ac_int<4, false> *OUTPUT){
    if (write == true){ //if write enabled
        maze[row][col] = value; //set the value of the maze equal to the value passed into the block
        *OUTPUT = value; //set the output equal to the value passed into the block.
    }else{
        *OUTPUT = maze[row][col]; //set the output equal to the value of the maze @ ROW & COL
    }
}
