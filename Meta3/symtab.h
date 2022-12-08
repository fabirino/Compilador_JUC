/* ===================================================================================
        Compiladores -  Eduardo Figueiredo 2020213717
                        Fábio Santos       2020212310
    ====================================================================================== */

#ifndef SYMTAB_H
#define SYMTAB_H

#include "STree.h"
#include "mymath.h"
#include <limits.h>
#include <float.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define DEBUG 0

typedef struct parametros_funcao {
    char *paramType;
    char *paramId;
    int linha;
    int col;
    struct parametros_funcao *next;

} param_list;

// se uma funcao tiver varios paramtype a impressao e feita com virgulas sem espacos
typedef struct simbolo {
    char *name;
    char *type;
    int param; // 0-> param | 1->not param
    struct simbolo *next;
    // opcional
    struct parametros_funcao *methodParams;
    char parametrosString[1024];
} symbol;

typedef struct tabela_simbolos {
    char *name;
    char *type;            // Method/Class
    char parametros[1024]; // Argumentos da funcao se for o caso
    struct simbolo *symbols;
    int comment;

} sym_tab;

typedef struct lista_tabs {
    struct tabela_simbolos *tab;
    struct lista_tabs *next;

} sym_tab_list;

char *getType(char *tipo);

int checkOoB_I(char *numero);

int checkOoB_D(char *numero);

void print_tabs(sym_tab_list *lista);

char *add_symbol(sym_tab *tabela, char *name, char *type, struct parametros_funcao *parametros, struct node *no,int line,int col, int is_param);

sym_tab_list *add_sym_table(sym_tab_list *lista, sym_tab *tabela);

sym_tab_list *create_symbol_tab_list(struct node *raiz);

param_list *create_param_list(param_list *lista, struct node *no,int first);

char *searchType(struct node *no, sym_tab *global, sym_tab *tabela, int altera);

char *callHandler(struct node *no, sym_tab *global, sym_tab *tabela);

char *getTypeOperation(struct node *no, sym_tab *global, sym_tab *tabela, int child);

int searchFunc(struct simbolo *simbolo, sym_tab *global, char *parametrosString);

char *verifyParams(param_list *lista, sym_tab *tabela);

sym_tab *searchTable(char *name, char *parametros, sym_tab_list *lista);

void commentnodes(struct node *raiz, sym_tab *global, sym_tab_list *lista);

sym_tab *create_sym_tab(struct node *no, char *parametros, int is_class);

#endif