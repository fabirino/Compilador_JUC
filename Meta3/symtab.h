/* ===================================================================================
	    Compiladores -  Eduardo Figueiredo 2020213717
                        Fábio Santos       2020212310
    ====================================================================================== */

#ifndef SYMTAB_H
#define SYMTAB_H

#include <stdio.h>
#include <string.h>
#include "STree.h"

typedef struct parametros_funcao{
    char *paramType;
    param_list *next;

} param_list;

// se uma funcao tiver varios paramtype a impressao e feita com virgulas sem espacos
typedef struct simbolo{
    char * name;
    char * type;
    int param; // 0-> param | 1->not param

    // opcional
    param_list *paramTypes;
} symbol;

typedef struct lista_simbolos{
    symbol *atual;
    sym_list *next;

} sym_list;

typedef struct tabela_simbolos{
    char * name;
    char * type; // Method/Class
    sym_list *symbols;

} sym_tab;

typedef struct lista_tabs {
    sym_tab *tab;
    sym_tab_list *next;

} sym_tab_list;


void print_tabs(sym_tab_list *lista);


#endif