#ifndef tree_h
#define tree_h

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

typedef struct node {
    char* texto;
    struct node* brother;
    struct node* child;

} Node;

Node *newNode(char *mensagem);

void addBrother(Node *node1, Node *newNode);

void printTree(Node *node, int level);

void freeTree(Node *node);

#endif