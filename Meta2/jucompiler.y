%{
    /* ===================================================================================
	    Compiladores -  Eduardo Figueiredo 2020213717
                        Fábio Santos       2020212310
    ====================================================================================== */
    #include <stdio.h>
    #include "STree.h"
    
    int yylex(void);
    void yyerror (const char *s);
    extern int mostraTree;
    char message[256];
    char lastType[32];
    int debug = 1; //DEBUG: variavel apenas para debug!!!
    int erro = 0; 
%}

%union{
    char *id;
    struct node *no;
}

%token STRING AND ASSIGN STAR COMMA DIV EQ GE GT LBRACE LE LPAR LSQ LT MINUS MOD NE NOT OR PLUS RBRACE RPAR RSQ SEMICOLON LSHIFT RSHIFT XOR BOOL CLASS DOUBLE ELSE IF INT PRINT PARSEINT PUBLIC RETURN STATIC VOID WHILE

%token <id> ID
%token <id> STRLIT
%token <id> REALLIT
%token <id> INTLIT
%token <id> BOOLLIT
%token <id> DOTLENGTH 

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
%type <no> ExprOrAssign

%nonassoc ELSE IF

%%
                                                                                                                                                                                                                                                                                      
Program         :       CLASS ID LBRACE Declarations RBRACE                 {$$ = newNode("Program"); sprintf(message,"Id(%s)",$2); $$->child = newNode(strdup(message)); addBrother($$->child, $4);if(mostraTree && erro == 0){printSTree($$,0);}  else {freeSTree($$);} if(debug){printf("Program1\n");} }
                ;

Declarations    :       MethodDecl Declarations                             {$$ = $1; addBrother($$, $2);if(debug)printf("Declarations4\n");}
                |       FieldDecl Declarations                              {$$ = $1; addBrother($$, $2);if(debug)printf("Declarations5\n");}
                |       SEMICOLON Declarations                              {if($2){$$ = $2;}else{$$ = NULL;}if(debug)printf("Declarations6\n");}                ;
                |                                                           {$$ = NULL;}
                ;

MethodDecl      :       PUBLIC STATIC MethodHeader MethodBody               {$$ = newNode("MethodDecl"); $$->child = $3; addBrother($3,$4);if(debug)printf("MethodDecl1\n");}
                                                                            
FieldDecl       :       PUBLIC STATIC Type ID Variaveis SEMICOLON           {$$ = newNode("FieldDecl"); $$->child = $3; sprintf(message,"Id(%s)",$4); node *temp = newNode(strdup(message)); addBrother($3,temp); addBrother($$,$5);if(debug)printf("FieldDecl2\n");}
                |       error SEMICOLON                                     {$$ = newNode(NULL); erro=1;if(debug)printf("FieldDeclerror\n");}
                ;

Variaveis       :       COMMA ID Variaveis                                  {node * Var = newNode("FieldDecl"); $$ = Var; sprintf(message,"Id(%s)",$2); addBrother(Var,$3); node * aux = newNode(strdup(lastType)); Var->child = aux; addBrother(aux,newNode(strdup(message))); if(debug)printf("Variaveis1\n");}
                |                                                           {if(debug)printf("Variaveis2\n");}
                ;

Type            :       BOOL                                                {$$ = newNode("Bool"); memset(lastType, 0, 32); strcpy(lastType, "Bool"); if(debug)printf("Type1\n");}
                |       INT                                                 {$$ = newNode("Int"); memset(lastType, 0, 32); strcpy(lastType, "Int"); if(debug)printf("Type2\n");}
                |       DOUBLE                                              {$$ = newNode("Double"); memset(lastType, 0, 32); strcpy(lastType, "Double"); if(debug)printf("Type3\n");}
                ;

MethodHeader    :       Type ID LPAR FormalParams RPAR                      {$$ = newNode("MethodHeader"); $$->child = $1; sprintf(message,"Id(%s)",$2); node *aux = newNode(strdup(message));addBrother($1,aux);addBrother(aux,$4);if(debug)printf("MethodHeader1\n");}
                |       VOID ID LPAR FormalParams RPAR                      {$$ = newNode("MethodHeader"); $$->child = newNode("Void"); sprintf(message,"Id(%s)",$2); node *aux = newNode(strdup(message));addBrother($$->child,aux);addBrother(aux,$4);if(debug)printf("MethodHeader2\n");}
                |       Type ID LPAR RPAR                                   {$$ = newNode("MethodHeader"); $$->child = $1; sprintf(message,"Id(%s)",$2); node *aux = newNode(strdup(message)); addBrother($1,aux); addBrother(aux,newNode("MethodParams")); if(debug)printf("MethodHeader3\n");}
                |       VOID ID LPAR RPAR                                   {$$ = newNode("MethodHeader"); $$->child = newNode("Void"); sprintf(message,"Id(%s)",$2); node *aux = newNode(strdup(message)); addBrother($$->child,aux); addBrother(aux,newNode("MethodParams")); if(debug)printf("MethodHeader4\n");}
                ;
                                                                            
FormalParams    :       Type ID Parametros                                  {$$ = newNode("MethodParams");  node *Param = newNode("ParamDecl"); $$->child = Param;  Param->child = $1; sprintf(message,"Id(%s)",$2); node *temp = newNode(strdup(message)); addBrother($1,temp); addBrother(Param,$3);if(debug)printf("FormalParams1\n");}
                |       STRING LSQ RSQ ID                                   {$$ = newNode("MethodParams");  node *Param = newNode("ParamDecl"); $$->child = Param; node * String = newNode("StringArray"); Param->child = String; sprintf(message,"Id(%s)",$4);addBrother(String,newNode(strdup(message)));if(debug)printf("FormalParams3\n");}
                ;

Parametros      :       COMMA Type ID Parametros                            {node * Param = newNode("ParamDecl");$$ = Param;Param->child = $2; sprintf(message,"Id(%s)",$3); addBrother($2,newNode(strdup(message))); addBrother(Param,$4);  if(debug)printf("Parametros2\n");}
                |                                                           {$$ = NULL;}
                ;                                                           

MethodBody      :       LBRACE Expressao RBRACE                             {$$ = newNode("MethodBody"); $$->child = $2;if(debug)printf("MethodBody1\n");}
                ;

Expressao       :       Statement Expressao                                 {$$=$1; addBrother($$,$2);if(debug)printf("Expressao3\n");}
                |       VarDecl Expressao                                   {$$=$1; addBrother($$,$2);if(debug)printf("Expressao4\n");}
                |                                                           {$$ = NULL;}
                ;
                                                                            
VarDecl         :       Type ID VariaveisVar SEMICOLON                      {node * Var = newNode("VarDecl");  $$ = Var;Var->child = $1; sprintf(message,"Id(%s)",$2); node *temp = newNode(strdup(message)); addBrother($1, temp); addBrother(Var, $3);if(debug)printf("VarDecl1\n");}
                ;

VariaveisVar    :                                                           {$$ = NULL; if(debug)printf("Variaveis1\n");}
                |       COMMA ID VariaveisVar                               {node * Var = newNode("VarDecl");  $$ = Var; sprintf(message,"Id(%s)",$2); node * aux = newNode(strdup(lastType)); Var->child = aux; addBrother(aux,newNode(strdup(message)));addBrother(Var,$3); if(debug)printf("Variaveis2\n");}
                ;

Statement       :       LBRACE recursaoS RBRACE                             {$$ = $2;  if(debug)printf("Statement1\n");}
                |       IF ExprOrAssign Statement ELSE Statement            {$$ = newNode("If"); $$->child=$2; addBrother($2,$3);node * block = newNode("Block"); addBrother($3,block ); addBrother(block ,$5);if(debug)printf("Statement3\n");}
                |       IF ExprOrAssign Statement                           {$$ = newNode("If"); $$->child=$2; addBrother($2,$3);addBrother($3,newNode("Block"));if(debug)printf("Statement4\n");}
                |       WHILE ExprOrAssign Statement                        {$$ = newNode("While"); $$->child = $2; node * block = newNode("Block"); addBrother($2, block); block->child = $3;  if(debug)printf("Statement5\n");}
                |       RETURN Expr SEMICOLON                               {$$ = newNode("Return"); $$->child = $2; if(debug)printf("Statement6\n");} // TODO: verificar se e $$ ou $1 e se e brother ou child
                |       RETURN SEMICOLON                                    {$$ = newNode("Return"); if(debug)printf("Statement7\n");}
                |       PRINT ExprOrAssign SEMICOLON                        {$$ = newNode("Print"); $$->child = $2; if(debug)printf("Statement10\n");}
                |       PRINT LPAR STRLIT RPAR SEMICOLON                    {$$ = newNode("Print"); sprintf(message,"StrLit(%s)",$3); $$->child = newNode(strdup(message)); if(debug)printf("Statement11\n");} //BUG: 
                |       MethodInvocation SEMICOLON                          {$$ = $1;if(debug)printf("Statement8\n");}
                |       Assignment SEMICOLON                                {$$ = $1;if(debug)printf("Statement8\n");}
                |       ParseArgs SEMICOLON                                 {$$ = $1;if(debug)printf("Statement8\n");}
                |       SEMICOLON                                           {$$ = NULL; if(debug)printf("Statement9\n");}
                |       error SEMICOLON                                     {$$ = newNode(NULL); erro = 1; if(debug) printf("StatementError\n");}
                ;

recursaoS       :       Statement recursaoS                                 {$$ = $1; addBrother($1,$2);if(debug)printf("recursaoS2\n");}
                |                                                           {$$ = NULL;}
                ; 
                                                                            
MethodInvocation:       ID LPAR Expr CommaExpr RPAR                         {$$ = newNode("Call");sprintf(message,"Id(%s)",$1); $$->child = newNode(strdup(message)); addBrother($$->child,$3);addBrother($3,$4);if(debug)printf("MethodInvocation1\n");}
                |       ID LPAR Expr RPAR                                   {$$ = newNode("Call");sprintf(message,"Id(%s)",$1); $$->child = newNode(strdup(message)); addBrother($$->child,$3);if(debug)printf("MethodInvocation1\n");}
                |       ID LPAR RPAR                                        {$$ = newNode("Call");sprintf(message,"Id(%s)",$1); $$->child = newNode(strdup(message));if(debug)printf("MethodInvocation2\n");}
                |       ID LPAR error RPAR                                  {$$ = newNode(NULL); erro = 1;if(debug)printf("MethodInvocationError\n");}
                ;

CommaExpr       :       COMMA Expr                                          {$$ = $2;if(debug)printf("CommaExpr1\n");}
                |       CommaExpr COMMA Expr                                {$$ = $1;addBrother($1,$3);if(debug)printf("CommaExpr2\n");}
                ;

Assignment      :       ID ASSIGN Expr                                      {$$ = newNode("Assign"); sprintf(message,"Id(%s)",$1);$$->child = newNode(strdup(message));addBrother($$->child,$3);if(debug)printf("Assignment1\n");}
                ;

ParseArgs       :       PARSEINT LPAR ID LSQ Expr RSQ RPAR                  {$$ = newNode("ParseArgs"); sprintf(message,"Id(%s)",$3);$$->child = newNode(strdup(message)); addBrother($$->child,$5);if(debug)printf("ParseArgs1\n");}
                |       PARSEINT LPAR error RPAR                            {$$ = newNode(NULL); erro = 1;if(debug)printf("ParseArgsError\n");}    
                ;

ExprOrAssign    :       LPAR Expr RPAR                                      {$$ = $2;}
                |       Assignment                                          {$$ = $1;}
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
                |       ParseArgs                                           {$$ = $1;if(debug)printf("Expr23\n");}
                |       ID DOTLENGTH                                        {sprintf(message,"Id(%s)",$1); $$ = newNode(strdup(message)); addBrother($$,  newNode("Length"));if(debug)printf("Expr24\n");} // FIXME: aqui talvez nao seja brother e sim filho do $1
                |       ID                                                  {sprintf(message,"Id(%s)",$1);$$ = newNode(strdup(message));if(debug)printf("Expr25\n");}
                |       INTLIT                                              {sprintf(message, "DecLit(%s)", $1);$$ = newNode(strdup(message));if(debug)printf("Expr26\n");}
                |       REALLIT                                             {sprintf(message, "RealLit(%s)", $1);$$ = newNode(strdup(message));if(debug)printf("Expr27\n");}
                |       BOOLLIT                                             {sprintf(message, "BoolLit(%s)", $1);$$ = newNode(strdup(message));if(debug)printf("Expr28\n");}
                |       LPAR error RPAR                                     {$$ = newNode(NULL); erro = 1;if(debug)printf("ExprError\n");}
                ;

%%
