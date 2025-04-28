#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <assert.h>

#include "../test-utils.h"
#include "Memoria.h"


void strLength(){
	char* stringVacio = "";

	assert(strLen(stringVacio) == 0);

	char* string1 = "asd";
	
	assert(strLen(string1) == 3);

	char* string2 = "asr";
}

void strCmpTest(){
	
	char* stringVacio = "";
	char* string1 = "asd";
	char* string2 = "asr";

	assert(strCmp(string1, string2) == 1);
	assert(strCmp(string2, string1) == -1);
	assert(strCmp(stringVacio, string1) == 1);
}

int main() {
	char* stringVacio = "";
	char* string1 = "asd";
	char* string2 = "asr";

	assert(strCmp(string1, strClone(string1)) == 0);

	
	
	return 0;
}
