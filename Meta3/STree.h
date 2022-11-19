/* ===================================================================================
	    Compiladores -  Eduardo Figueiredo 2020213717
                        Fábio Santos       2020212310
    ====================================================================================== */
    
#ifndef STREE_H
#define STREE_H

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

typedef struct node{
    char * var; 
    char * name;
    int linha;
    int coluna;
    struct node * brother;
    struct node * child;
}node;

node * newNode(char * var, char * name, int linha, int coluna);

void addBrother(node* old, node* newn);

void printSTree(struct node *node, int prof);

void freeSTree(struct node *node);

int numBrothers(struct node * no);

#endif