%{
    /* ===================================================================================
	    Compiladores -  Eduardo Figueiredo 2020213717
                        Fábio Santos       2020212310
    ====================================================================================== */
    #include <stdio.h>
    #include "STree.h"
    #include "symtab.h"
    
    int yylex(void);
    extern int mostraTree;
    char message[1024];
    char lastType[64];
    int debug = 1; //DEBUG: variavel apenas para debug!!!
    extern int erroSintax; 
    extern int contador_linhas;
    extern int contador_colunas;
    extern struct node * raiz;
    extern struct lista_tabs *lista_tabelas;
    void yyerror (const char *s);
%}

%union{
    char *id;
    struct node * no;
}

%token STRING AND ASSIGN STAR COMMA DIV DOTLENGTH EQ GE GT LBRACE LE LPAR LSQ LT MINUS MOD NE NOT OR PLUS RBRACE RPAR RSQ SEMICOLON LSHIFT RSHIFT XOR BOOL CLASS DOUBLE ELSE IF INT PRINT PARSEINT PUBLIC RETURN STATIC VOID WHILE
%token RESERVED ARROW 

%token <id> ID
%token <id> STRLIT
%token <id> REALLIT
%token <id> INTLIT
%token <id> BOOLLIT

%left   COMMA 
%right  ASSIGN 
%left   OR
%left   AND
%left   XOR
%left   EQ NE
%left   LE LT GE GT
%left   RSHIFT LSHIFT
%left   PLUS MINUS 
%left   STAR DIV MOD
%right  NOT
%left   RPAR LPAR RSQ LSQ

%type <no> Program
%type <no> Declarations
%type <no> MethodDecl
%type <no> FieldDecl
%type <no> Variaveis
%type <no> Type
%type <no> MethodHeader
%type <no> FormalParams
%type <no> Parametros
%type <no> MethodBody
%type <no> Expressao
%type <no> VarDecl
%type <no> VariaveisVar
%type <no> Statement
%type <no> recursaoS
%type <no> MethodInvocation
%type <no> CommaExpr
%type <no> Assignment
%type <no> ParseArgs
%type <no> Expr
%type <no> Expr2

%nonassoc ELSE

%%
                                                                                                                                                                                                                                                                                      
Program         :       CLASS ID LBRACE Declarations RBRACE                 {$$ = raiz = newNode("Program","", contador_linhas, contador_colunas); sprintf(message,"Id(%s)",$2); $$->child = newNode(strdup(message),strdup($2), contador_linhas, contador_colunas); addBrother($$->child , $4);}
                ;

Declarations    :       MethodDecl Declarations                             {$$ = $1;addBrother($$,$2);}
                |       FieldDecl Declarations                              {$$ = $1;addBrother($$,$2);}
                |       SEMICOLON Declarations                              {$$ = $2;};                
                |                                                           {$$ = NULL;}
                ;

MethodDecl      :       PUBLIC STATIC MethodHeader MethodBody               {$$ = newNode("MethodDecl","", contador_linhas, contador_colunas);$$->child = $3;addBrother($$->child,$4);}
                                                                            
FieldDecl       :       PUBLIC STATIC Type ID Variaveis SEMICOLON           {$$ = newNode("FieldDecl","", contador_linhas, contador_colunas); $$->child = $3; sprintf(message,"Id(%s)",$4);struct node * id = newNode(strdup(message),strdup($4), contador_linhas, contador_colunas); addBrother($$->child,id); addBrother($$,$5);}
                |       error SEMICOLON                                     {$$ = newNode(NULL,"", contador_linhas, contador_colunas);erroSintax = 1;}
                ;

Variaveis       :       COMMA ID Variaveis                                  {$$ = newNode("FieldDecl","", contador_linhas, contador_colunas); struct node * type = newNode(strdup(lastType),"", contador_linhas, contador_colunas);$$->child = type; sprintf(message,"Id(%s)",$2); struct node * id = newNode(strdup(message),strdup($2), contador_linhas, contador_colunas); addBrother($$->child,id); addBrother($$,$3); }
                |                                                           {$$ = NULL;}
                ;

Type            :       BOOL                                                {$$ = newNode("Bool","", contador_linhas, contador_colunas);memset(lastType,0,64);strcpy(lastType,"Bool");}
                |       INT                                                 {$$ = newNode("Int","", contador_linhas, contador_colunas);memset(lastType,0,64);strcpy(lastType,"Int");}
                |       DOUBLE                                              {$$ = newNode("Double","", contador_linhas, contador_colunas);memset(lastType,0,64);strcpy(lastType,"Double");}
                ;

MethodHeader    :       Type ID LPAR FormalParams RPAR                      {$$ = newNode("MethodHeader","", contador_linhas, contador_colunas); $$->child = $1;sprintf(message,"Id(%s)",$2); node * id = newNode(strdup(message),strdup($2), contador_linhas, contador_colunas); addBrother($$->child,id);addBrother(id,$4);}
                |       VOID ID LPAR FormalParams RPAR                      {$$ = newNode("MethodHeader","", contador_linhas, contador_colunas);$$->child = newNode("Void","", contador_linhas, contador_colunas);sprintf(message,"Id(%s)",$2); node * id = newNode(strdup(message),strdup($2), contador_linhas, contador_colunas);addBrother($$->child,id);addBrother(id,$4);}
                |       Type ID LPAR RPAR                                   {$$ = newNode("MethodHeader","", contador_linhas, contador_colunas);$$->child = $1;sprintf(message,"Id(%s)",$2); node * id = newNode(strdup(message),strdup($2), contador_linhas, contador_colunas);addBrother($$->child,id); addBrother(id,newNode("MethodParams","", contador_linhas, contador_colunas));}
                |       VOID ID LPAR RPAR                                   {$$ = newNode("MethodHeader","", contador_linhas, contador_colunas);$$->child = newNode("Void","", contador_linhas, contador_colunas);sprintf(message,"Id(%s)",$2); node * id = newNode(strdup(message),strdup($2), contador_linhas, contador_colunas);addBrother($$->child,id); addBrother(id,newNode("MethodParams","", contador_linhas, contador_colunas));}
                ;
                                                                            
FormalParams    :       Type ID Parametros                                  {$$ = newNode("MethodParams","", contador_linhas, contador_colunas);node * param = newNode("ParamDecl","", contador_linhas, contador_colunas); param->child = $1; sprintf(message,"Id(%s)",$2); node * id = newNode(strdup(message),strdup($2), contador_linhas, contador_colunas); addBrother(param->child,id); $$->child = param;addBrother($$->child,$3);}
                |       STRING LSQ RSQ ID                                   {$$ = newNode("MethodParams","", contador_linhas, contador_colunas);node * param = newNode("ParamDecl","", contador_linhas, contador_colunas); node * array = newNode("StringArray","", contador_linhas, contador_colunas); param->child = array;sprintf(message,"Id(%s)",$4); node * id = newNode(strdup(message),strdup($4), contador_linhas, contador_colunas); addBrother(param->child,id);$$->child = param;}
                ;

Parametros      :       COMMA Type ID Parametros                            {$$ = newNode("ParamDecl","", contador_linhas, contador_colunas);$$->child = $2;sprintf(message,"Id(%s)",$3); node * id = newNode(strdup(message),strdup($3), contador_linhas, contador_colunas);addBrother($$->child,id);addBrother($$,$4);}
                |                                                           {$$ = NULL;}
                ;                                                           

MethodBody      :       LBRACE Expressao RBRACE                             {$$ = newNode("MethodBody","", contador_linhas, contador_colunas);$$->child = $2;}
                ;

Expressao       :       Statement Expressao                                 {if($1) {$$ = $1; addBrother($$, $2);}else{$$=$2;}}
                |       VarDecl Expressao                                   {$$ = $1;addBrother($$,$2);}
                |                                                           {$$ = NULL;}
                ;
                                                                            
VarDecl         :       Type ID VariaveisVar SEMICOLON                      {$$ = newNode("VarDecl","", contador_linhas, contador_colunas); $$->child = $1;sprintf(message,"Id(%s)",$2); node * id = newNode(strdup(message),strdup($2), contador_linhas, contador_colunas); addBrother($$->child,id);addBrother($$,$3);}
                ;

VariaveisVar    :       COMMA ID VariaveisVar                               {$$ = newNode("VarDecl","", contador_linhas, contador_colunas); node * type = newNode(strdup(lastType),"", contador_linhas, contador_colunas); $$->child = type; sprintf(message,"Id(%s)",$2); node * id = newNode(strdup(message),strdup($2), contador_linhas, contador_colunas); addBrother($$->child,id); addBrother($$,$3);}
                |                                                           {$$ = NULL;}
                ;

Statement       :       LBRACE recursaoS RBRACE                             {if ($2!=NULL){if ($2->brother != NULL){$$ = newNode("Block","", contador_linhas, contador_colunas); $$->child = $2;} else {$$ = $2;}} else {$$ = $2;};}
                |       IF LPAR Expr RPAR Statement  ELSE Statement         {$$ = newNode("If","", contador_linhas, contador_colunas); $$->child = $3;
                                                                                    if ($5 != NULL && numBrothers($5) == 1) {
                                                                                        addBrother($3, $5);
                                                                                        if ($7 != NULL && numBrothers($7) == 1){
                                                                                            addBrother($5, $7);
                                                                                        } else {
                                                                                            addBrother($5, newNode("Block","", contador_linhas, contador_colunas));
                                                                                            $5->brother->child = $7;
                                                                                        }
                                                                                    } else {
                                                                                        struct node * temp = newNode("Block","", contador_linhas, contador_colunas);
                                                                                        addBrother($3, temp);
                                                                                        temp->child = $5;
                                                                                        if($7 != NULL && numBrothers($7) == 1){
                                                                                            addBrother(temp, $7); 
                                                                                        }
                                                                                        else{
                                                                                            addBrother(temp, newNode("Block","", contador_linhas, contador_colunas));
                                                                                            temp->brother->child = $7;
                                                                                        }
                                                                                    }
                                                                            }
                |       IF LPAR Expr RPAR Statement                         {$$ = newNode("If","", contador_linhas, contador_colunas); $$->child = $3;
                                                                                    if ($5!=NULL && numBrothers($5) == 1) {
                                                                                        addBrother($3, $5);
                                                                                        addBrother($5, newNode("Block","", contador_linhas, contador_colunas));
                                                                                    } else {
                                                                                        struct node * temp = newNode("Block","", contador_linhas, contador_colunas);
                                                                                        addBrother($3, temp);
                                                                                        temp->child = $5;
                                                                                        addBrother(temp, newNode("Block","", contador_linhas, contador_colunas));
                                                                                    }
                                                                            }
                |       WHILE LPAR Expr RPAR Statement                      {$$ = newNode("While","", contador_linhas, contador_colunas); $$->child = $3; 
                                                                                    if($5 != NULL && numBrothers($5) < 2){
                                                                                        addBrother($3, $5);
                                                                                    } else{
                                                                                        addBrother($3, newNode("Block","", contador_linhas, contador_colunas));
                                                                                        $3->brother->child = $5;
                                                                                    }
                                                                            }
                |       RETURN Expr SEMICOLON                               {$$ = newNode("Return","", contador_linhas, contador_colunas); $$->child = $2;} 
                |       RETURN SEMICOLON                                    {$$ = newNode("Return","", contador_linhas, contador_colunas);}
                |       PRINT LPAR Expr RPAR SEMICOLON                      {$$ = newNode("Print","", contador_linhas, contador_colunas); $$->child = $3;}
                |       PRINT LPAR STRLIT RPAR SEMICOLON                    {$$ = newNode("Print","", contador_linhas, contador_colunas); sprintf(message, "StrLit(\"%s)", $3); $$->child = newNode(strdup(message),strdup($3), contador_linhas, contador_colunas);}  
                |       MethodInvocation SEMICOLON                          {$$ = $1;}
                |       Assignment SEMICOLON                                {$$ = $1;}
                |       ParseArgs SEMICOLON                                 {$$ = $1;}
                |       SEMICOLON                                           {$$ = NULL;}
                |       error SEMICOLON                                     {$$ = newNode(NULL,NULL, contador_linhas, contador_colunas);erroSintax = 1;}
                ;

recursaoS       :       Statement recursaoS                                 {if($$!=NULL){$$=$1; addBrother($$,$2);} else{$$=$2;}}
                |                                                           {$$ = NULL;}
                ; 
                                                                            
MethodInvocation:       ID LPAR Expr CommaExpr RPAR                         {$$ = newNode("Call","", contador_linhas, contador_colunas); sprintf(message, "Id(%s)", $1); $$->child = newNode(strdup(message),strdup($1), contador_linhas, contador_colunas); addBrother($$->child, $3); addBrother($3, $4);}
                |       ID LPAR RPAR                                        {$$ = newNode("Call","", contador_linhas, contador_colunas); sprintf(message, "Id(%s)", $1); $$->child = newNode(strdup(message),strdup($1), contador_linhas, contador_colunas);}
                |       ID LPAR error RPAR                                  {$$ = newNode(NULL,NULL, contador_linhas, contador_colunas);erroSintax = 1;}
                ;

CommaExpr       :       COMMA Expr CommaExpr                                {$$ = $2; addBrother($2, $3);}
                |                                                           {$$ = NULL;}
                ;

Assignment      :       ID ASSIGN Expr                                      {$$ = newNode("Assign","", contador_linhas, contador_colunas); sprintf(message, "Id(%s)", $1); $$->child = newNode(strdup(message),strdup($1), contador_linhas, contador_colunas); addBrother($$->child, $3);}
                ;

ParseArgs       :       PARSEINT LPAR ID LSQ Expr RSQ RPAR                  {$$ = newNode("ParseArgs","", contador_linhas, contador_colunas); sprintf(message, "Id(%s)", $3); $$->child = newNode(strdup(message),strdup($3), contador_linhas, contador_colunas); addBrother($$->child, $5);}
                |       PARSEINT LPAR error RPAR                            {$$ = newNode(NULL,NULL, contador_linhas, contador_colunas);erroSintax = 1;}    
                ;

Expr            :       Assignment                                          {$$ = $1;}
                |       Expr2                                               {$$ = $1;}
                ;


Expr2           :       Expr2 PLUS Expr2                                    {$$ = newNode("Add","", contador_linhas, contador_colunas); $$->child=$1; addBrother($1,$3);}
                |       Expr2 MINUS Expr2                                   {$$ = newNode("Sub","", contador_linhas, contador_colunas); $$->child=$1; addBrother($1,$3);}
                |       Expr2 STAR Expr2                                    {$$ = newNode("Mul","", contador_linhas, contador_colunas); $$->child=$1; addBrother($1,$3);}
                |       Expr2 DIV Expr2                                     {$$ = newNode("Div","", contador_linhas, contador_colunas); $$->child=$1; addBrother($1,$3);}
                |       Expr2 MOD Expr2                                     {$$ = newNode("Mod","", contador_linhas, contador_colunas); $$->child=$1; addBrother($1,$3);}
                |       Expr2 AND Expr2                                     {$$ = newNode("And","", contador_linhas, contador_colunas); $$->child=$1; addBrother($1,$3);}
                |       Expr2 OR Expr2                                      {$$ = newNode("Or","", contador_linhas, contador_colunas); $$->child=$1; addBrother($1,$3);}
                |       Expr2 XOR Expr2                                     {$$ = newNode("Xor","", contador_linhas, contador_colunas); $$->child=$1; addBrother($1,$3);}
                |       Expr2 LSHIFT Expr2                                  {$$ = newNode("Lshift","", contador_linhas, contador_colunas); $$->child=$1; addBrother($1,$3);}
                |       Expr2 RSHIFT Expr2                                  {$$ = newNode("Rshift","", contador_linhas, contador_colunas); $$->child=$1; addBrother($1,$3);}
                |       Expr2 EQ Expr2                                      {$$ = newNode("Eq","", contador_linhas, contador_colunas); $$->child=$1; addBrother($1,$3);}
                |       Expr2 GE Expr2                                      {$$ = newNode("Ge","", contador_linhas, contador_colunas); $$->child=$1; addBrother($1,$3);}
                |       Expr2 GT Expr2                                      {$$ = newNode("Gt","", contador_linhas, contador_colunas); $$->child=$1; addBrother($1,$3);}
                |       Expr2 LE Expr2                                      {$$ = newNode("Le","", contador_linhas, contador_colunas); $$->child=$1; addBrother($1,$3);}
                |       Expr2 LT Expr2                                      {$$ = newNode("Lt","", contador_linhas, contador_colunas); $$->child=$1; addBrother($1,$3);}
                |       Expr2 NE Expr2                                      {$$ = newNode("Ne","", contador_linhas, contador_colunas); $$->child=$1; addBrother($1,$3);}
                |       MINUS Expr2        %prec NOT                        {$$ = newNode("Minus","", contador_linhas, contador_colunas); $$->child=$2;}
                |       PLUS Expr2         %prec NOT                        {$$ = newNode("Plus","", contador_linhas, contador_colunas); $$->child=$2;}
                |       NOT Expr2                                           {$$ = newNode("Not","", contador_linhas, contador_colunas); $$->child=$2;}
                |       LPAR Expr RPAR                                      {$$ = $2;}
                |       MethodInvocation                                    {$$ = $1;}
                |       ParseArgs                                           {$$ = $1;}
                |       ID DOTLENGTH                                        {$$ = newNode("Length","", contador_linhas, contador_colunas); sprintf(message, "Id(%s)", $1); $$->child = newNode(strdup(message),strdup($1), contador_linhas, contador_colunas);} 
                |       ID                                                  {sprintf(message, "Id(%s)", $1); $$ = newNode(strdup(message),strdup($1), contador_linhas, contador_colunas);}
                |       INTLIT                                              {sprintf(message, "DecLit(%s)", $1); $$ = newNode(strdup(message),strdup($1), contador_linhas, contador_colunas);}
                |       REALLIT                                             {sprintf(message, "RealLit(%s)", $1); $$ = newNode(strdup(message),strdup($1), contador_linhas, contador_colunas);}
                |       BOOLLIT                                             {sprintf(message, "BoolLit(%s)", $1); $$ = newNode(strdup(message),strdup($1), contador_linhas, contador_colunas);}
                |       LPAR error RPAR                                     {$$ = newNode(NULL,NULL, contador_linhas, contador_colunas); erroSintax = 1;}
                ;

%%
