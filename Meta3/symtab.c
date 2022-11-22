/* ===================================================================================
        Compiladores -  Eduardo Figueiredo 2020213717
                        Fábio Santos       2020212310
    ====================================================================================== */

#include "symtab.h"

char *getType(char *tipo) {
    char *string;

    if (!strcmp(tipo, "StringArray")) {
        string = "String[]";
    } else if (!strcmp(tipo, "Void")) {
        string = "void";
    } else if (!strcmp(tipo, "Int")) {
        string = "int";
    } else if (!strcmp(tipo, "Bool")) {
        string = "boolean";
    } else if (!strcmp(tipo, "Double")) {
        string = "double";
    }

    return string;
}

void print_tabs(sym_tab_list *lista) {

    sym_tab_list *aux_table_list = lista;
    while (aux_table_list != NULL) {
        // printf("Entrei no WHILE \"print_tabs\"\n");
        sym_tab *aux_tab = aux_table_list->tab;
        symbol *aux_sym_list = aux_tab->symbols;

        if (aux_tab->parametros != NULL) {
            printf("===== %s %s%s Symbol Table =====\n", aux_tab->type, aux_tab->name, aux_tab->parametros);
        } else {
            printf("===== %s %s Symbol Table =====\n", aux_tab->type, aux_tab->name);
        }

        while (aux_sym_list != NULL) {
            param_list *methodParams = aux_sym_list->methodParams;

            if (methodParams != NULL) {

                if (aux_sym_list->param) {
                    // printf("parametrostoString\"print\" -> %s\n", aux_sym_list->parametrosString); // DEBUG:
                    printf("%s\t%s\t%s\tparam\n", aux_sym_list->name, aux_sym_list->parametrosString, aux_sym_list->type);
                } else {
                    // printf("parametrostoString\"print\" -> %s\n", aux_sym_list->parametrosString); // DEBUG:
                    printf("%s\t%s\t%s\n", aux_sym_list->name, aux_sym_list->parametrosString, aux_sym_list->type);
                }

            } else {
                if (aux_sym_list->param) {
                    printf("%s\t\t%s\tparam\n", aux_sym_list->name, aux_sym_list->type);
                } else {
                    printf("%s\t\t%s\n", aux_sym_list->name, aux_sym_list->type);
                }
            }

            aux_sym_list = aux_sym_list->next;
        }

        aux_table_list = aux_table_list->next;
        printf("\n");
    }
}

char *add_symbol(sym_tab *tabela, char *name, char *type, struct parametros_funcao *parametros, int is_param) {
    symbol *aux = (symbol *)malloc(sizeof(symbol));
    aux->name = name;
    aux->type = type;
    aux->param = is_param;
    aux->methodParams = parametros;
    aux->next = NULL;
    strcpy(aux->parametrosString, "");
    char string[1024];
    char *string2 = NULL;

    // Colocar string com os argumentos da funcao
    param_list *methodParams = parametros;
    if (methodParams != NULL) {

        strcpy(string, "(");
        if (strcmp(methodParams->paramType, "Vazio")) {

            int count = 0;
            // Verificar se ha mais do que um argumento na funcao para meter virgulas entre eles
            while (methodParams != NULL) {
                count++;
                methodParams = methodParams->next;
            }

            methodParams = parametros;
            // So ha um argumento
            if (count < 1) {
                strcat(string, methodParams->paramType);
                // ha mais que um argumento
            } else {
                while (methodParams != NULL) {
                    strcat(string, methodParams->paramType);
                    if (count > 1)
                        strcat(string, ",");
                    count--;
                    methodParams = methodParams->next;
                }
            }
        }
        strcat(string, ")");

        strcpy(aux->parametrosString, string);

        string2 = (char *)malloc(sizeof(string));
        string2 = &string[0];
        printf("STRING 2 -> %s\n", string2); // DEBUG:
        // aux->parametrosString = string;

        printf("--->%s\"<---\n", string); // DEBUG:
    }

    symbol *lista_simbolos = tabela->symbols;
    if (lista_simbolos == NULL) {
        // printf("NULL \"add_symbol\"\n");
        tabela->symbols = (symbol *)malloc(sizeof(symbol));
        tabela->symbols = aux;
        tabela->symbols->next = NULL;
    }
    // Adicionar o simbolo ao ultimo da lista
    else {
        // printf("%s -->add_symbol\n",tabela->name);
        while (lista_simbolos->next != NULL) {
            // printf("WHILE \"add_symbol\"\n");
            lista_simbolos = lista_simbolos->next;
        }
        lista_simbolos->next = (symbol *)malloc(sizeof(symbol));
        lista_simbolos->next = aux;
    }
    string2 = &string[0];
    return string2;
}

sym_tab_list *add_sym_table(sym_tab_list *lista, sym_tab *tabela) {
    sym_tab_list *aux = lista;
    if (aux == NULL) {
        lista = (sym_tab_list *)malloc(sizeof(sym_tab_list));
        lista->tab = tabela;
        lista->next = NULL;
    } else {
        while (aux->next != NULL) {
            aux = aux->next;
        }
        aux->next = (sym_tab_list *)malloc(sizeof(sym_tab_list));
        aux->next->tab = tabela;
        aux->next->next = NULL;
    }

    return lista;
}

sym_tab *create_sym_tab(struct node *no, char *parametros, int is_class) {
    sym_tab *symbol_table = (sym_tab *)malloc(sizeof(sym_tab));

    symbol_table->name = no->name;

    symbol_table->symbols = NULL;
    symbol_table->parametros = parametros;

    if (is_class)
        symbol_table->type = "Class";
    else
        symbol_table->type = "Method";

    return symbol_table;
}

param_list *create_param_list(param_list *lista, char *tipo) {

    param_list *lista_parametros = lista;
    if (lista_parametros == NULL) {
        // printf("NULL \"add_symbol\"\n");
        lista = (struct parametros_funcao *)malloc(sizeof(struct parametros_funcao));
        lista->paramType = tipo;
        lista->next = NULL;
    }
    // Adicionar o simbolo ao ultimo da lista
    else {
        while (lista_parametros->next != NULL) {
            // printf("%s -->create_param_list\n", lista_parametros->paramType);
            lista_parametros = lista_parametros->next;
        }
        lista_parametros->next = (struct parametros_funcao *)malloc(sizeof(struct parametros_funcao));
        lista_parametros->next->paramType = tipo;
        lista_parametros->next->next = NULL;
    }
    return lista;
}

sym_tab_list *create_symbol_tab_list(struct node *raiz) {
    sym_tab_list *table_list = NULL;
    sym_tab *global = create_sym_tab(raiz->child, NULL, 1);
    printf("%s\n", global->name);
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
            add_symbol(global, methodOrField->child->brother->name, getType(methodOrField->child->var), NULL, 0);
            printf("ADD_FieldDecl\n");

        } else if (!strcmp(methodOrField->var, "MethodDecl")) {
            printf("MethodDecl\n");
            // while(methodOrField->brother){ =====
            // Contem o nome da funcao
            if (!strcmp(methodOrField->child->var, "MethodHeader")) {
                printf("MethodHeader\n");
                // Parametros da funcao
                struct node *MP = methodOrField->child->child->brother->brother;
                if (!strcmp(MP->var, "MethodParams")) {

                    struct node *parametros = MP->child; // parametros = node "ParamDecl"
                    struct parametros_funcao *lista_parametros = (struct parametros_funcao *)malloc(sizeof(struct parametros_funcao));
                    lista_parametros = NULL;
                    if (parametros) {
                        while (parametros) {
                            //==================
                            printf("MethodParams\n");
                            lista_parametros = create_param_list(lista_parametros, getType(parametros->child->var));
                            // printf("%s -> %s\n",methodOrField->child->child->brother->name,getType(parametros->child->var));

                            //====================
                            parametros = parametros->brother;
                        }
                    } else {
                        lista_parametros = (struct parametros_funcao *)malloc(sizeof(struct parametros_funcao));
                        lista_parametros->paramType = "Vazio";
                        lista_parametros->next = NULL;
                    }
                    // printf("Parametro Func -> %s\n",lista_parametros->paramType);//QUESTION: pq n tenho acesso a lista aqui??
                    char parametrosString[1024];
                    strcpy(parametrosString, add_symbol(global, methodOrField->child->child->brother->name, getType(methodOrField->child->child->var), lista_parametros, 0));
                    printf("param --->%s\n", parametrosString);
                    // char *parametrosString = add_symbol(global, methodOrField->child->child->brother->name, getType(methodOrField->child->child->var), lista_parametros, 0);
                    // TODO: criar tabela com o nome correto (nome(Parametros)) para a funcao
                    // Declaracao de funcoes
                    sym_tab *tabela = create_sym_tab(methodOrField->child->child->brother, parametrosString, 0);
                    printf("param --->%s\n", tabela->parametros);
                    printf("MethodHeader -> create_sym_tab\n");
                    table_list = add_sym_table(table_list, tabela);
                    printf("MethodHeader -> add_sym_table\n");
                }

                //    sym_tab *tabela = create_sym_tab(methodOrField->child->child->brother, 0);
            }
            // methodOrField = methodOrField->brother;
            // } =======
        }

        methodOrField = methodOrField->brother;
    }
    printf("FIM_CREATE_SYMBOL_TABLE_LIST\n");
    return table_list;
}
