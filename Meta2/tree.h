#ifndef tree_h
#define tree_h

#include <stdio.h>
#include <string.h>

typedef struct node {
    char* texto;
    Node* brother;
    Node* child;

} Node;

Node *newNode(char *mensagem);
void addBrother(Node *node1, Node *newNode);
void printTree(Node *node, int level);
void freeTree(Node *node);

#endif