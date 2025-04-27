#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <assert.h>

#include "../test-utils.h"
#include "ABI.h"

int main() {
	/* Acá pueden realizar sus propias pruebas */
	//assert(alternate_sum_4_using_c(8, 2, 5, 1) == 10);

	//assert(alternate_sum_4_using_c_alternative(8, 2, 5, 1) == 10);

	assert(alternate_sum_8(10, 6, 8, 2, 8, 2, 10, 2) == 24);

	uint32_t* destination = malloc(sizeof(uint32_t));
	float x3 = 1.5;
	product_2_f(destination, 10, x3);
	assert( *destination == 15);
	free(destination);

	double* destinationDouble = malloc(sizeof(double));
	product_9_f(destinationDouble,
		825, 998.41, 
		922, 468.25, 
		769, 773.30,
		23, 635.85, 
		472, 94.86, 
		755, 535.01, 
		40, 838.15, 
		125, 486.42, 
		396, 511.67);
	assert( *destinationDouble == (double)23101138353124374575908101359074696670140694528.00);
	free(destinationDouble);
	
	return 0;
}
