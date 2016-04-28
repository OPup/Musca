/*
 * cdt.cpp
 *
 *  Created on: 27 Apr 2016
 *      Author: owen
 */


#include <iostream>
#include <ac_fixed.h>
#pragma hls_design_top

void cdt(ac_int<10, false> H_IN, ac_int<10, false> S_IN, ac_int<10, false> V_IN, ac_int<10, false> &R_OUT, ac_int<10, false> &G_OUT, ac_int<10, false> &B_OUT){
	ac_int<10, false> r,g,b;
	r = g = b = 0;
	if((H_IN >= 340) || (H_IN <= 50)){
		if((S_IN >= 80)){
			g = 1023;
		}
	}
	R_OUT = r;
	G_OUT = g;
	B_OUT = b;
}

//end file

