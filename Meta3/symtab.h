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
    struct parametros_funcao *next;

} param_list;

// se uma funcao tiver varios paramtype a impressao e feita com virgulas sem espacos
typedef struct simbolo{
    char * name;
    char * type;
    int param; // 0-> param | 1->not param
    struct simbolo *next;
    // opcional
    struct parametros_funcao *paramTypes;
} symbol;

typedef struct tabela_simbolos{
    char * name;
    char * type; // Method/Class
    symbol *symbols;

} sym_tab;

typedef struct lista_tabs {
    sym_tab *tab;
    struct lista_tabs *next;

} sym_tab_list;


void print_tabs(sym_tab_list *lista);

symbol *add_symbol(sym_tab *tabela, char *name, char *type, int is_param);

sym_tab_list *add_sym_table(sym_tab_list *lista, sym_tab *tabela);

sym_tab_list *create_symbol_tab_list(struct node * raiz);

sym_tab *create_sym_tab(struct node * no, int is_class);

#endif