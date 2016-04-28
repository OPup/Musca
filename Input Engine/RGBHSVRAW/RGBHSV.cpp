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

void HSVRGB(int R_IN, int G_IN, int B_IN, int &H_OUT, int &S_OUT, int &V_OUT){
	float delta, min, max;
	float h, s, v, r, g, b;

	r = (float)R_IN;
	g = (float)G_IN;
	b = (float)B_IN;

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

	v = max*0.39216;

	if(max == min){
		h = 0;
		s = 0;
	}

	else{
		delta = max - min;

		if(max!= 0){
			s = delta/max;
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

	H_OUT = (int)h;
	S_OUT = (int)s*100;
	V_OUT = (int)v;

}

//end file

