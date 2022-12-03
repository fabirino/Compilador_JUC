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
    extern int col;
    extern int yyleng;
    extern struct node * raiz;
    extern struct lista_tabs *lista_tabelas;
    void yyerror (const char *s);
%}

%union{
    struct node * no;
    struct Info{
        char* message;
        int line;
        int col;
    }info;
}

%token STRING COMMA LBRACE LPAR LSQ RBRACE RPAR RSQ SEMICOLON BOOL CLASS DOUBLE ELSE IF INT PRINT PUBLIC STATIC VOID WHILE
%token RESERVED ARROW 

%token <info> ID
%token <info> STRLIT
%token <info> REALLIT
%token <info> INTLIT
%token <info> BOOLLIT
%token <info> RETURN
%token <info> PARSEINT
%token <info> DOTLENGTH
%token <info> PLUS
%token <info> OR
%token <info> NOT
%token <info> NE
%token <info> MOD
%token <info> MINUS
%token <info> LSHIFT
%token <info> RSHIFT
%token <info> LT
%token <info> LE
%token <info> GT
%token <info> GE
%token <info> EQ
%token <info> DIV
%token <info> ASSIGN
%token <info> AND
%token <info> STAR
%token <info> XOR


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
                                                                                                                                                                                                                                                                                      
Program         :       CLASS ID LBRACE Declarations RBRACE                 {$$ = raiz = newNode("Program","", contador_linhas, col); sprintf(message,"Id(%s)",$2.message); $$->child = newNode(strdup(message),strdup($2.message), $2.line, $2.col); addBrother($$->child , $4);}
                ;

Declarations    :       MethodDecl Declarations                             {$$ = $1;addBrother($$,$2);}
                |       FieldDecl Declarations                              {$$ = $1;addBrother($$,$2);}
                |       SEMICOLON Declarations                              {$$ = $2;};                
                |                                                           {$$ = NULL;}
                ;

MethodDecl      :       PUBLIC STATIC MethodHeader MethodBody               {$$ = newNode("MethodDecl","", contador_linhas, col);$$->child = $3;addBrother($$->child,$4);}
                                                                            
FieldDecl       :       PUBLIC STATIC Type ID Variaveis SEMICOLON           {$$ = newNode("FieldDecl","", contador_linhas, col); $$->child = $3; sprintf(message,"Id(%s)",$4.message);struct node * id = newNode(strdup(message),strdup($4.message), $4.line, $4.col); addBrother($$->child,id); addBrother($$,$5);}
                |       error SEMICOLON                                     {$$ = newNode(NULL,"", contador_linhas, col);erroSintax = 1;}
                ;

Variaveis       :       COMMA ID Variaveis                                  {$$ = newNode("FieldDecl","", contador_linhas, col); struct node * type = newNode(strdup(lastType),"", contador_linhas, col);$$->child = type; sprintf(message,"Id(%s)",$2.message); struct node * id = newNode(strdup(message),strdup($2.message), $2.line, $2.col); addBrother($$->child,id); addBrother($$,$3); }
                |                                                           {$$ = NULL;}
                ;

Type            :       BOOL                                                {$$ = newNode("Bool","", contador_linhas, col);memset(lastType,0,64);strcpy(lastType,"Bool");}
                |       INT                                                 {$$ = newNode("Int","", contador_linhas, col);memset(lastType,0,64);strcpy(lastType,"Int");}
                |       DOUBLE                                              {$$ = newNode("Double","", contador_linhas, col);memset(lastType,0,64);strcpy(lastType,"Double");}
                ;

MethodHeader    :       Type ID LPAR FormalParams RPAR                      {$$ = newNode("MethodHeader","", contador_linhas, col); $$->child = $1;sprintf(message,"Id(%s)",$2.message); node * id = newNode(strdup(message),strdup($2.message), $2.line, $2.col); addBrother($$->child,id);addBrother(id,$4);}
                |       VOID ID LPAR FormalParams RPAR                      {$$ = newNode("MethodHeader","", contador_linhas, col);$$->child = newNode("Void","", contador_linhas, col);sprintf(message,"Id(%s)",$2.message); node * id = newNode(strdup(message),strdup($2.message), $2.line, $2.col);addBrother($$->child,id);addBrother(id,$4);}
                |       Type ID LPAR RPAR                                   {$$ = newNode("MethodHeader","", contador_linhas, col);$$->child = $1;sprintf(message,"Id(%s)",$2.message); node * id = newNode(strdup(message),strdup($2.message), $2.line, $2.col);addBrother($$->child,id); addBrother(id,newNode("MethodParams","", contador_linhas, col));}
                |       VOID ID LPAR RPAR                                   {$$ = newNode("MethodHeader","", contador_linhas, col);$$->child = newNode("Void","", contador_linhas, col);sprintf(message,"Id(%s)",$2.message); node * id = newNode(strdup(message),strdup($2.message), $2.line, $2.col);addBrother($$->child,id); addBrother(id,newNode("MethodParams","", contador_linhas, col));}
                ;
                                                                            
FormalParams    :       Type ID Parametros                                  {$$ = newNode("MethodParams","", contador_linhas, col);node * param = newNode("ParamDecl","", contador_linhas, col); param->child = $1; sprintf(message,"Id(%s)",$2.message); node * id = newNode(strdup(message),strdup($2.message), $2.line, $2.col); addBrother(param->child,id); $$->child = param;addBrother($$->child,$3);}
                |       STRING LSQ RSQ ID                                   {$$ = newNode("MethodParams","", contador_linhas, col);node * param = newNode("ParamDecl","", contador_linhas, col); node * array = newNode("StringArray","", contador_linhas, col); param->child = array;sprintf(message,"Id(%s)",$4.message); node * id = newNode(strdup(message),strdup($4.message), $4.line, $4.col); addBrother(param->child,id);$$->child = param;}
                ;

Parametros      :       COMMA Type ID Parametros                            {$$ = newNode("ParamDecl","", contador_linhas, col);$$->child = $2;sprintf(message,"Id(%s)",$3.message); node * id = newNode(strdup(message),strdup($3.message), $3.line, $3.col);addBrother($$->child,id);addBrother($$,$4);}
                |                                                           {$$ = NULL;}
                ;                                                           

MethodBody      :       LBRACE Expressao RBRACE                             {$$ = newNode("MethodBody","", contador_linhas, col);$$->child = $2;}
                ;

Expressao       :       Statement Expressao                                 {if($1) {$$ = $1; addBrother($$, $2);}else{$$=$2;}}
                |       VarDecl Expressao                                   {$$ = $1;addBrother($$,$2);}
                |                                                           {$$ = NULL;}
                ;
                                                                            
VarDecl         :       Type ID VariaveisVar SEMICOLON                      {$$ = newNode("VarDecl","", contador_linhas, col); $$->child = $1;sprintf(message,"Id(%s)",$2.message); node * id = newNode(strdup(message),strdup($2.message), $2.line, $2.col); addBrother($$->child,id);addBrother($$,$3);}
                ;

VariaveisVar    :       COMMA ID VariaveisVar                               {$$ = newNode("VarDecl","", contador_linhas, col); node * type = newNode(strdup(lastType),"", contador_linhas, col); $$->child = type; sprintf(message,"Id(%s)",$2.message); node * id = newNode(strdup(message),strdup($2.message), $2.line, $2.col); addBrother($$->child,id); addBrother($$,$3);}
                |                                                           {$$ = NULL;}
                ;

Statement       :       LBRACE recursaoS RBRACE                             {if ($2!=NULL){if ($2->brother != NULL){$$ = newNode("Block","", contador_linhas, col); $$->child = $2;} else {$$ = $2;}} else {$$ = $2;};}
                |       IF LPAR Expr RPAR Statement  ELSE Statement         {$$ = newNode("If","", contador_linhas, col); $$->child = $3;
                                                                                    if ($5 != NULL && numBrothers($5) == 1) {
                                                                                        addBrother($3, $5);
                                                                                        if ($7 != NULL && numBrothers($7) == 1){
                                                                                            addBrother($5, $7);
                                                                                        } else {
                                                                                            addBrother($5, newNode("Block","", contador_linhas, col));
                                                                                            $5->brother->child = $7;
                                                                                        }
                                                                                    } else {
                                                                                        struct node * temp = newNode("Block","", contador_linhas, col);
                                                                                        addBrother($3, temp);
                                                                                        temp->child = $5;
                                                                                        if($7 != NULL && numBrothers($7) == 1){
                                                                                            addBrother(temp, $7); 
                                                                                        }
                                                                                        else{
                                                                                            addBrother(temp, newNode("Block","", contador_linhas, col));
                                                                                            temp->brother->child = $7;
                                                                                        }
                                                                                    }
                                                                            }
                |       IF LPAR Expr RPAR Statement                         {$$ = newNode("If","", contador_linhas, col); $$->child = $3;
                                                                                    if ($5!=NULL && numBrothers($5) == 1) {
                                                                                        addBrother($3, $5);
                                                                                        addBrother($5, newNode("Block","", contador_linhas, col));
                                                                                    } else {
                                                                                        struct node * temp = newNode("Block","", contador_linhas, col);
                                                                                        addBrother($3, temp);
                                                                                        temp->child = $5;
                                                                                        addBrother(temp, newNode("Block","", contador_linhas, col));
                                                                                    }
                                                                            }
                |       WHILE LPAR Expr RPAR Statement                      {$$ = newNode("While","", contador_linhas, col); $$->child = $3; 
                                                                                    if($5 != NULL && numBrothers($5) < 2){
                                                                                        addBrother($3, $5);
                                                                                    } else{
                                                                                        addBrother($3, newNode("Block","", contador_linhas,col));
                                                                                        $3->brother->child = $5;
                                                                                    }
                                                                            }
                |       RETURN Expr SEMICOLON                               {$$ = newNode("Return","", $1.line, $1.col); $$->child = $2;} 
                |       RETURN SEMICOLON                                    {$$ = newNode("Return","", $1.line, $1.col);}
                |       PRINT LPAR Expr RPAR SEMICOLON                      {$$ = newNode("Print","", contador_linhas, col); $$->child = $3;}
                |       PRINT LPAR STRLIT RPAR SEMICOLON                    {$$ = newNode("Print","", contador_linhas, col); sprintf(message, "StrLit(\"%s)", $3.message); $$->child = newNode(strdup(message),strdup($3.message), $3.line, $3.col);}  
                |       MethodInvocation SEMICOLON                          {$$ = $1;}
                |       Assignment SEMICOLON                                {$$ = $1;}
                |       ParseArgs SEMICOLON                                 {$$ = $1;}
                |       SEMICOLON                                           {$$ = NULL;}
                |       error SEMICOLON                                     {$$ = newNode(NULL,NULL, contador_linhas, col);erroSintax = 1;}
                ;

recursaoS       :       Statement recursaoS                                 {if($$!=NULL){$$=$1; addBrother($$,$2);} else{$$=$2;}}
                |                                                           {$$ = NULL;}
                ; 
                                                                            
MethodInvocation:       ID LPAR Expr CommaExpr RPAR                         {$$ = newNode("Call","", contador_linhas, col); sprintf(message, "Id(%s)", $1.message); $$->child = newNode(strdup(message),strdup($1.message), $1.line, $1.col); addBrother($$->child, $3); addBrother($3, $4);}
                |       ID LPAR RPAR                                        {$$ = newNode("Call","", contador_linhas, col); sprintf(message, "Id(%s)", $1.message); $$->child = newNode(strdup(message),strdup($1.message), $1.line, $1.col);}
                |       ID LPAR error RPAR                                  {$$ = newNode(NULL,NULL, contador_linhas, col);erroSintax = 1;}
                ;

CommaExpr       :       COMMA Expr CommaExpr                                {$$ = $2; addBrother($2, $3);}
                |                                                           {$$ = NULL;}
                ;

Assignment      :       ID ASSIGN Expr                                      {$$ = newNode("Assign","", $2.line, $2.col); sprintf(message, "Id(%s)", $1.message); $$->child = newNode(strdup(message),strdup($1.message), $1.line, $1.col); addBrother($$->child, $3);}
                ;

ParseArgs       :       PARSEINT LPAR ID LSQ Expr RSQ RPAR                  {$$ = newNode("ParseArgs","", $1.line, $1.col); sprintf(message, "Id(%s)", $3.message); $$->child = newNode(strdup(message),strdup($3.message), $3.line, $3.col); addBrother($$->child, $5);}
                |       PARSEINT LPAR error RPAR                            {$$ = newNode(NULL,NULL, contador_linhas, col);erroSintax = 1;}    
                ;

Expr            :       Assignment                                          {$$ = $1;}
                |       Expr2                                               {$$ = $1;}
                ;


Expr2           :       Expr2 PLUS Expr2                                    {$$ = newNode("Add","", $2.line, $2.col); $$->child=$1; addBrother($1,$3);}
                |       Expr2 MINUS Expr2                                   {$$ = newNode("Sub","", $2.line, $2.col); $$->child=$1; addBrother($1,$3);}
                |       Expr2 STAR Expr2                                    {$$ = newNode("Mul","", $2.line, $2.col); $$->child=$1; addBrother($1,$3);}
                |       Expr2 DIV Expr2                                     {$$ = newNode("Div","", $2.line, $2.col); $$->child=$1; addBrother($1,$3);}
                |       Expr2 MOD Expr2                                     {$$ = newNode("Mod","", $2.line, $2.col); $$->child=$1; addBrother($1,$3);}
                |       Expr2 AND Expr2                                     {$$ = newNode("And","", $2.line, $2.col); $$->child=$1; addBrother($1,$3);}
                |       Expr2 OR Expr2                                      {$$ = newNode("Or","", $2.line, $2.col); $$->child=$1; addBrother($1,$3);}
                |       Expr2 XOR Expr2                                     {$$ = newNode("Xor","", $2.line, $2.col); $$->child=$1; addBrother($1,$3);}
                |       Expr2 LSHIFT Expr2                                  {$$ = newNode("Lshift","", $2.line, $2.col); $$->child=$1; addBrother($1,$3);}
                |       Expr2 RSHIFT Expr2                                  {$$ = newNode("Rshift","", $2.line, $2.col); $$->child=$1; addBrother($1,$3);}
                |       Expr2 EQ Expr2                                      {$$ = newNode("Eq","", $2.line, $2.col); $$->child=$1; addBrother($1,$3);}
                |       Expr2 GE Expr2                                      {$$ = newNode("Ge","", $2.line, $2.col); $$->child=$1; addBrother($1,$3);}
                |       Expr2 GT Expr2                                      {$$ = newNode("Gt","", $2.line, $2.col); $$->child=$1; addBrother($1,$3);}
                |       Expr2 LE Expr2                                      {$$ = newNode("Le","", $2.line, $2.col); $$->child=$1; addBrother($1,$3);}
                |       Expr2 LT Expr2                                      {$$ = newNode("Lt","", $2.line, $2.col); $$->child=$1; addBrother($1,$3);}
                |       Expr2 NE Expr2                                      {$$ = newNode("Ne","", $2.line, $2.col); $$->child=$1; addBrother($1,$3);}
                |       MINUS Expr2        %prec NOT                        {$$ = newNode("Minus","", $1.line, $1.col); $$->child=$2;}
                |       PLUS Expr2         %prec NOT                        {$$ = newNode("Plus","",  $1.line, $1.col); $$->child=$2;}
                |       NOT Expr2                                           {$$ = newNode("Not","",   $1.line, $1.col); $$->child=$2;}
                |       LPAR Expr RPAR                                      {$$ = $2;}
                |       MethodInvocation                                    {$$ = $1;}
                |       ParseArgs                                           {$$ = $1;}
                |       ID DOTLENGTH                                        {$$ = newNode("Length","", $2.line, $2.col); sprintf(message, "Id(%s)", $1.message); $$->child = newNode(strdup(message),strdup($1.message), $1.line, $1.col);} 
                |       ID                                                  {sprintf(message, "Id(%s)", $1.message); $$ = newNode(strdup(message),strdup($1.message), $1.line, $1.col);}
                |       INTLIT                                              {sprintf(message, "DecLit(%s)", $1.message); $$ = newNode(strdup(message),strdup($1.message), $1.line, $1.col);}
                |       REALLIT                                             {sprintf(message, "RealLit(%s)", $1.message); $$ = newNode(strdup(message),strdup($1.message), $1.line, $1.col);}
                |       BOOLLIT                                             {sprintf(message, "BoolLit(%s)", $1.message); $$ = newNode(strdup(message),strdup($1.message), $1.line, $1.col);}
                |       LPAR error RPAR                                     {$$ = newNode(NULL,NULL, contador_linhas, col); erroSintax = 1;}
                ;

%%
