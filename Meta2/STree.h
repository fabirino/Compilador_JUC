#ifndef STREE_H
#define STREE_H

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#define true 1
#define false 0

typedef struct node{
    char * var;
    struct node * brother;
    struct node * child;
}node;

node * newNode(char * var);

void addBrother(node* old, node* newn);

void printSTree(struct node *node, int prof);

void freeSTree(struct node *node);

int numBrothers(struct node * no);

#endif