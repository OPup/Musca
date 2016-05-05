#include <iostream>
#include <ac_int.h>
#include "includes/definitions.h"

#define COLOUR_WIDTH 4
#define PIXEL_WIDTH COLOUR_WIDTH * 3

void Counter(ac_int<5, false>*row_count, ac_int<5, false>*col_count){
    
    for( int i = 0; i < ROWS; i++){
        
        for( int j = 0; j < COLS; j++){
            
            *col_count = j;
            
            *row_count = i;
            
        }
        
    }
     
}


        
     