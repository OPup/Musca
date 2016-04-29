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
	if(((V_IN >= 10) && (S_IN >= 70)) ||((S_IN >= 65) && (V_IN >= 30))){
	    if((H_IN >= 350) || (H_IN <= 13)){
			 r = 1023;
		}
	}
	if(((S_IN >= 30) && (V_IN > 30)) || ((V_IN >= 10) && (S_IN >= 50))){
	    if((H_IN >= 190) && (H_IN <= 260)){
	         b = 1023;
	    }
	}
	     
	R_OUT = r;
	G_OUT = g;
	B_OUT = b;
}

//end file

