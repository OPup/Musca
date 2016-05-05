#include <iostream>
#include <ac_int.h>

#define COLOUR_WIDTH 4
#define PIXEL_WIDTH COLOUR_WIDTH * 3

#define WIDTH 1280
#define HEIGHT 1024
#define NUM_OF_PIXELS WIDTH*HEIGHT

void Render(ac_int<11, false>X_pix, ac_int<11, false>Y_pix, ac_int<PIXEL_WIDTH, false>*v_out){
    
    ac_int<COLOUR_WIDTH, false> red = 0;
    ac_int<COLOUR_WIDTH, false> green = 0;
    ac_int<COLOUR_WIDTH, false> blue = 0;
    
    *v_out = (((ac_int<PIXEL_WIDTH, false>)13) << 2*COLOUR_WIDTH) | (((ac_int<PIXEL_WIDTH, false>)7) << COLOUR_WIDTH) | (ac_int<PIXEL_WIDTH, false>)3;   
    
    
    if(X_pix >= 30 && X_pix <= 625 && Y_pix >= 30 && Y_pix <= 354){
        
        *v_out = (((ac_int<PIXEL_WIDTH, false>)15) << 2*COLOUR_WIDTH) | (((ac_int<PIXEL_WIDTH, false>)15) << COLOUR_WIDTH) | (ac_int<PIXEL_WIDTH, false>)15;
    }
    
    if(X_pix >= 655 && X_pix <= 1250 && Y_pix >= 30 && Y_pix <= 354){
        
        *v_out = (((ac_int<PIXEL_WIDTH, false>)15) << 2*COLOUR_WIDTH) | (((ac_int<PIXEL_WIDTH, false>)15) << COLOUR_WIDTH) | (ac_int<PIXEL_WIDTH, false>)15;
    }
    
    if(X_pix >= 30 && X_pix <= 1250 && Y_pix >= 414 && Y_pix <= 994){
        
        *v_out = (((ac_int<PIXEL_WIDTH, false>)15) << 2*COLOUR_WIDTH) | (((ac_int<PIXEL_WIDTH, false>)15) << COLOUR_WIDTH) | (ac_int<PIXEL_WIDTH, false>)15;
    }
    
}


        
     
    
    



