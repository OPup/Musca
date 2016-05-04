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
    
    if(X_pix >= 320 && X_pix <= 960 && Y_pix >= 256 && Y_pix <= 768){
        
        *v_out = (((ac_int<PIXEL_WIDTH, false>)9) << 2*COLOUR_WIDTH) | (((ac_int<PIXEL_WIDTH, false>)5) << COLOUR_WIDTH) | (ac_int<PIXEL_WIDTH, false>)12;
        
    }
    
    else{
    
        *v_out = (((ac_int<PIXEL_WIDTH, false>)15) << 2*COLOUR_WIDTH) | (((ac_int<PIXEL_WIDTH, false>)15) << COLOUR_WIDTH) | (ac_int<PIXEL_WIDTH, false>)15;
       
   }
   
       if(X_pix >= 420 && X_pix <= 860 && Y_pix >= 356 && Y_pix <= 668){
        
        *v_out = (((ac_int<PIXEL_WIDTH, false>)15) << 2*COLOUR_WIDTH) | (((ac_int<PIXEL_WIDTH, false>)15) << COLOUR_WIDTH) | (ac_int<PIXEL_WIDTH, false>)15;
        
    }
    
}


        
     
    
    
/*

void Render(ac_int<PIXEL_WIDTH, false>*v_out){
    
    ac_int<COLOUR_WIDTH, false> red = 0;
    ac_int<COLOUR_WIDTH, false> green = 0;
    ac_int<COLOUR_WIDTH, false> blue = 0;
    
    for( int i = 0; i < HEIGHT; i++){
        
        for( int j = 0; j < WIDTH; j++){
        
            if(j >= (WIDTH) /2){
            
                *v_out = (((ac_int<PIXEL_WIDTH, false>)0) << 2*COLOUR_WIDTH) | (((ac_int<PIXEL_WIDTH, false>)0) << COLOUR_WIDTH) | (ac_int<PIXEL_WIDTH, false>)0;
            
            }
        
            else{
        
        for( int j = 0; j < WIDTH; j++){
        
            if(j >= (WIDTH) /2){
            
                *v_out = (((ac_int<PIXEL_WIDTH, false>)0) << 2*COLOUR_WIDTH) | (((ac_int<PIXEL_WIDTH, false>)0) << COLOUR_WIDTH) | (ac_int<PIXEL_WIDTH, false>)0;
            
            }
        
            else{
            
            *v_out = (((ac_int<PIXEL_WIDTH, false>)15) << 2*COLOUR_WIDTH) | (((ac_int<PIXEL_WIDTH, false>)15) << COLOUR_WIDTH) | (ac_int<PIXEL_WIDTH, false>)15;
            
            }       
        }
    }
}
    
*/   
               
   /* for(int i = 0; i < NUM_OF_PIXELS; i++){
        
        if ( (i % (3200)) == 0 ){
         red = red + 3;
        }
        
        *v_out = (((ac_int<PIXEL_WIDTH, false>)blue) << 2*COLOUR_WIDTH) | (((ac_int<PIXEL_WIDTH, false>)green) << COLOUR_WIDTH) | (ac_int<PIXEL_WIDTH, false>)red;
            
    }
    
*/


        
        


