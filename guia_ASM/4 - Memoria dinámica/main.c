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
	char* string1 = "sar";
	char* string2 = "23";

	assert(strCmp(string1, string2) == -1);
	assert(strCmp(string2, string1) == 1);
	assert(strCmp(stringVacio, string1) == 1);
}

void testClone(){
	char* stringVacio = "";
	char* string1 = "asd";
	char* string2 = "asr";

	assert(strCmp(string1, strClone(string1)) == 0);
}

typedef struct cualquiera_s {
	char as;
	uint16_t ad;
	char ab;
	char ac;
} cualquiera_t;

void testFreeString(){
	char* stringVacio = malloc(sizeof(char*));

	strDelete(stringVacio);

	assert(stringVacio == NULL);
}

typedef struct funcioneDeMatriz_s{
	int32_t (*funX)(int32_t);
	int16_t minimoValor;
} funcioneDeMatriz_t;

int32_t unaFuncion(int32_t algo){
	return -10;
}

int main() {
	strCmpTest();

	return 0;
}
