/* ===================================================================================
	    Compiladores -  Eduardo Figueiredo 2020213717
                        Fábio Santos       2020212310
    ====================================================================================== */

#include "symtab.h"


void print_tabs(sym_tab_list *lista){

    sym_tab_list *aux_table_list = lista; 

    while(aux_table_list != NULL){

        sym_tab *aux_tab = aux_table_list->tab;
        sym_list *aux_sym_list = aux_tab->symbols;

        printf("==== %s %s Symbol Table ====\n", aux_tab->type, aux_tab->name);

        while(aux_sym_list != NULL){
            param_list *paramTypes = aux_sym_list->atual->paramTypes;

            if(paramTypes != NULL){
                char parametros[256];
                int count = 1;

                // Verificar se ha mais do que um argumento na funcao para meter virgulas entre eles
                while(paramTypes != NULL){
                    count++;
                    paramTypes = paramTypes->next;
                }

                count = 1;
                paramTypes = aux_sym_list->atual->paramTypes;
                // So ha um argumento
                if(count < 2){
                    strcpy(parametros, paramTypes->paramType);

                // ha mais que um argumento
                }else{
                    while(paramTypes != NULL){
                        strcat(parametros, paramTypes->paramType);
                        if(count > 1) strcat(parametros, ",");
                        count++;
                        paramTypes = paramTypes->next;
                    }
                }

                if(aux_sym_list->atual->param){
                    printf("%s\t(%s)\t%s\tparam", aux_sym_list->atual->name, parametros, aux_sym_list->atual->type);
                }else{
                    printf("%s\t(%s)\t%s", aux_sym_list->atual->name, parametros, aux_sym_list->atual->type);
                }
            
            } else{
                if(aux_sym_list->atual->param){
                    printf("%s\t%s\tparam", aux_sym_list->atual->name, aux_sym_list->atual->type);
                } else {
                    printf("%s\t%s", aux_sym_list->atual->name, aux_sym_list->atual->type);
                }
            }

            aux_sym_list = aux_sym_list->next;
        }

        aux_table_list = aux_table_list->next;
    }
    
}

// TODO: paramTypes

symbol *add_symbol(char *name, char *type, int is_param){
    symbol* aux = (symbol*) malloc(sizeof(symbol));
    aux->name = name;
    aux->type = type;
    aux->param = is_param;
    // aux->

    return aux;
}

sym_tab *create_sym_tab(struct node * no){
    sym_tab *symbol_table = (sym_tab *) malloc(sizeof(sym_tab));
    // TODO: compor
    symbol_table->name = "Factorial";
    symbol_table->type = "Method/Class";
    symbol *sym = add_symbol(no->var, no->var, 0);
    


}

sym_tab_list *create_symbol_tab_list(struct node * raiz){
    sym_tab_list *table_list = (sym_tab_list *) malloc(sizeof(sym_tab_list));
    create_sym_tab(raiz);
    
    return table_list;
}
