#include "tree.h"

Node *newNode(char *mensagem) {
    Node *aux = (Node *)malloc(sizeof(Node));
    aux->texto = mensagem;
    aux->child = NULL;
    aux->brother = NULL;

    return aux;
}

void addBrother(Node *node1, Node *newNode) {
    Node *aux;
    aux = node1;

    while (aux->brother != NULL) {
        aux = aux->brother;
    }
    aux->brother = newNode;
}

void printTree(Node *no, int level) {
    char identation[level * 2];

    for (int i = 0; i < level * 2; i++) {
        identation[i] = '.';
    }
    identation[level * 2] = '\0';

    printf("%s%s\n", identation, no->texto);

    if (no->child)    printTree(no->child, level+1);
    if (no->brother)  printTree(no->brother, level);

    free(no);
}

void freeTree(Node *node){
    if (node->child)    freeTree(node->child);
    if (node->brother)  freeTree(node->brother);

    free(node);
}