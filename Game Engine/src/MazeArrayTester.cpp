#include <iostream>
#include <ac_int.h>
#include "includes/definitions.h"

bool written = false;

void MazeArrayTester(ac_int<5, false> *row, ac_int<5, false> *col, ac_int<4, false> *out, bool *write){
    if(!written){
        *write = true;
        for(int i = 0; i < ROWS; i++){
            for(int j = 0; j < COLS; j++){
                *row = (ac_int<4, false>)i;
                *col = (ac_int<4, false>)j;
                if(j == 0 || j == COLS - 1){
                    *out = WALL;
                }else if (i == 0 || i == ROWS - 1){
                    *out = WALL;
                }else{
                    *out = EMPTY_CELL;
                }
            }
        }   
        written = true;
    }else{
        *write = false;
    }
    
}
