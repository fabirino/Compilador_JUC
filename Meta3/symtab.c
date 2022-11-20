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
        printf("Entrei no WHILE \"print_tabs\"\n");
        sym_tab *aux_tab = aux_table_list->tab;
        symbol *aux_sym_list = aux_tab->symbols;

        printf("===== %s %s Symbol Table =====\n", aux_tab->type, aux_tab->name);

        while (aux_sym_list != NULL) {
            param_list *methodParams = aux_sym_list->methodParams;

            if (methodParams != NULL) {
                char parametros[256];
                int count = 1;

                // Verificar se ha mais do que um argumento na funcao para meter virgulas entre eles
                while (methodParams != NULL) {
                    count++;
                    methodParams = methodParams->next;
                }

                count = 1;
                methodParams = aux_sym_list->methodParams;
                // So ha um argumento
                if (count < 2) {
                    strcpy(parametros, methodParams->paramType);

                    // ha mais que um argumento
                } else {
                    while (methodParams != NULL) {
                        strcat(parametros, methodParams->paramType);
                        if (count > 1)
                            strcat(parametros, ",");
                        count++;
                        methodParams = methodParams->next;
                    }
                }

                if (aux_sym_list->param) {
                    printf("%s\t(%s)\t%s\tparam\n", aux_sym_list->name, parametros, aux_sym_list->type);
                } else {
                    printf("%s\t(%s)\t%s\n", aux_sym_list->name, parametros, aux_sym_list->type);
                }

            } else {
                if (aux_sym_list->param) {
                    printf("%s\t%s\tparam\n", aux_sym_list->name, aux_sym_list->type);
                } else {
                    printf("%s\t%s\n", aux_sym_list->name, aux_sym_list->type);
                }
            }

            aux_sym_list = aux_sym_list->next;
        }

        aux_table_list = aux_table_list->next;
    }
}

void add_symbol(sym_tab *tabela, char *name, char *type, int is_param) {
    symbol *aux = (symbol *)malloc(sizeof(symbol));
    aux->name = name;
    aux->type = type;
    aux->param = is_param;
    aux->methodParams = NULL; // TODO: adicionar os parametros da funcao que estao no MethodParams
    aux->next = NULL;
    symbol * lista_simbolos = tabela->symbols;
    if(lista_simbolos == NULL){
        // printf("NULL \"add_symbol\"\n");
        tabela->symbols = (symbol *)malloc(sizeof(symbol));
        tabela->symbols = aux;
        tabela->symbols->next = NULL;
    }
    // Adicionar o simbolo ao ultimo da lista
    else{
        // printf("%s -->add_symbol\n",tabela->name);
        while(lista_simbolos->next !=NULL){ 
            // printf("WHILE \"add_symbol\"\n");
            lista_simbolos = lista_simbolos->next;
        }
        lista_simbolos->next = (symbol *)malloc(sizeof(symbol));
        lista_simbolos->next = aux;
    }
}

sym_tab_list *add_sym_table(sym_tab_list *lista, sym_tab *tabela) {
    sym_tab_list *aux = lista;
    if(aux == NULL) {
        lista = (sym_tab_list*)malloc (sizeof(sym_tab_list));
        lista->tab = tabela;
        lista->next = NULL;
    }else{
        while (aux->next !=NULL) {
            aux = aux->next;
        }
        aux->next = (sym_tab_list*)malloc (sizeof(sym_tab_list));
        aux->next->tab = tabela;
        aux->next->next = NULL;
    }

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
    printf("%s\n",global->name);
    table_list = add_sym_table(table_list, global);
    // printf("1\n");
    // printf("%s\n",table_list->tab->name);
    
    // Pode ser MethodDecl ou FieldDecl
    node *methodOrField = raiz->child->brother;
    while (methodOrField) {
        // print_tabs(table_list);
        if (!strcmp(methodOrField->var, "FieldDecl")) {
            printf("FieldDecl\n");
            // Variaveis globais
            add_symbol(global,methodOrField->child->brother->name,methodOrField->child->var,0);
            printf("ADD_FieldDecl\n");


        } else if (!strcmp(methodOrField->var, "MethodDecl")) {
            
            // while(methodOrField->brother){ =====
            // Contem o nome da funcao
            if(!strcmp(methodOrField->child->var, "MethodHeader")){
                // char * param;
                
                // // Parametros da funcao
                // if(!strcmp(methodOrField->child->child->brother->var, "MethodParams")){
                //     // parametros = node ParamDecl
                //     struct node * parametros = methodOrField->child->child->brother->child;
                //     struct  parametros_funcao *lista_parametros = (parametros_funcao *)malloc(sizeof(parametros_funcao));
                //     while(parametros){
                //         // Adicionar os parametros da funcao ao nome
                //         if(!strcmp(parametros->child, "StringArray")){
                //             strcat(param,"String[]");
                //         }else if(!strcmp(parametros->child, "Void")){
                //             strcat(param,"void");
                //         }else if(!strcmp(parametros->child, "Int")){
                //             strcat(param,"int");
                //         }else if(!strcmp(parametros->child, "Bool")){
                //             strcat(param,"bool");
                //         }else if(!strcmp(parametros->child, "Double")){
                //             strcat(param,"double");
                //         }

                //         parametros = parametros->brother;
                //     }
                //     char * name;
                //     strcat(name,methodOrField->child->child->brother);
                //     sym_tab *tabela = create_sym_tab(,  0);
                // }


                sym_tab *tabela = create_sym_tab(methodOrField,  0);
            }
            
            
            // Declaracao de funcoes
            printf("MethodDecl\n");
            sym_tab *tabela = create_sym_tab(methodOrField, 0);
            printf("MethodDecl -> create_sym_tab\n");
            table_list = add_sym_table(table_list, tabela);
            printf("MethodDecl -> add_sym_table\n");
            //     methodOrField = methodOrField->brother;
            // } =======
            
        }

        methodOrField = methodOrField->brother;
    }
    // printf("FIM_CREATE_SYMBOL_TABLE_LIST\n");
    return table_list;
}
