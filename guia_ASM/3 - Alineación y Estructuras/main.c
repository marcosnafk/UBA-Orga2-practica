#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <assert.h>

#include "../test-utils.h"
#include "Estructuras.h"

uint32_t *secuencia(uint32_t n){
    uint32_t *arr = malloc(n * sizeof(uint32_t));

    if (arr == NULL) {
        return NULL;
    }

    for(uint32_t i = 0; i < n; i++)
        arr[i] = i;

    return arr;
}

void testListaEnlazada(){
    uint32_t *arreglo1 = secuencia(3);
    uint32_t *arreglo2 = secuencia(2);

	// uint32_t cantidad_total_de_elementos(lista_t *lista);
	lista_t* lista = malloc(sizeof(lista_t));

	nodo_t* nodo1 = malloc(sizeof(nodo_t));
	nodo_t* nodo2 = malloc(sizeof(nodo_t));

	assert(cantidad_total_de_elementos(lista) == 0);

	lista->head = nodo1;

	assert(cantidad_total_de_elementos(lista) == 1);
	
	nodo1->next = nodo2;
	nodo1->categoria = 1;
	nodo1->arreglo = arreglo1;
	nodo1->longitud = 3;
	
	nodo2->categoria = 2;
	nodo2->arreglo = arreglo2;
	nodo2->longitud = 2;


	assert(cantidad_total_de_elementos(lista) == 2);

	free(nodo1->arreglo);
	free(nodo1);
	free(nodo2->arreglo);
	free(nodo2);
	free(lista);
}

int main() {

uint32_t cantidad_total_de_elementos_packed(packed_lista_t *lista);
	testListaEnlazada();


	packed_lista_t* lista = malloc(sizeof(packed_lista_t));
	lista->head = NULL;
	packed_nodo_t* nodo1 = malloc(sizeof(packed_nodo_t));
	packed_nodo_t* nodo2 = malloc(sizeof(packed_nodo_t));
	
	assert(cantidad_total_de_elementos_packed(lista) == 0);

	nodo1->categoria = 1;
	nodo1->arreglo = secuencia(2);
	nodo1->longitud = 2;
	nodo1->next = NULL;

	lista->head = nodo1;

	assert(cantidad_total_de_elementos_packed(lista) == 1);

	nodo1->next =  nodo2;
	nodo2->categoria = 2;
	nodo2->arreglo = secuencia(3);
	nodo2->longitud = 3;
	nodo2->next = NULL;

	assert(cantidad_total_de_elementos_packed(lista) == 2);

	free(nodo1->arreglo);
	free(nodo1);
	free(nodo2->arreglo);
	free(nodo2);
	free(lista);

	return 0;
}
