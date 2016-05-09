#include <iostream>
#include <ac_int.h>
#include "includes/definitions.h"

ac_int<3, false>data[ROWS * COLS];

void RAMBlock(ac_int<5, false>row, ac_int<5, false>col, bool write_en, ac_int<3, false> data_in, ac_int<3, false> *data_out){
    if (write_en){
        data[ROWS * row + col] = data_in;
        *data_out = data_in;   
    }else{
        *data_out = data[ROWS * row + col];
    }
}