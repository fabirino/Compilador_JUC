%{
    /* ===================================================================================
	    Compiladores -  Eduardo Figueiredo 2020213717
                        Fábio Santos       2020212310
    ====================================================================================== */
    #include <stdio.h>
    #include "tree.h"
    
    int yylex(void);
    void yyerror (const char *s);
    extern int mostraTree;
    char message[256];
    char lastType[32];
    int debug = 0; //DEBUG: variavel apenas para debug!!!
    int erro = 0; 
    Node * raiz;
%}

%union{
    char *id;
    struct node *node;
}

%token STRING AND ASSIGN STAR COMMA DIV EQ GE GT LBRACE LE LPAR LSQ LT MINUS MOD NE NOT OR PLUS RBRACE RPAR RSQ SEMICOLON LSHIFT RSHIFT XOR BOOL CLASS DOUBLE ELSE IF INT PRINT PARSEINT PUBLIC RETURN STATIC VOID WHILE

%token <id> ID
%token <id> STRLIT
%token <id> REALLIT
%token <id> INTLIT
%token <id> BOOLLIT
%token <id> DOTLENGTH 

%right  ELSE IF
%left   COMMA 
%right  DOTLENGTH 
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

%type <node> Program
%type <node> Declarations
%type <node> MethodDecl
%type <node> FieldDecl
%type <node> Variaveis
%type <node> Type
%type <node> MethodHeader
%type <node> FormalParams
%type <node> Parametros
%type <node> MethodBody
%type <node> Expressao
%type <node> VarDecl
%type <node> VariaveisVar
%type <node> Statement
%type <node> recursaoS
%type <node> MethodInvocation
%type <node> CommaExpr
%type <node> Assignment
%type <node> ParseArgs
%type <node> Expr

%%
                                                                                                                                                                                                                                                                                      
Program         :       CLASS ID LBRACE Declarations RBRACE                 {$$ = raiz = newNode("Program"); sprintf(message,"Id(%s)",$2); $$->child = newNode(strdup(message));  addBrother($$->child, $4);if(debug){printf("Program1\n");} }
                |       CLASS ID LBRACE RBRACE                              {$$ = newNode("Program"); sprintf(message,"Id(%s)",$2); $$->child = newNode(strdup(message)); if(mostraTree){printTree($$,0);} else {freeTree($$);}if(debug)printf("Program2\n");}
                ;

Declarations    :       MethodDecl                                          {$$ = $1;if(debug)printf("Declarations1\n");}
                |       FieldDecl                                           {$$ = $1;if(debug)printf("Declarations2\n");}
                |       SEMICOLON                                           {if(debug)printf("Declarations3\n");}
                |       MethodDecl Declarations                             {$$ = $1; addBrother($$, $2);if(debug)printf("Declarations4\n");}
                |       FieldDecl Declarations                              {$$ = $1; addBrother($$, $2);if(debug)printf("Declarations5\n");}
                |       SEMICOLON Declarations                              {$$ = $2;if(debug)printf("Declarations6\n");}                ;

MethodDecl      :       PUBLIC STATIC MethodHeader MethodBody               {$$ = newNode("MethodDecl"); $$->child = $3; addBrother($3,$4);if(debug)printf("MethodDecl1\n");}
                                                                            
FieldDecl       :       PUBLIC STATIC Type ID SEMICOLON                     {$$ = newNode("FieldDecl"); $$->child = $3; sprintf(message,"Id(%s)",$4);  addBrother($3, newNode(strdup(message)));if(debug)printf("FieldDecl1\n");}
                |       PUBLIC STATIC Type ID Variaveis SEMICOLON           {$$ = newNode("FieldDecl"); $$->child = $3; sprintf(message,"Id(%s)",$4); Node *temp = newNode(strdup(message)); addBrother($3,temp); addBrother($$,$5);if(debug)printf("FieldDecl2\n");}
                |       error SEMICOLON                                     {$$ = newNode(NULL); erro=1;if(debug)printf("FieldDeclerror\n");}
                ;

Variaveis       :       COMMA ID                                            {$$ = newNode("FieldDecl"); Node * aux = newNode(strdup(lastType));$$->child = aux; sprintf(message,"Id(%s)",$2); addBrother(aux,newNode(strdup(message))); if(debug)printf("Variaveis1\n");}
                |       COMMA ID Variaveis                                  {Node * Var = newNode("FieldDecl"); $$ = Var; sprintf(message,"Id(%s)",$2); addBrother(Var,$3); Node * aux = newNode(strdup(lastType)); Var->child = aux; addBrother(aux,newNode(strdup(message))); if(debug)printf("Variaveis2\n");}
                ;

Type            :       BOOL                                                {$$ = newNode("Bool"); memset(lastType, 0, 32); strcpy(lastType, "Bool"); if(debug)printf("Type1\n");}
                |       INT                                                 {$$ = newNode("Int"); memset(lastType, 0, 32); strcpy(lastType, "Int"); if(debug)printf("Type2\n");}
                |       DOUBLE                                              {$$ = newNode("Double"); memset(lastType, 0, 32); strcpy(lastType, "Double"); if(debug)printf("Type3\n");}
                ;

MethodHeader    :       Type ID LPAR FormalParams RPAR                      {$$ = newNode("MethodHeader"); $$->child = $1; sprintf(message,"Id(%s)",$2); Node *aux = newNode(strdup(message));addBrother($1,aux);addBrother(aux,$4);if(debug)printf("MethodHeader1\n");}
                |       VOID ID LPAR FormalParams RPAR                      {$$ = newNode("MethodHeader"); $$->child = newNode("Void"); sprintf(message,"Id(%s)",$2); Node *aux = newNode(strdup(message));addBrother($$->child,aux);addBrother(aux,$4);if(debug)printf("MethodHeader2\n");}
                |       Type ID LPAR RPAR                                   {$$ = newNode("MethodHeader"); $$->child = $1; sprintf(message,"Id(%s)",$2); Node *aux = newNode(strdup(message)); addBrother($1,aux); addBrother(aux,newNode("MethodParams")); if(debug)printf("MethodHeader3\n");}
                |       VOID ID LPAR RPAR                                   {$$ = newNode("MethodHeader"); $$->child = newNode("Void"); sprintf(message,"Id(%s)",$2); Node *aux = newNode(strdup(message)); addBrother($$->child,aux); addBrother(aux,newNode("MethodParams")); if(debug)printf("MethodHeader4\n");}
                ;
                                                                            //$1 vai ser filho!!
FormalParams    :       Type ID Parametros                                  {$$ = newNode("MethodParams");  Node *Param = newNode("ParamDecl"); $$->child = Param;  Param->child = $1; sprintf(message,"Id(%s)",$2); Node *temp = newNode(strdup(message)); addBrother($1,temp); addBrother(Param,$3);if(debug)printf("FormalParams1\n");}
                |       Type ID                                             {$$ = newNode("MethodParams");  Node *Param = newNode("ParamDecl"); $$->child = Param;  Param->child = $1; sprintf(message,"Id(%s)",$2); Node *temp = newNode(strdup(message)); addBrother($1,temp);if(debug)printf("FormalParams2\n");}
                |       STRING LSQ RSQ ID                                   {$$ = newNode("MethodParams");  Node *Param = newNode("ParamDecl"); $$->child = Param; Node * String = newNode("StringArray"); Param->child = String; sprintf(message,"Id(%s)",$4);addBrother(String,newNode(strdup(message)));if(debug)printf("FormalParams3\n");}
                ;

Parametros      :       COMMA Type ID                                       {$$ = newNode("ParamDecl"); $$->child =$2; sprintf(message,"Id(%s)",$3); addBrother($2, newNode(strdup(message)));if(debug)printf("Parametros1\n");}
                |       COMMA Type ID Parametros                            {Node * Param = newNode("ParamDecl");$$ = Param; addBrother(Param,$4);Param->child = $2; sprintf(message,"Id(%s)",$3); addBrother($2,newNode(strdup(message)));if(debug)printf("Parametros2\n");}
                ;                                                           

MethodBody      :       LBRACE Expressao RBRACE                             {$$ = newNode("MethodBody"); $$->child = $2;if(debug)printf("MethodBody1\n");}
                |       LBRACE RBRACE                                       {$$ = newNode("MethodBody");if(debug)printf("MethodBody2\n");}
                ;

Expressao       :       Statement                                           {$$ = $1;if(debug)printf("Expressao1\n");}
                |       VarDecl                                             {$$ = $1;if(debug)printf("Expressao2\n");}
                |       Statement Expressao                                 {if($1) {$$=$1; addBrother($$,$2);} else{$$=$1;}if(debug)printf("Expressao3\n");}
                |       VarDecl Expressao                                   {if($1) {$$=$1; addBrother($$,$2);} else{$$=$1;}if(debug)printf("Expressao4\n");}
                ;
                                                                            
VarDecl         :       Type ID VariaveisVar SEMICOLON                      {$$ = newNode("VarDecl");$$->child = $1; sprintf(message,"Id(%s)",$2); Node *temp = newNode(strdup(message)); addBrother($1, temp); addBrother($$, $3);if(debug)printf("VarDecl1\n");}
                |       Type ID SEMICOLON                                   {$$ = newNode("VarDecl");$$->child = $1; sprintf(message,"Id(%s)",$2); addBrother($1, newNode(strdup(message)));if(debug)printf("VarDecl2\n");}
                ;

VariaveisVar    :       COMMA ID                                            {$$ = newNode("VarDecl"); Node * aux = newNode(strdup(lastType));$$->child = aux; sprintf(message,"Id(%s)",$2); addBrother(aux,newNode(strdup(message))); if(debug)printf("Variaveis1\n");}
                |       COMMA ID VariaveisVar                               {Node * Var = newNode("VarDecl"); $$ = Var; addBrother(Var,$3); sprintf(message,"Id(%s)",$2); Node * aux = newNode(strdup(lastType)); Var->child = aux; addBrother(aux,newNode(strdup(message))); if(debug)printf("Variaveis2\n");}
                ;

Statement       :       LBRACE recursaoS RBRACE                             {$$ = $2; if(debug)printf("Statement1\n");}
                |       LBRACE RBRACE                                       {if(debug)printf("Statement2\n");}
                |       IF LPAR Expr RPAR Statement  ELSE Statement         {$$ = newNode("If"); $$->child=$3; addBrother($3,$5);addBrother($5,newNode("Block"));  addBrother($5,$7);if(debug)printf("Statement3\n");}
                |       IF LPAR Expr RPAR Statement  %prec ELSE             {$$ = newNode("If"); $$->child=$3; addBrother($3,$5);addBrother($5,newNode("Block"));if(debug)printf("Statement4\n");}
                |       WHILE LPAR Expr RPAR Statement                      {$$ = newNode("While"); $$->child = $3; Node * block = newNode("Block"); addBrother($3, block); block->child = $5;  if(debug)printf("Statement5\n");}
                |       RETURN Expr SEMICOLON                               {$$ = newNode("Return"); $$->child = $2; if(debug)printf("Statement6\n");} // TODO: verificar se e $$ ou $1 e se e brother ou child
                |       RETURN SEMICOLON                                    {$$ = newNode("Return"); if(debug)printf("Statement7\n");}
                |       PRINT LPAR Expr RPAR SEMICOLON                      {$$ = newNode("Print"); $$->child = $3; if(debug)printf("Statement10\n");}
                |       PRINT LPAR STRLIT RPAR SEMICOLON                    {$$ = newNode("Print"); sprintf(message,"StrLit(%s)",$3); $$->child = newNode(strdup(message)); if(debug)printf("Statement11\n");} //BUG: 
                |       MethodInvocation SEMICOLON                          {$$ = $1;if(debug)printf("Statement8\n");}
                |       Assignment SEMICOLON                                {$$ = $1;if(debug)printf("Statement8\n");}
                |       ParseArgs SEMICOLON                                 {$$ = $1;if(debug)printf("Statement8\n");}
                |       SEMICOLON                                           { if(debug)printf("Statement9\n");}
                |       error SEMICOLON                                     {$$=newNode(NULL); erro = 1; if(debug) printf("StatementError\n");}
                ;

/* StatementOrError:       Statement                                           {$$=$1;if(debug) printf("Statement\n");}
                |       error SEMICOLON                                     {$$=newNode(NULL); mostraTree = 0; if(debug) printf("StatementError2\n");}
                ; */


recursaoS       :       Statement                                           {$$ = $1; if(debug)printf("recursaoS1\n");}
                |       Statement recursaoS                                  {$$ = $1; addBrother($1,$2);if(debug)printf("recursaoS2\n");}
                ; 
                                                                            
MethodInvocation:       ID LPAR Expr CommaExpr RPAR                         {$$ = newNode("Call");sprintf(message,"Id(%s)",$1); $$->child = newNode(strdup(message)); if($4!=NULL){addBrother($$->child,$3);} if(debug)printf("MethodInvocation1\n");}
                |       ID LPAR RPAR                                        {$$ = newNode("Call");sprintf(message,"Id(%s)",$1); $$->child = newNode(strdup(message));if(debug)printf("MethodInvocation2\n");}
                |       ID LPAR error RPAR                                  {$$ = newNode(NULL); erro = 1;if(debug)printf("MethodInvocationError\n");}
                ;

CommaExpr       :       COMMA Expr CommaExpr                                {$$ = $2; if($3!=NULL){addBrother($2,$3);} if(debug)printf("CommaExpr1\n");}
                |                                                           {if(debug)printf("CommaExpr2\n");}
                ;

Assignment      :       ID ASSIGN Expr                                      {$$ = newNode("Assign"); sprintf(message,"Id(%s)",$1);$$->child = newNode(strdup(message));addBrother($$->child,$3);if(debug)printf("Assignment1\n");}
                ;

ParseArgs       :       PARSEINT LPAR ID LSQ Expr RSQ RPAR                  {$$ = newNode("ParseArgs"); sprintf(message,"Id(%s)",$3);$$->child = newNode(strdup(message));addBrother($$->child,$5);if(debug)printf("ParseArgs1\n");}
                |       PARSEINT LPAR error RPAR                            {$$ = newNode(NULL); erro = 1;if(debug)printf("ParseArgsError\n");}    
                ;

Expr            :       Expr PLUS Expr                                      {$$ = newNode("Add"); $$->child=$1; addBrother($1,$3);if(debug)printf("Expr1\n");}
                |       Expr MINUS Expr                                     {$$ = newNode("Sub"); $$->child=$1; addBrother($1,$3);if(debug)printf("Expr2\n");}
                |       Expr STAR Expr                                      {$$ = newNode("Mul"); $$->child=$1; addBrother($1,$3);if(debug)printf("Expr3\n");}
                |       Expr DIV Expr                                       {$$ = newNode("Div"); $$->child=$1; addBrother($1,$3);if(debug)printf("Expr4\n");}
                |       Expr MOD Expr                                       {$$ = newNode("Mod"); $$->child=$1; addBrother($1,$3);if(debug)printf("Expr5\n");}
                |       Expr AND Expr                                       {$$ = newNode("And"); $$->child=$1; addBrother($1,$3);if(debug)printf("Expr6\n");}
                |       Expr OR Expr                                        {$$ = newNode("Or"); $$->child=$1; addBrother($1,$3);if(debug)printf("Expr7\n");}
                |       Expr XOR Expr                                       {$$ = newNode("Xor"); $$->child=$1; addBrother($1,$3);if(debug)printf("Expr8\n");}
                |       Expr LSHIFT Expr                                    {$$ = newNode("Lshift"); $$->child=$1; addBrother($1,$3);if(debug)printf("Expr9\n");}
                |       Expr RSHIFT Expr                                    {$$ = newNode("Rshift"); $$->child=$1; addBrother($1,$3);if(debug)printf("Expr10\n");}
                |       Expr EQ Expr                                        {$$ = newNode("Eq"); $$->child=$1; addBrother($1,$3);if(debug)printf("Expr11\n");}
                |       Expr GE Expr                                        {$$ = newNode("Ge"); $$->child=$1; addBrother($1,$3);if(debug)printf("Expr12\n");}
                |       Expr GT Expr                                        {$$ = newNode("Gt"); $$->child=$1; addBrother($1,$3);if(debug)printf("Expr13\n");}
                |       Expr LE Expr                                        {$$ = newNode("Le"); $$->child=$1; addBrother($1,$3);if(debug)printf("Expr14\n");}
                |       Expr LT Expr                                        {$$ = newNode("Lt"); $$->child=$1; addBrother($1,$3);if(debug)printf("Expr15\n");}
                |       Expr NE Expr                                        {$$ = newNode("Ne"); $$->child=$1; addBrother($1,$3);if(debug)printf("Expr16\n");}
                |       MINUS Expr                                          {$$ = newNode("Minus"); $$->child=$2;if(debug)printf("Expr17\n");}
                |       NOT Expr                                            {$$ = newNode("Not"); $$->child=$2;if(debug)printf("Expr18\n");}
                |       PLUS Expr                                           {$$ = newNode("Plus"); $$->child=$2;if(debug)printf("Expr19\n");}
                |       LPAR Expr RPAR                                      {$$ = $2;if(debug)printf("Expr20\n");}
                |       MethodInvocation                                    {$$ = $1;if(debug)printf("Expr21\n");}
                |       Assignment                                          {$$ = $1;if(debug)printf("Expr22\n");}
                |       ParseArgs                                           {$$ = $1;if(debug)printf("Expr23\n");}
                |       ID DOTLENGTH                                        {sprintf(message,"Id(%s)",$1); $$ = newNode(strdup(message)); addBrother($$,  newNode("Length"));if(debug)printf("Expr24\n");} // FIXME: aqui talvez nao seja brother e sim filho do $1
                |       ID                                                  {sprintf(message,"Id(%s)",$1);$$ = newNode(strdup(message));if(debug)printf("Expr25\n");}
                |       INTLIT                                              {sprintf(message, "DecLit(%s)", $1);$$ = newNode(strdup(message));if(debug)printf("Expr26\n");}
                |       REALLIT                                             {sprintf(message, "RealLit(%s)", $1);$$ = newNode(strdup(message));if(debug)printf("Expr27\n");}
                |       BOOLLIT                                             {sprintf(message, "BoolLit(%s)", $1);$$ = newNode(strdup(message));if(debug)printf("Expr28\n");}
                |       LPAR error RPAR                                     {$$ = newNode(NULL); erro = 1;if(debug)printf("ExprError\n");}
                ;

%%
