////////////////////////////////////////////////////////////////////////////////
//  _____                           _       _    _____      _ _
// |_   _|                         (_)     | |  / ____|    | | |
//   | |  _ __ ___  _ __   ___ _ __ _  __ _| | | |     ___ | | | ___  __ _  ___
//   | | | '_ ` _ \| '_ \ / _ \ '__| |/ _` | | | |    / _ \| | |/ _ \/ _` |/ _ \
//  _| |_| | | | | | |_) |  __/ |  | | (_| | | | |___| (_) | | |  __/ (_| |  __/
// |_____|_| |_| |_| .__/ \___|_|  |_|\__,_|_|  \_____\___/|_|_|\___|\__, |\___|
//                 | |                                                __/ |
//                 |_|                                               |___/
//  _                     _
// | |                   | |
// | |     ___  _ __   __| | ___  _ __
// | |    / _ \| '_ \ / _` |/ _ \| '_ \
// | |___| (_) | | | | (_| | (_) | | | |
// |______\___/|_| |_|\__,_|\___/|_| |_|
//
////////////////////////////////////////////////////////////////////////////////

#include <ac_fixed.h>
#include <iostream>
#include <algorithm>
#include <math/mgc_ac_math.h>
#pragma hls_design top

void RGB_HSV(ac_int<10, false> R_IN,ac_int<10, false> G_IN,ac_int<10, false> B_IN, ac_int<10, true> *H_OUT, ac_int<10, true> *S_OUT, ac_int<10, true> *V_OUT){
        ac_int<10, true> r, g, b, h, s, v, min, max, delta;
        
        if(R_IN > G_IN){
            if(R_IN > B_IN){
                max = R_IN;
            }
            else if(B_IN > R_IN){
                max = B_IN;
            }
        }
        else if(G_IN > B_IN){
            max = G_IN;
        }
        else{
            max = B_IN;
        }
        
        if(R_IN < G_IN){
            if(R_IN < B_IN){
                min = R_IN;
            }
            else if(B_IN < R_IN){
                min = B_IN;
            }
        else if(G_IN < B_IN){
            min = G_IN;
        }
        else{
            max = B_IN;
        }
        
        v = max;
        
        delta = max - min;
        
        if(max != 0){
                s = (int)delta/(int)max;
        }
        else{
            r = g = b = 0;
            s = 0;
            h = -1;
        }
        
        if(r == max){
            h = (g - b)/delta;
        }
        else if(g == max){
            h = 2 + (int)(b - r)/ (int)delta;
        }
        else{
            h = 4 + (r - g)/ delta;
        }
        h = h * 60;
        if(h < 0){
            h = h + 360;
        }
        *H_OUT = h;
        *S_OUT = s;
        *V_OUT = v;        
        
    }
}
// End file

