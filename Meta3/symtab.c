/* ===================================================================================
        Compiladores -  Eduardo Figueiredo 2020213717
                        Fábio Santos       2020212310
    ====================================================================================== */

#include "symtab.h"

void print_tabs(sym_tab_list *lista) {
    printf("1\n");
    sym_tab_list *aux_table_list = lista;
    printf("2\n");
    while (aux_table_list != NULL) {
        printf("Entrei no WHILE\n");
        sym_tab *aux_tab = aux_table_list->tab;
        symbol *aux_sym_list = aux_tab->symbols;

        printf("===== %s %s Symbol Table =====\n", aux_tab->type, aux_tab->name);

        while (aux_sym_list != NULL) {
            param_list *paramTypes = aux_sym_list->paramTypes;

            if (paramTypes != NULL) {
                char parametros[256];
                int count = 1;

                // Verificar se ha mais do que um argumento na funcao para meter virgulas entre eles
                while (paramTypes != NULL) {
                    count++;
                    paramTypes = paramTypes->next;
                }

                count = 1;
                paramTypes = aux_sym_list->paramTypes;
                // So ha um argumento
                if (count < 2) {
                    strcpy(parametros, paramTypes->paramType);

                    // ha mais que um argumento
                } else {
                    while (paramTypes != NULL) {
                        strcat(parametros, paramTypes->paramType);
                        if (count > 1)
                            strcat(parametros, ",");
                        count++;
                        paramTypes = paramTypes->next;
                    }
                }

                if (aux_sym_list->param) {
                    printf("%s\t(%s)\t%s\tparam", aux_sym_list->name, parametros, aux_sym_list->type);
                } else {
                    printf("%s\t(%s)\t%s", aux_sym_list->name, parametros, aux_sym_list->type);
                }

            } else {
                if (aux_sym_list->param) {
                    printf("%s\t%s\tparam", aux_sym_list->name, aux_sym_list->type);
                } else {
                    printf("%s\t%s", aux_sym_list->name, aux_sym_list->type);
                }
            }

            aux_sym_list = aux_sym_list->next;
        }

        aux_table_list = aux_table_list->next;
    }
}

symbol *add_symbol(sym_tab *tabela, char *name, char *type, int is_param) {
    symbol *aux = (symbol *)malloc(sizeof(symbol));
    aux->name = name;
    aux->type = type;
    aux->param = is_param;
    aux->paramTypes = NULL; // TODO:

    // Adicionar o simbolo ao ultimo
    symbol * lista_simbolos = tabela->symbols;
    while(lista_simbolos){
        lista_simbolos = lista_simbolos->next;
        printf("while add_symbol\n");
    }

    aux->next = NULL;
    lista_simbolos = aux;

    return aux;
}

sym_tab_list *add_sym_table(sym_tab_list *lista, sym_tab *tabela) {
    sym_tab_list *aux = lista;
    
    while (aux !=NULL) {
        aux = aux->next;
        printf("while add_sym_table\n");
    }
    aux = (sym_tab_list *)malloc(sizeof(sym_tab_list));

    aux->tab = tabela;
    aux->next = NULL;

    return lista;
}

sym_tab *create_sym_tab(struct node * no, int is_class){
    sym_tab *symbol_table = (sym_tab *) malloc(sizeof(sym_tab));
    symbol_table->name = no->name;
    symbol_table->symbols = NULL;

    if(is_class) symbol_table->type = "Class";
    else         symbol_table->type = "Method";
    
    return symbol_table;
}

sym_tab_list *create_symbol_tab_list(struct node *raiz) {
    sym_tab_list * table_list = NULL;
    sym_tab *global = create_sym_tab(raiz->child, 1);
    add_sym_table(table_list, global);
    
    // Pode ser MethodDecl ou FieldDecl
    node *methodOrField = raiz->child->brother;
    while (methodOrField) {
        print_tabs(table_list);
        printf("Entrou no while \"create_symbol_tab_list\"\n");
        if (!strcmp(methodOrField->var, "FieldDecl")) {
            printf("FieldDecl\n");
            // Variaveis globais
            add_symbol(global,methodOrField->child->brother->name,methodOrField->child->var,0);
            printf("ADD_FieldDecl\n");


        } else if (!strcmp(methodOrField->var, "MethodDecl")) {
            // Declaracao de funcoes
            sym_tab *tabela = create_sym_tab(methodOrField, 0);
            
            add_sym_table(table_list, tabela);
        }

        methodOrField = methodOrField->brother;
    }
    printf("FIM_CREATE_SYMBOL_TABLE_LIST\n");
    return table_list;
}
