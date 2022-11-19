/* ===================================================================================
	    Compiladores -  Eduardo Figueiredo 2020213717
                        Fábio Santos       2020212310
    ====================================================================================== */

#include "STree.h"

node * newNode(char * var,char * name, int linha, int coluna) {
    node * aux2 = (node *) malloc(sizeof(node));

    aux2->var = var;
    aux2->name = name;
    aux2->brother = NULL;
    aux2->child = NULL;
    aux2->linha = linha;
    aux2->coluna = coluna;

    return aux2;

}

void addBrother(node* old, node* newn) {

    while (old->brother != NULL)
        old = old->brother;

    old->brother = newn;

    return;
}

void printSTree(struct node *node, int prof){
    char pontos [prof * 2];

    for (int i = 0; i < prof * 2; i++){
        pontos[i]='.';
    }
    pontos [2 * prof] = '\0';

    printf("%s%s\n", pontos, node->var);
    if (node->child)    printSTree(node->child, prof + 1);
    if (node->brother)  printSTree(node->brother, prof);

    free(node);
}


void freeSTree(struct node *node){
    if (node->child)    freeSTree(node->child);
    if (node->brother)  freeSTree(node->brother);

    free(node);
}

int numBrothers(struct node * no) {
		int count = 0;
		struct node * aux;
		aux = no;
		while (aux != NULL) {
			aux = aux->brother;
			count++;
		}
		return count;
}



