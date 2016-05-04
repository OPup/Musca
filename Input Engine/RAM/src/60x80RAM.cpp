#include <iostream>
#include <ac_int.h>

#define ROWS 60
#define COLS 80

ac_int<2, false> data[ROWS * COLS];

void RAM_BLOCK(ac_int<5, false>row, ac_int<6, false>col, ac_int<2, false>data_in, bool write, ac_int<2, false> *data_out){
    if(write){
        data[ROWS * row + col] = data_in;
        *data_out = data_in;
    }else{
        *data_out = data[ROWS * row + col];
    }
}
