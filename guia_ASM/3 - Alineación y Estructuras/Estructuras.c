#include "Estructuras.h"

uint32_t tamanioLista_c(lista_t* lista){
    uint32_t tamanio = 0;

    nodo_t* nodo = lista->head;
    while(nodo != NULL){
        tamanio++;
        nodo = nodo->next;
    }

    return tamanio;
}
