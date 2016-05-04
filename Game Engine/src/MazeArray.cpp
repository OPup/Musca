#include <iostream>
#include <ac_int.h>
#include "includes/definitions.h"

ac_int<4, false> maze[ROWS * COLS];

void MazeMemory(ac_int<5, false> row, ac_int<5, false>col, ac_int<4, false>val, bool write, ac_int<4, false> *out, bool init){
    if(!init){
         if (write){
            maze[ROWS * row + col] = val;
            *out = val;
         }else{
            *out = maze[ROWS * row + col];
        }
    }else{
        
    }
    
}
