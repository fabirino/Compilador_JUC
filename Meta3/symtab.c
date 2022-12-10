/* ===================================================================================
        Compiladores -  Eduardo Figueiredo 2020213717
                        Fábio Santos       2020212310
    ====================================================================================== */

#include "symtab.h"

char *getType(char *tipo) {
    char *string = malloc(sizeof(char) * 128);

    if (!strcmp(tipo, "StringArray") || !strcmp(tipo, "String[]")) {
        string = "String[]";
    } else if (!strcmp(tipo, "Void") || !strcmp(tipo, "void")) {
        string = "void";
    } else if (!strcmp(tipo, "Int") || !strcmp(tipo, "int")) {
        string = "int";
    } else if (!strcmp(tipo, "Bool") || !strcmp(tipo, "boolean")) {
        string = "boolean";
    } else if (!strcmp(tipo, "Double") || !strcmp(tipo, "double")) {
        string = "double";
    }

    return string;
}

void print_tabs(sym_tab_list *lista) {

    sym_tab_list *aux_table_list = lista;
    while (aux_table_list != NULL) {
        sym_tab *aux_tab = aux_table_list->tab;
        symbol *aux_sym_list = aux_tab->symbols;

        if (strcmp(aux_tab->parametros, "")) {
            printf("===== %s %s%s Symbol Table =====\n", aux_tab->type, aux_tab->name, aux_tab->parametros);
        } else {
            printf("===== %s %s Symbol Table =====\n", aux_tab->type, aux_tab->name);
        }

        while (aux_sym_list != NULL) {
            param_list *methodParams = aux_sym_list->methodParams;

            if (methodParams != NULL) {

                if (aux_sym_list->param) {
                    printf("%s\t%s\t%s\tparam\n", aux_sym_list->name, aux_sym_list->parametrosString, aux_sym_list->type);
                } else {
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

char *add_symbol(sym_tab *tabela, char *name, char *type, struct parametros_funcao *parametros, struct node *no, int line, int col, int is_param) {
    symbol *aux = (symbol *)malloc(sizeof(symbol));
    aux->name = name;
    aux->type = type;
    aux->param = is_param;
    aux->methodParams = parametros;
    aux->next = NULL;
    aux->parametrosString = strdup("");
    // strcpy(aux->parametrosString, "");
    char string[1024];
    char *string2 = NULL;
    // Verificar se e reserved TODO: erro no print, estamos a mandar o no vazio
    if (name[0] == '_' && strlen(name) == 1) {
        if (no) {
            printf("Line %d, col %d: Symbol _ is reserved\n", no->linha, no->coluna);
        } else {
            printf("Line %d, col %d: Symbol _ is reserved\n", line, col); // parametros
        }
        return NULL;
    }
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

        aux->parametrosString = strdup(string);
        // strcpy(aux->parametrosString, string);

        string2 = (char *)malloc(sizeof(string));
        string2 = &string[0];
    }

    // Verificar se é uma funcao que ja existe
    if (parametros != NULL) {
        if (searchFunc(aux, tabela, string)) { // Se for uma funcao tem de estar definida na tabela global
            printf("Line %d, col %d: Symbol %s%s already defined\n", no->linha, no->coluna, aux->name, string);
            return NULL;
        }
    }

    if (no && parametros == NULL) { // erro anda para aqui
        // Comparar se ja existe esse no!
        char *TIPO = NULL;
        symbol *lista_simbolos = tabela->symbols;
        if (lista_simbolos) {
            if (!strcmp(no->name, lista_simbolos->name) && !strcmp(aux->parametrosString, lista_simbolos->parametrosString)) {
                TIPO = lista_simbolos->type;
            } else {
                while (lista_simbolos->next != NULL) {
                    lista_simbolos = lista_simbolos->next;
                    if (!strcmp(no->name, lista_simbolos->name) && !strcmp(aux->parametrosString, lista_simbolos->parametrosString)) {
                        TIPO = lista_simbolos->type;
                        break;
                    }
                }
            }
        }
        if (TIPO) {
            printf("Line %d, col %d: Symbol %s already defined\n", no->linha, no->coluna, no->name);
            return string2;
        }
    }

    symbol *lista_simbolos = tabela->symbols;
    if (lista_simbolos == NULL) {
        tabela->symbols = (symbol *)malloc(sizeof(symbol));
        tabela->symbols = aux;
        tabela->symbols->next = NULL;
    }
    // Adicionar o simbolo ao ultimo da lista
    else {
        while (lista_simbolos->next != NULL) {
            lista_simbolos = lista_simbolos->next;
        }
        lista_simbolos->next = (symbol *)malloc(sizeof(symbol));
        lista_simbolos->next = aux;
    }

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
    symbol_table->comment = 0;

    symbol_table->symbols = (struct simbolo *)malloc(sizeof(struct simbolo));
    symbol_table->symbols = NULL;
    if (parametros == NULL)
        symbol_table->parametros = strdup("");
    // strcpy(symbol_table->parametros, "");
    else
        symbol_table->parametros = strdup(parametros);

    // strcpy(symbol_table->parametros, parametros);

    if (is_class)
        symbol_table->type = "Class";
    else
        symbol_table->type = "Method";

    return symbol_table;
}

param_list *create_param_list(param_list *lista, struct node *no, int first) {

    param_list *lista_parametros = lista;
    if (lista == NULL) {
        lista = (struct parametros_funcao *)malloc(sizeof(struct parametros_funcao));
        lista->paramType = getType(no->var);
        lista->paramId = no->brother->name;
        lista->linha = no->brother->linha;
        lista->col = no->brother->coluna;
        lista->next = NULL;
    }
    // Adicionar o simbolo ao ultimo da lista
    else {
        while (lista_parametros->next != NULL) {
            lista_parametros = lista_parametros->next;
        }
        lista_parametros->next = (struct parametros_funcao *)malloc(sizeof(struct parametros_funcao));
        lista_parametros->next->paramType = getType(no->var);
        lista_parametros->next->paramId = no->brother->name;
        lista_parametros->next->linha = no->brother->linha;
        lista_parametros->next->col = no->brother->coluna;
        lista_parametros->next->next = NULL;
    }
    return lista;
}

char *searchType(struct node *no, sym_tab *global, sym_tab *tabela, int altera) {
    char *string = malloc(sizeof(char) * 128);
    char aux[64];

    // verificar na tabela local primeiro
    if (tabela) {
        symbol *lista_simbolos = tabela->symbols;
        if (lista_simbolos) {
            if (!strcmp(no->name, lista_simbolos->name) && lista_simbolos->methodParams == NULL) {
                if (altera) {
                    no->comment = strdup(lista_simbolos->type);
                }
                return lista_simbolos->type;
            }
            while (lista_simbolos->next != NULL) {
                lista_simbolos = lista_simbolos->next;

                if (!strcmp(no->name, lista_simbolos->name) && lista_simbolos->methodParams == NULL) {

                    if (altera) {
                        no->comment = strdup(lista_simbolos->type);
                    }
                    return lista_simbolos->type;
                }
            }
        }
    }
    // Procurar na tabela global
    if (global) {
        symbol *lista_simbolos = global->symbols;

        if (lista_simbolos) {

            if (!strcmp(no->name, lista_simbolos->name) && lista_simbolos->param == 0 && lista_simbolos->methodParams == NULL) {
                if (altera) {
                    no->comment = strdup(lista_simbolos->type);
                }
                return lista_simbolos->type;
            }
            while (lista_simbolos->next != NULL) {
                // printf("WHILE \"add_symbol\"\n");
                lista_simbolos = lista_simbolos->next;
                if (!strcmp(no->name, lista_simbolos->name) && lista_simbolos->param == 0 && lista_simbolos->methodParams == NULL) {
                    if (altera) {
                        no->comment = strdup(lista_simbolos->type);
                    }
                    return lista_simbolos->type;
                }
            }
        }
    }

    if (altera) {
        no->comment = strdup("undef");
        printf("Line %d, col %d: Cannot find symbol %s\n", no->linha, no->coluna, no->name);
    }

    string = NULL;

    return string; // SE NAO EXISTIR ESSA VARIAVEL RETORNA NULL!!
}

int searchFunc(struct simbolo *simbolo, sym_tab *global, char *parametrosString) {
    struct simbolo *aux = global->symbols;
    while (aux) {
        if (!strcmp(simbolo->name, aux->name) && !strcmp(aux->parametrosString, parametrosString)) {
            return 1;
        }
        aux = aux->next;
    }

    return 0;
}

// Funcao que checka se o Int esta Out Of Bounds
int checkOoB_I(char *numero) { // Declit()
    char *num = strdup(numero);
    char *aux = (char *)malloc(sizeof(num));

    int count = 0;
    for (int i = 0; i < strlen(num); i++) {
        if (num[i] != '_') {
            aux[count++] = num[i];
        }
    }

    double final = atof(aux);
    if (final > INT_MAX || final < INT_MIN)
        return 1;
    else
        return 0;
}

// Funcao que checka se o Double esta Out Of Bounds
int checkOoB_D(char *numero) {
    char *num = strdup(numero);
    char *aux = (char *)malloc(sizeof(num));
    char *exp = (char *)malloc(sizeof(num));
    int expoente = 0;

    int count = 0;
    for (int i = 0; i < strlen(num); i++) {
        // Verificar qual parte pertence ao numero e qual pertence ao expoente
        if (expoente == 0) {
            if (num[i] != '_') {
                aux[count++] = num[i];
            }
            if (num[i] == 'E' || num[i] == 'e') {
                expoente = 1;
                count = 0;
            }
        } else {
            exp[count++] = num[i];
        }
    }

    double parte1 = atof(aux);
    double parte2 = atof(exp);

    // Verificar se as casas decimais estao de acordo com a notacao cientifica
    if (parte1 == 0) {
        parte1 = 0;
        parte2 = 0;
        return 0;
    } else if (parte1 > 1 || parte1 < -1) { // passar de 234.1e10 para 2.341e12
        double exponent = log10(parte1);
        parte2 += exponent;
    } else { // passar de 0.001e10 para 1e7
        double exponent = notacaoCient(parte1);
        parte2 -= exponent;
    }

    long double final = parte1 * calcpow10(parte2);
    if (final >= DBL_MAX || final <= DBL_MIN || parte2 <= -324 || parte2 >= 308)
        return 1;

    else
        return 0;

    return 0;
}

char *callHandler(struct node *no, sym_tab *global, sym_tab *tabela) {
    // Consultar os argumentos da funcao
    node *funcao = no->child;
    node *argumentos = funcao->brother;
    char string[1024];
    char string2[1024];
    char aux[128];
    char *aux1 = malloc(sizeof(char) * 128);
    char *type = NULL;
    char *func_type;
    int count = 0;
    int nCountFunction = 0;
    strcpy(string, "(");
    // Contar o numero de argumentos (para saber as virgulas)
    while (argumentos) {
        count++;
        argumentos = argumentos->brother;
    }
    argumentos = funcao->brother;
    while (argumentos) {
        // Anotar a arvore e adicionar a string de parametros
        aux1 = strndup(argumentos->var, 2);
        if (!strcmp("Ca", aux1)) { // Id
            type = callHandler(argumentos, global, tabela);
            if (type)
                strcat(string, type);
            else
                strcat(string, "undef");
        } else {
            type = getTypeOperation(argumentos, global, tabela, 0);
            if (type)
                strcat(string, type);
            else
                strcat(string, "undef");
        }

        if (count > 1) {
            strcat(string, ",");
        }
        count--;
        argumentos = argumentos->brother;
    }
    strcat(string, ")");
    strcpy(string2, string);

    if (DEBUG)
        printf("'Call - String Argumentos' -> %s\n", string);

    // Verificar se a funcao existe
    symbol *aux_list = global->symbols;
    int existe = 0;
    while (aux_list) {
        if (!strcmp(aux_list->name, funcao->name) && !strcmp(aux_list->parametrosString, string)) {
            existe = 1;
            func_type = strdup(aux_list->type);
            // strcpy(func_type, aux_list->type);
            break;
        }
        // printf("dentro--->%d\n",nCountFunction);
        aux_list = aux_list->next;
    }

    if (!existe) { // Se ja existe nao e necessario procurar outra vez
        aux_list = global->symbols;
        while (aux_list) { // Percorrer todas as funcoes
            // printf("'Aux_list_name e funcao' -> %s|%s\n", aux_list->name, funcao->name);
            if (!strcmp(aux_list->name, funcao->name)) { //  Verificar se a funcao pode ser chamada com outros argumentos
                // printf("entrou--->%d\n",nCountFunction);
                char *copy1 = strdup(aux_list->parametrosString);
                char *copy2 = strdup(string2);
                int count1 = 0;
                int count2 = 0;

                char *tok1;
                while ((tok1 = strtok_r(copy1, "(),", &copy1))) { // contar os parametros das funcoes a comparar
                    count1++;
                }

                char *tok2;
                while ((tok2 = strtok_r(copy2, "(),", &copy2))) { // contar os parametros das funcoes a comparar
                    count2++;
                }

                if (count1 == count2) {
                    char *copy1 = strdup(aux_list->parametrosString);
                    char *copy2 = strdup(string2);
                    int count3 = 0;
                    // printf("Parametros pretendidos -> %s\n", copy1);
                    // printf("Parametros recebidos -> %s\n", copy2);

                    while ((tok2 = strtok_r(copy2, "(),", &copy2)) && (tok1 = strtok_r(copy1, "(),", &copy1))) {
                        if (!strcmp(tok2, "int") && !strcmp(tok1, "double")) {
                            // printf("Tokens identicos -> %s|%s\n", tok1, tok2);
                            // continua
                        } else if (!strcmp(tok1, tok2)) {
                            // printf("Tokens iguais -> %s|%s\n", tok1, tok2);
                            // continua
                        } else {
                            // printf("Tokens diferentes -> %s|%s\n", tok1, tok2);
                            // sao diferentes
                            break;
                        }
                        count3++;
                    }
                    // printf("count 2 e 3 -> %d|%d\n", count2, count3);
                    if (count3 == count2) {
                        // printf("passou os counts\n");
                        existe = 1;
                        strcpy(string, aux_list->parametrosString);
                        func_type = strdup(aux_list->type);
                        // strcpy(func_type, aux_list->type);
                        nCountFunction++;
                    }
                }
            }
            aux_list = aux_list->next;
        }
    }

    // // printf("--->%d\n", nCountFunction);
    if (!existe) {
        printf("Line %d, col %d: Cannot find symbol %s%s\n", funcao->linha, funcao->coluna, funcao->name, string);
        no->comment = strdup("undef");

        funcao->comment = strdup("undef");
        return "undef";
    } else {
        if (nCountFunction > 1) {
            printf("Line %d, col %d: Reference to method %s%s is ambiguous\n", funcao->linha, funcao->coluna, funcao->name, string2);
            no->comment = strdup("undef");

            funcao->comment = strdup("undef");
            return "undef";
        } else {
            // Type do call
            no->comment = strdup(func_type);
            // Colocar a frente da funcao os seus argumentos
            if (DEBUG)
                printf("'string' -> %s\n", string);
            funcao->comment = strdup(string);
            return getType(func_type);
        }
    }
    return "undef";
}

char *getTypeOperation(struct node *no, sym_tab *global, sym_tab *tabela, int child) {
    char *string;
    char aux[256];

    if (DEBUG)
        printf("'no->var' -> %s linha - %d\n", no->var, no->linha);
    char *aux1 = strndup(no->var, 3);

    if (DEBUG)
        printf("DEBUG\"getTypeOperation\" --->>%s\n", aux1);

    if (!strcmp("Dec", aux1)) { // Declit
        no->comment = strdup("int");
        // if (checkOoB_I(no->name))
            // printf("Line %d, col %d: Number %s out of bounds\n", no->linha, no->coluna, no->name);
        string = strdup("int");
    } else if (!strcmp("Rea", aux1)) { // Realit
        no->comment = strdup("double");
        // if (checkOoB_D(no->name))
            // printf("Line %d, col %d: Number %s out of bounds\n", no->linha, no->coluna, no->name);
        string = strdup("double");
    } else if (!strcmp("Str", aux1)) { // StrLit
        no->comment = strdup("String");
        string = strdup("String");
    } else if (!strcmp("Boo", aux1)) { // Boolit
        no->comment = strdup("boolean");
        // string = "boolean";
        string = strdup("boolean");

    } else if (!strcmp("Id(", aux1)) { // Id
        string = searchType(no, global, tabela, 1);

    } else if (!strcmp("Len", aux1)) { // Length
        char *auxc = getTypeOperation(no->child, global, tabela, 1);
        no->comment = strdup("int");
        if (auxc == NULL) {
            printf("Line %d, col %d: Operator .length cannot be applied to type undef\n", no->linha, no->coluna);
        } else if (strcmp(auxc, "String[]")) {
            printf("Line %d, col %d: Operator .length cannot be applied to type %s\n", no->linha, no->coluna, auxc);
        }
        // string = "int";
        string = strdup("int");

    } else if (!strcmp("Add", aux1) || !strcmp("Sub", aux1) || !strcmp("Mul", aux1) || !strcmp("Div", aux1) || !strcmp("Mod", aux1)) { // Add || Sub || Mul || Div
        char *auxc = getTypeOperation(no->child, global, tabela, 0);
        char *auxb = getTypeOperation(no->child->brother, global, tabela, 0);

        if (DEBUG)
            printf("------>%s %s|%s\n", no->var, auxc, auxb);
        if (auxc && auxb) {
            if ((!strcmp(auxc, auxb) && (!strcmp(auxc, "double") || !strcmp(auxc, "int")))) { // verificar se e int ou double
                no->comment = strdup(auxc);
                string = strdup(auxc);
            } else if ((!strcmp(auxc, "int") && !strcmp(auxb, "double")) || (!strcmp(auxb, "int") && !strcmp(auxc, "double"))) {
                no->comment = strdup("double");
                string = strdup("double");
            } else {
                no->comment = strdup("undef");
                string = strdup("undef");

                if (!strcmp("Add", aux1))
                    printf("Line %d, col %d: Operator + cannot be applied to types %s, %s\n", no->linha, no->coluna, auxc, auxb);
                else if (!strcmp("Sub", aux1))
                    printf("Line %d, col %d: Operator - cannot be applied to types %s, %s\n", no->linha, no->coluna, auxc, auxb);
                else if (!strcmp("Mul", aux1))
                    printf("Line %d, col %d: Operator * cannot be applied to types %s, %s\n", no->linha, no->coluna, auxc, auxb);
                else if (!strcmp("Div", aux1))
                    printf("Line %d, col %d: Operator / cannot be applied to types %s, %s\n", no->linha, no->coluna, auxc, auxb);
                else if (!strcmp("Mod", aux1))
                    printf("Line %d, col %d: Operator %% cannot be applied to types %s, %s\n", no->linha, no->coluna, auxc, auxb);
            }
        } else {
            if (auxc == NULL && auxb == NULL) {
                no->comment = strdup("undef");
                string = strdup("undef");

                auxc = strdup("undef");
                auxb = strdup("undef");
            } else if (auxc == NULL) { // nao existe filho
                no->comment = strdup("undef");
                string = strdup("undef");
                auxc = strdup("undef");
            } else if (auxb == NULL) {
                no->comment = strdup("undef");
                string = strdup("undef");
                auxb = strdup("undef");
            }
            if (!strcmp("Add", aux1))
                printf("Line %d, col %d: Operator + cannot be applied to types %s, %s\n", no->linha, no->coluna, auxc, auxb);
            else if (!strcmp("Sub", aux1))
                printf("Line %d, col %d: Operator - cannot be applied to types %s, %s\n", no->linha, no->coluna, auxc, auxb);
            else if (!strcmp("Mul", aux1))
                printf("Line %d, col %d: Operator * cannot be applied to types %s, %s\n", no->linha, no->coluna, auxc, auxb);
            else if (!strcmp("Div", aux1))
                printf("Line %d, col %d: Operator / cannot be applied to types %s, %s\n", no->linha, no->coluna, auxc, auxb);
            else if (!strcmp("Mod", aux1))
                printf("Line %d, col %d: Operator %% cannot be applied to types %s, %s\n", no->linha, no->coluna, auxc, auxb);
        }

    } else if (!strcmp("Lsh", aux1) || !strcmp("Rsh", aux1)) { // Rshift || Lshift
        if (no->child && no->child->brother) {
            char *aux2 = strndup(no->child->var, 2);
            char *aux3 = strndup(no->child->brother->var, 2);
            if (!strcmp("Id", aux2) && !strcmp("Id", aux3)) {
                if (!strcmp(searchType(no->child, global, tabela, 0), "boolean") && !strcmp(searchType(no->child->brother, global, tabela, 0), "boolean")) {
                    // continua
                } else {
                    string = strdup("none");
                    return string;
                }
            }
        }
        if (child) {
            string = strdup("none");
            return string;
        }
        char *auxc = getTypeOperation(no->child, global, tabela, 0);
        char *auxb = getTypeOperation(no->child->brother, global, tabela, 0);
        if (DEBUG)
            printf("------>%s %s|%s\n", no->var, auxc, auxb);
        if (auxc && auxb) {
            if ((!strcmp(auxc, auxb) && !strcmp(auxc, "int"))) { // verificar se e int ou double
                no->comment = strdup(auxc);
                string = strdup(auxc);
            } else {
                no->comment = strdup("undef");
                string = strdup("undef");

                if (!strcmp("Lsh", aux1))
                    printf("Line %d, col %d: Operator << cannot be applied to types %s, %s\n", no->linha, no->coluna, auxc, auxb);
                else
                    printf("Line %d, col %d: Operator >> cannot be applied to types %s, %s\n", no->linha, no->coluna, auxc, auxb);
            }
        } else {
            if (auxc == NULL && auxb == NULL) {
                no->comment = strdup("undef");
                string = strdup("undef");

                auxc = strdup("undef");
                auxb = strdup("undef");
            } else if (auxc == NULL) { // nao existe filho
                no->comment = strdup("undef");
                string = strdup("undef");
                auxc = strdup("undef");
            } else if (auxb == NULL) {
                no->comment = strdup("undef");
                string = strdup("undef");
                auxb = strdup("undef");
            }
            if (!strcmp("Lsh", aux1))
                printf("Line %d, col %d: Operator << cannot be applied to types %s, %s\n", no->linha, no->coluna, auxc, auxb);
            else
                printf("Line %d, col %d: Operator >> cannot be applied to types %s, %s\n", no->linha, no->coluna, auxc, auxb);
        }

    } else if (!strcmp("Cal", aux1)) { // Call
        string = strdup(callHandler(no, global, tabela));

    } else if (!strcmp("Ge", aux1) || !strcmp("Gt", aux1) || !strcmp("Le", aux1) || !strcmp("Lt", aux1)) {
        char *auxc = getTypeOperation(no->child, global, tabela, 0);
        char *auxb = getTypeOperation(no->child->brother, global, tabela, 0);
        no->comment = strdup("boolean");
        string = strdup("boolean");

        if (auxc && auxb) {
            if ((!strcmp(auxc, auxb) && (!strcmp(auxc, "double") || !strcmp(auxc, "int")))) { // verificar se e int ou double
                // continua
            } else if ((!strcmp(auxc, "int") && !strcmp(auxb, "double")) || (!strcmp(auxb, "int") && !strcmp(auxc, "double"))) {
                // continua
            } else {
                if (!strcmp("Ge", aux1))
                    printf("Line %d, col %d: Operator >= cannot be applied to types %s, %s\n", no->linha, no->coluna, auxc, auxb);
                else if (!strcmp("Gt", aux1))
                    printf("Line %d, col %d: Operator > cannot be applied to types %s, %s\n", no->linha, no->coluna, auxc, auxb);
                else if (!strcmp("Le", aux1))
                    printf("Line %d, col %d: Operator <= cannot be applied to types %s, %s\n", no->linha, no->coluna, auxc, auxb);
                else if (!strcmp("Lt", aux1))
                    printf("Line %d, col %d: Operator < cannot be applied to types %s, %s\n", no->linha, no->coluna, auxc, auxb);
            }
        } else {
            if (auxc == NULL && auxb == NULL) {
                auxc = strdup("undef");
                auxb = strdup("undef");
            } else if (auxc == NULL) { // existe filho
                auxc = strdup("undef");
            } else if (auxb == NULL) {
                auxb = strdup("undef");
            }
            if (!strcmp("Ge", aux1))
                printf("Line %d, col %d: Operator >= cannot be applied to types %s, %s\n", no->linha, no->coluna, auxc, auxb);
            else if (!strcmp("Gt", aux1))
                printf("Line %d, col %d: Operator > cannot be applied to types %s, %s\n", no->linha, no->coluna, auxc, auxb);
            else if (!strcmp("Le", aux1))
                printf("Line %d, col %d: Operator <= cannot be applied to types %s, %s\n", no->linha, no->coluna, auxc, auxb);
            else if (!strcmp("Lt", aux1))
                printf("Line %d, col %d: Operator < cannot be applied to types %s, %s\n", no->linha, no->coluna, auxc, auxb);
        }
    } else if (!strcmp("Eq", aux1) || !strcmp("Ne", aux1)) {

        char *auxc = getTypeOperation(no->child, global, tabela, 0);
        char *auxb = getTypeOperation(no->child->brother, global, tabela, 0);
        no->comment = strdup("boolean");
        string = strdup("boolean");

        if (auxc && auxb) {
            if ((!strcmp(auxc, auxb) && (!strcmp(auxc, "double") || !strcmp(auxc, "int") || !strcmp(auxc, "boolean")))) { // verificar se e int ou double
                // continua
            } else if ((!strcmp(auxc, "int") && !strcmp(auxb, "double")) || (!strcmp(auxb, "int") && !strcmp(auxc, "double"))) {
                // continua
            } else {
                if (!strcmp("Eq", aux1))
                    printf("Line %d, col %d: Operator == cannot be applied to types %s, %s\n", no->linha, no->coluna, auxc, auxb);
                else if (!strcmp("Ne", aux1))
                    printf("Line %d, col %d: Operator != cannot be applied to types %s, %s\n", no->linha, no->coluna, auxc, auxb);
            }
        } else {
            if (auxc == NULL && auxb == NULL) {
                auxc = strdup("undef");
                auxb = strdup("undef");
            } else if (auxc == NULL) { // existe filho
                auxc = strdup("undef");
            } else if (auxb == NULL) {
                auxb = strdup("undef");
            }
            printf("Line %d, col %d: Operator == cannot be applied to types %s, %s\n", no->linha, no->coluna, auxc, auxb);
        }
    } else if (!strcmp("Not", aux1)) {
        char *auxc = getTypeOperation(no->child, global, tabela, 1);
        if (auxc) {
            no->comment = strdup("boolean");
            string = strdup("boolean");

            if (!strcmp(auxc, "boolean")) {
                // CONTINUA
            } else {
                printf("Line %d, col %d: Operator ! cannot be applied to type %s\n", no->linha, no->coluna, auxc);
            }
        } else {
            no->comment = strdup("undef");
            string = strdup("undef");
            printf("Line %d, col %d: Operator ! cannot be applied to type undef\n", no->linha, no->coluna);
        }

    } else if (!strcmp("Min", aux1) || !strcmp("Plu", aux1)) {
        char *auxc = getTypeOperation(no->child, global, tabela, 0);
        if (auxc) {
            if (!strcmp(auxc, "int") || !strcmp(auxc, "double")) {
                no->comment = strdup(auxc);
                string = strdup(auxc);
            } else {
                no->comment = strdup("undef");
                string = strdup("undef");
                if (!strcmp("Min", aux1))
                    printf("Line %d, col %d: Operator - cannot be applied to type %s\n", no->linha, no->coluna, auxc);
                else
                    printf("Line %d, col %d: Operator + cannot be applied to type %s\n", no->linha, no->coluna, auxc);
            }
        } else {
            no->comment = strdup("undef");
            string = strdup("undef");

            if (!strcmp("Min", aux1))
                printf("Line %d, col %d: Operator - cannot be applied to type undef\n", no->linha, no->coluna);
            else
                printf("Line %d, col %d: Operator + cannot be applied to type undef\n", no->linha, no->coluna);
        }

    } else if (!strcmp("Xor", aux1) || !strcmp("Or", aux1) || !strcmp("And", aux1)) {
        char *auxc = getTypeOperation(no->child, global, tabela, 1);
        char *auxb = getTypeOperation(no->child->brother, global, tabela, 1);
        if (auxc && auxb) {
            if (!strcmp(auxc, auxb) && (!strcmp(auxc, "boolean") || !strcmp(auxc, "int"))) {
                no->comment = strdup(auxc);
                string = strdup(auxc);
            } else {
                no->comment = strdup("undef");

                if (!strcmp("Xor", aux1)) {
                    printf("Line %d, col %d: Operator ^ cannot be applied to types %s, %s\n", no->linha, no->coluna, auxc, auxb);
                    string = strdup("undef");
                } else if (!strcmp("And", aux1)) {
                    printf("Line %d, col %d: Operator && cannot be applied to types %s, %s\n", no->linha, no->coluna, auxc, auxb);
                    string = strdup("boolean");
                } else {
                    printf("Line %d, col %d: Operator || cannot be applied to types %s, %s\n", no->linha, no->coluna, auxc, auxb);
                    string = strdup("boolean");
                }
            }
        } else {
            if (auxc == NULL && auxb == NULL) {
                no->comment = strdup("undef");
                string = strdup("undef");

                auxc = strdup("undef");
                auxb = strdup("undef");
            } else if (auxc == NULL) { // nao existe filho
                no->comment = strdup("undef");
                string = strdup("undef");

                auxb = strdup("undef");
            } else if (auxb == NULL) {
                no->comment = strdup("undef");
                string = strdup("undef");

                auxb = strdup("undef");
            }
            // erros

            if (!strcmp("Xor", aux1))
                printf("Line %d, col %d: Operator ^ cannot be applied to types %s, %s\n", no->linha, no->coluna, auxc, auxb);
            else if (!strcmp("And", aux1))
                printf("Line %d, col %d: Operator && cannot be applied to types %s, %s\n", no->linha, no->coluna, auxc, auxb);
            else
                printf("Line %d, col %d: Operator || cannot be applied to types %s, %s\n", no->linha, no->coluna, auxc, auxb);
        }

    } else if (!strcmp("Par", aux1)) { // ParseArgs
        char *auxc = getTypeOperation(no->child, global, tabela, 0);
        char *auxb = getTypeOperation(no->child->brother, global, tabela, 0);
        if (DEBUG)
            printf("'<ParseArgs-->' -> %s|%s\n", auxc, auxb);
        no->comment = strdup("int");
        string = strdup("int");

        if (auxc && auxb) {
            if (!strcmp(auxc, "String[]") && !strcmp(auxb, "int")) {
                // continua
            } else {
                printf("Line %d, col %d: Operator Integer.parseInt cannot be applied to types %s, %s\n", no->linha, no->coluna, auxc, auxb);
            }
        } else {
            if (auxc == NULL && auxb == NULL) {
                auxc = strdup("undef");
                auxb = strdup("undef");
            } else if (auxc == NULL) { // existe filho
                auxc = strdup("undef");
            } else if (auxb == NULL) {
                auxb = strdup("undef");
            }
            printf("Line %d, col %d: Operator Integer.parseInt cannot be applied to types %s, %s\n", no->linha, no->coluna, auxc, auxb);
        }

    } else if (!strcmp("Ass", aux1)) { // Assign
        char *auxc = getTypeOperation(no->child, global, tabela, 1);
        char *auxb = getTypeOperation(no->child->brother, global, tabela, 0);
        if (auxc && auxb) {
            if (DEBUG)
                printf("'<Assign-->' -> %s|%s\n", auxc, auxb);

            if (!strcmp(auxc, auxb) && (!strcmp(auxc, "int") || !strcmp(auxc, "double") || !strcmp(auxc, "boolean"))) {
                no->comment = strdup(auxc);
                string = strdup(auxc);
            } else if (!strcmp(auxb, "int") && !strcmp(auxc, "double")) {
                no->comment = strdup("double");
                string = strdup("double");
            } else {
                no->comment = strdup(auxc);
                string = strdup(auxc);
                printf("Line %d, col %d: Operator = cannot be applied to types %s, %s\n", no->linha, no->coluna, auxc, auxb);
            }
        } else { // existe alguma variavel que e undef
            if (auxc == NULL && auxb == NULL) {
                no->comment = strdup("undef");
                string = strdup("undef");

                auxc = strdup("undef");
                auxb = strdup("undef");
            } else if (auxc == NULL) { // nao existe filho
                no->comment = strdup("undef");
                string = strdup("undef");

                auxc = strdup("undef");
            } else if (auxb == NULL) {
                no->comment = strdup("undef");
                string = strdup("undef");

                auxb = strdup("undef");
            }
            printf("Line %d, col %d: Operator = cannot be applied to types %s, %s\n", no->linha, no->coluna, auxc, auxb);
        }

    } else if (!strcmp(aux1, "Pri")) { // Print
        char *type = getTypeOperation(no->child, global, tabela, 0);
        if (!strcmp(type, "undef") || !strcmp(type, "void") || !strcmp(type, "String[]")) {
            char *call = strndup(no->child->var, 2);
            if (!strcmp(call, "Ca"))
                printf("Line %d, col %d: Incompatible type %s in System.out.print statement\n", no->child->child->linha, no->child->child->coluna, type);
            else // TODO:VER MELHOR ISTO AQUI
                printf("Line %d, col %d: Incompatible type %s in System.out.print statement\n", no->child->linha, no->child->coluna, type);
        }
    } else if (!strcmp("If", aux1) || !strcmp("Els", aux1) || !strcmp("Whi", aux1)) {
        struct node *auxin = no->child;
        if (!strcmp("If", aux1) || !strcmp("Whi", aux1)) {
            char *auxchar = getTypeOperation(auxin, global, tabela, 0);
            if (strcmp("boolean", auxchar)) {
                if (!strcmp("If", aux1))
                    printf("Line %d, col %d: Incompatible type %s in if statement\n", auxin->linha, auxin->coluna, auxchar);
                else
                    printf("Line %d, col %d: Incompatible type %s in while statement\n", auxin->linha, auxin->coluna, auxchar);
            }
        }
        auxin = auxin->brother;
        while (auxin) {
            if (!strcmp(auxin->var, "Return") && auxin->child) {
                char *aux;
                int c = 0;
                if (auxin->child) {
                    aux = getTypeOperation(auxin->child, global, tabela, 0);
                    c = 1;
                } else {
                    // aux = "void";
                    string = strdup("void");
                }
                // printf("%s\n", aux);
                if (aux == NULL) {                                                                                                    // SE FOR UMA OPERACAO OU UMA DECLARACAO PROCURAR O TIPO, EX DECLIT,ADD,...
                    printf("Line %d, col %d: Cannot find symbol %s\n", auxin->child->linha, auxin->child->coluna, auxin->child->var); // DEBUG: MAIS A FRENTE TIRAR ESTE IF
                } else if (!strcmp(aux, "void") && !strcmp("void", tabela->symbols->type) && c == 1) {
                    printf("Line %d, col %d: Incompatible type %s in return statement\n", auxin->child->child->linha, auxin->child->child->coluna, aux);
                } else if ((!strcmp(aux, "int") && !strcmp("double", tabela->symbols->type))) { // FIXME: A variavel existe !!
                    // continua                                                                                                                               // continua
                } else if (strcmp(aux, tabela->symbols->type)) {
                    if (auxin->child && auxin->child->child) {
                        if (!strcmp("Call", auxin->child->var)) {
                            printf("Line %d, col %d: Incompatible type %s in return statement\n", auxin->child->child->linha, auxin->child->child->coluna, aux);
                        } else {
                            printf("Line %d, col %d: Incompatible type %s in return statement\n", auxin->child->linha, auxin->child->coluna, aux);
                        }
                    } else if (auxin->child) {
                        printf("Line %d, col %d: Incompatible type %s in return statement\n", auxin->child->linha, auxin->child->coluna, aux);
                    } else {
                        printf("Line %d, col %d: Incompatible type %s in return statement\n", auxin->linha, auxin->coluna, aux);
                    }
                }
            } else if (!strcmp(auxin->var, "Block") && auxin->child) {
                struct node *block = auxin->child;

                while (block) {
                    getTypeOperation(block, global, tabela, 0);
                    block = block->brother;
                }
            } else {
                getTypeOperation(auxin, global, tabela, 0);
            }
            // printf("%s\n",auxin->var->name);
            auxin = auxin->brother;
        }
    }

    if (DEBUG)
        printf("getTypeOperation(%s)--> %s\n", no->name, string);
    return string;
}

char *verifyParams(param_list *lista, sym_tab *tabela) {
    char *TIPO = (char *)malloc(sizeof(char) * 128);
    TIPO = NULL;
    symbol *lista_simbolos = tabela->symbols;
    if (lista_simbolos) {
        if (!strcmp(lista->paramId, lista_simbolos->name)) {
            TIPO = lista_simbolos->type;
        } else {
            while (lista_simbolos->next != NULL) {
                lista_simbolos = lista_simbolos->next;
                if (!strcmp(lista->paramId, lista_simbolos->name)) {
                    TIPO = lista_simbolos->type;
                    break;
                }
            }
        }
    }
    if (TIPO) {
        printf("Line %d, col %d: Symbol %s already defined\n", lista->linha, lista->col, lista->paramId);
    }
    return TIPO;
}

sym_tab *searchTable(char *name, char *parametros, sym_tab_list *lista) {

    sym_tab_list *lista_tabelas = lista;

    if (lista_tabelas->tab) {

        if (!strcmp(name, lista_tabelas->tab->name) && !strcmp(parametros, lista_tabelas->tab->parametros)) {

            return lista_tabelas->tab;
        }
        while (lista_tabelas->next != NULL) {
            // printf("WHILE \"searchTable\"\n");
            lista_tabelas = lista_tabelas->next;
            if (!strcmp(name, lista_tabelas->tab->name) && !strcmp(parametros, lista_tabelas->tab->parametros)) {
                return lista_tabelas->tab;
            }
        }
    }

    return NULL;
}

void commentnodes(struct node *raiz, sym_tab *global, sym_tab_list *lista) {

    node *methodOrField = raiz->child->brother;
    while (methodOrField) {
        if (!strcmp(methodOrField->var, "MethodDecl")) {
            if (DEBUG)
                printf("MethodDecl\n");

            sym_tab *tabela;
            // Contem o nome da funcao
            if (!strcmp(methodOrField->child->var, "MethodHeader")) {
                if (DEBUG)
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
                            if (DEBUG)
                                printf("MethodParams\n");

                            lista_parametros = create_param_list(lista_parametros, parametros->child, 0);

                            //====================
                            parametros = parametros->brother;
                        }
                    } else {
                        lista_parametros = (struct parametros_funcao *)malloc(sizeof(struct parametros_funcao));
                        // lista_parametros->paramType = malloc(sizeof(char) * 128);
                        lista_parametros->paramType = strdup("Vazio");
                        // strcpy(lista_parametros->paramType, "Vazio");
                        lista_parametros->next = NULL;
                    }
                    char parametrosString[1024];
                    if (lista_parametros) {
                        strcpy(parametrosString, "(");
                        param_list *methodParams = lista_parametros;
                        if (strcmp(methodParams->paramType, "Vazio")) {

                            int count = 0;
                            // Verificar se ha mais do que um argumento na funcao para meter virgulas entre eles
                            while (methodParams != NULL) {
                                count++;
                                methodParams = methodParams->next;
                            }

                            methodParams = lista_parametros;
                            // So ha um argumento
                            if (count < 1) {
                                strcat(parametrosString, methodParams->paramType);
                                // ha mais que um argumento
                            } else {
                                while (methodParams != NULL) {
                                    strcat(parametrosString, methodParams->paramType);
                                    if (count > 1)
                                        strcat(parametrosString, ",");
                                    count--;
                                    methodParams = methodParams->next;
                                }
                            }
                        }
                        strcat(parametrosString, ")");
                        if (DEBUG)
                            printf("-->%s|%s\n", methodOrField->child->child->brother->name, parametrosString);
                        tabela = searchTable(methodOrField->child->child->brother->name, parametrosString, lista);
                        if (tabela && tabela->comment == 0) {
                            struct node *methodBody = methodOrField->child->brother;
                            tabela->comment = 1;
                            if (!strcmp(methodBody->var, "MethodBody")) {
                                struct node *varDeclOrReturn = methodBody->child;
                                while (varDeclOrReturn) {
                                    if (!strcmp(varDeclOrReturn->var, "VarDecl")) {
                                        add_symbol(tabela, varDeclOrReturn->child->brother->name, getType(varDeclOrReturn->child->var), NULL, varDeclOrReturn->child->brother, 0, 0, 0);
                                    } else if (!strcmp(varDeclOrReturn->var, "Return")) {
                                        char *aux;
                                        int c = 0;
                                        if (varDeclOrReturn->child) {
                                            // aux = malloc(sizeof(char) * 128);
                                            aux = strdup(getTypeOperation(varDeclOrReturn->child, global, tabela, 0));
                                            // aux = getTypeOperation(varDeclOrReturn->child, global, tabela, 0) ;
                                            c = 1;
                                        } else {
                                            // aux = malloc(sizeof(char) * 128);
                                            aux = strdup("void");
                                            // strcpy(aux, "void");
                                        }

                                        if (aux == NULL) {
                                            printf("Line %d, col %d: Cannot find symbol %s\n", varDeclOrReturn->child->linha, varDeclOrReturn->child->coluna, varDeclOrReturn->child->var); // FIXME: A variavel existe !!
                                        } else if (!strcmp(aux, "void") && !strcmp("void", tabela->symbols->type) && c == 1) {
                                            printf("Line %d, col %d: Incompatible type %s in return statement\n", varDeclOrReturn->child->child->linha, varDeclOrReturn->child->child->coluna, aux);
                                        } else if ((!strcmp(aux, "int") && !strcmp("double", tabela->symbols->type))) {
                                            // continua
                                        } else if ((strcmp(aux, tabela->symbols->type))) {
                                            if (varDeclOrReturn->child && varDeclOrReturn->child->child) {
                                                if (!strcmp("Call", varDeclOrReturn->child->var)) {
                                                    printf("Line %d, col %d: Incompatible type %s in return statement\n", varDeclOrReturn->child->child->linha, varDeclOrReturn->child->child->coluna, aux);
                                                } else {
                                                    printf("Line %d, col %d: Incompatible type %s in return statement\n", varDeclOrReturn->child->linha, varDeclOrReturn->child->coluna, aux);
                                                }
                                            } else if (varDeclOrReturn->child) {
                                                printf("Line %d, col %d: Incompatible type %s in return statement\n", varDeclOrReturn->child->linha, varDeclOrReturn->child->coluna, aux);
                                            } else {
                                                printf("Line %d, col %d: Incompatible type %s in return statement\n", varDeclOrReturn->linha, varDeclOrReturn->coluna, aux);
                                            }
                                        }
                                    } else {
                                        getTypeOperation(varDeclOrReturn, global, tabela, 0);
                                        // printf("%s\n",varDeclOrReturn->var);
                                    }
                                    varDeclOrReturn = varDeclOrReturn->brother;
                                }
                            }
                        }
                    }
                }
            }
        }
        methodOrField = methodOrField->brother;
    }
}

sym_tab_list *create_symbol_tab_list(struct node *raiz) {
    sym_tab_list *table_list = NULL;
    sym_tab *global = create_sym_tab(raiz->child, NULL, 1);
    if (DEBUG)
        printf("%s\n", global->name);
    table_list = add_sym_table(table_list, global);

    // Pode ser MethodDecl ou FieldDecl
    node *methodOrField = raiz->child->brother;
    while (methodOrField) {
        if (!strcmp(methodOrField->var, "FieldDecl")) {
            if (DEBUG)
                printf("FieldDecl\n");
            add_symbol(global, methodOrField->child->brother->name, getType(methodOrField->child->var), NULL, methodOrField->child->brother, 0, 0, 0);
            if (DEBUG)
                printf("ADD_FieldDecl\n");

        } else if (!strcmp(methodOrField->var, "MethodDecl")) {
            if (DEBUG)
                printf("MethodDecl\n");
            sym_tab *tabela = (struct tabela_simbolos *)malloc(sizeof(struct tabela_simbolos));
            // Contem o nome da funcao
            if (!strcmp(methodOrField->child->var, "MethodHeader")) {
                if (DEBUG)
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
                            if (DEBUG)
                                printf("MethodParams\n");
                            lista_parametros = create_param_list(lista_parametros, parametros->child, 1);

                            //====================
                            parametros = parametros->brother;
                        }
                    } else {
                        lista_parametros = (struct parametros_funcao *)malloc(sizeof(struct parametros_funcao));
                        // lista_parametros->paramType = malloc(sizeof(char) * 128);
                        lista_parametros->paramType = strdup("Vazio");
                        // strcpy(lista_parametros->paramType, "Vazio");
                        lista_parametros->next = NULL;
                    }

                    char *parametrosString;
                    parametrosString = add_symbol(global, methodOrField->child->child->brother->name, getType(methodOrField->child->child->var), lista_parametros, methodOrField->child->child->brother, 0, 0, 0);
                    if (parametrosString) {

                        tabela = create_sym_tab(methodOrField->child->child->brother, parametrosString, 0);

                        if (DEBUG)
                            printf("MethodHeader -> create_sym_tab\n");
                        add_sym_table(table_list, tabela);

                        if (DEBUG)
                            printf("MethodHeader -> add_sym_table\n");
                        // COLOCA RETURN
                        add_symbol(tabela, "return", getType(methodOrField->child->child->var), NULL, NULL, 0, 0, 0);
                        // COLOCAR OS PARAMETROS

                        param_list *lista = lista_parametros;
                        if (lista && strcmp(lista->paramType, "Vazio")) {

                            while (lista != NULL) {
                                if (verifyParams(lista, tabela) == NULL) {
                                    add_symbol(tabela, lista->paramId, lista->paramType, NULL, NULL, lista->linha, lista->col, 1);
                                }
                                lista = lista->next;
                            }
                        }
                    } else {
                        param_list *lista = lista_parametros;
                        if (lista) {
                            int count = 1;
                            while (lista->next != NULL) { // comeca a partir do segundo se existir
                                lista = lista->next;
                                param_list *listafor = lista_parametros;
                                for (int i = 0; i < count; i++) {
                                    if (!strcmp(lista->paramId, listafor->paramId)) {
                                        printf("Line %d, col %d: Symbol %s already defined\n", lista->linha, lista->col, lista->paramId);
                                        break;
                                    }
                                    listafor = listafor->next;
                                }
                                count++;
                            }
                        }
                    }
                }
            }
        }
        methodOrField = methodOrField->brother;
    }

    // correr  a arvore outra vez para anotar
    commentnodes(raiz, global, table_list);
    if (DEBUG)
        printf("FIM_CREATE_SYMBOL_TABLE_LIST\n");
    return table_list;
}
