/*
 * RGBHSV.cpp
 *
 *  Created on: 27 Apr 2016
 *      Author: owen
 */

//This code is to convert an RGB value to a HSV value

#include <ac_fixed.h>
#include <iostream>
#include <algorithm>
#include <math/mgc_ac_math.h>
#pragma hls_design_top
#define percent 100;

void HSVRGB(ac_fixed<10, 10, false> r, ac_fixed<10, 10, false>  g, ac_fixed<10, 10, false>  b, ac_fixed<10, 10, false, AC_RND> &H_OUT, ac_fixed<10, 10, false, AC_RND> &S_OUT, ac_fixed<10, 10, false, AC_RND> &V_OUT){
	ac_fixed<10, 10, false> delta, min, max;
	ac_fixed<14, 8, false> v;
	ac_fixed<16, 8, false> s; 
    ac_fixed<14, 11, true> h;
	ac_fixed<10,1, false> val;
	val = 0.39216;
	
	if(r >= g){
		if(r >= b){
			max = r;
		}
		else if(b >= r){
			max = b;
		}
	}
	else if(g >= b){
		max = g;
	}
	else{
		max = b;
	}

	if(r <= g){
		if(r <= b){
			min = r;
		}
		else if(b <= r){
			min = b;
		}
	}
	else if(g <= b){
		min = g;
	}
	else{
		min = b;
	}

	v = max*val;
	
	delta = max - min;

	if(delta == 0){
		h = 0;
		s = 0;
	}
	else{
		if(max!= 0){
			s = delta/max;
		}
		else{
			r = g = b = 0;
			s = 0;
		}

		if(r == max){
			h = (g - b)/delta;
		}
		else if(g == max){
			h = 2 + (b - r)/delta;
		}
		else{
			h = 4 + (r - g)/delta;
		}

		h = h * 60;
		if(h < 0){
			h = h + 360;
		}
	}

	H_OUT = h;
	S_OUT = s*percent;
	V_OUT = v;

}

//end file

