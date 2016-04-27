/*
 * cdt.cpp
 *
 *  Created on: 27 Apr 2016
 *      Author: owen
 */


#include <iostream>

using namespace std;

void cdt(int H_IN, int S_IN, int V_IN, int &R_OUT, int &G_OUT, int &B_OUT){
	int r,g,b;
	r = g = b = 0;
	if((H_IN >= 350) || (H_IN <= 10)){
		if((S_IN >= 70) && (V_IN >= 70)){
			g = 1023;
		}
	}
	R_OUT = r;
	G_OUT = g;
	B_OUT = b;
}


int main(){
	int H_IN = 0;
	int S_IN = 100;
	int V_IN = 100;

	int R_OUT, G_OUT, B_OUT;

	cdt(H_IN,S_IN,V_IN,R_OUT,G_OUT,B_OUT);

	cout << "R: " << R_OUT << " G: " << G_OUT << " B: " << B_OUT << endl;


	return 0;
}
