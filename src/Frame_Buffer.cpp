#include <iostream>
#include <ac_int.h>
#include "includes/definitions.h"

ac_int<4, false> data[SCREEN_WIDTH * SCREEN_HEIGHT];

void FrameBuffer(ac_int<11, false>row, ac_int<10, false>col, ac_int<4, false>data_in, bool write, ac_int<4, false>*out){
    if(write){
        data[ROWS * row + col] = data_in;
        *out = data_in;
    }else{
        *out = data[ROWS * row + col];
    }
}
