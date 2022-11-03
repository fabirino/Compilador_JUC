%{
    /* ===================================================================================
	    Compiladores -  Eduardo Figueiredo 2020213717
                        Fabio Santos       2020212310
    ====================================================================================== */
    #include <stdio.h>
    #include "tree.h"
    
    int yylex(void);
    void yyerror (const char *s);
    int erroSintatico = 0;
    extern int mostraTree;
    char message[256];
    int debug = 1; //DEBUG: variavel apenas para debug!!!
%}

%union{
    char *id;
    struct node *node;
}

%token AND ASSIGN STAR COMMA DIV EQ GE GT LBRACE LE LPAR LSQ LT MINUS MOD NE NOT OR PLUS RBRACE RPAR RSQ SEMICOLON LSHIFT RSHIFT XOR BOOL CLASS DOUBLE ELSE IF INT PRINT PARSEINT PUBLIC RETURN STATIC VOID WHILE

%token <id> ID
%token <id> STRLIT
%token <id> REALLIT
%token <id> INTLIT
%token <id> BOOLLIT
%token <id> DOTLENGTH
%token <id> STRING

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

%nonassoc ELSE
%nonassoc IF

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
%type <node> Statement
%type <node> Gramatica
%type <node> MethodInvocation
%type <node> CommaExpr
%type <node> Assignment
%type <node> ParseArgs
%type <node> Expr

%%
// O IF esta nos 'token' mas vai ser um no, mas nao pertence ao lado esquerdo da gramatica
//QUESTION: Vai ser token ou token <node> ??

Program         :       CLASS ID LBRACE Declarations RBRACE                 {$$ = newNode("Program"); sprintf(message,"Id(%s)",$2); $$->child = newNode(strdup(message));  addBrother($$->child, $4);if(debug){printf("Program1\n Valor do mostraTree: %d\n\n\n", mostraTree);} if(mostraTree ){printTree($$,0);} else {freeTree($$);}}
                |       CLASS ID LBRACE RBRACE                              {$$ = newNode("Program"); sprintf(message,"Id(%s)",$2); $$->child = newNode(strdup(message)); if(mostraTree && erroSintatico){printTree($$,0);} else {freeTree($$);}if(debug)printf("Program2\n");}
                ;

Declarations    :       MethodDecl                                          {$$ = $1;if(debug)printf("Declarations1\n");}
                |       FieldDecl                                           {$$ = $1;if(debug)printf("Declarations2\n");}
                |       SEMICOLON                                           {if(debug)printf("Declarations3\n");}
                |       Declarations MethodDecl                             {$$ = $1; addBrother($$, $2);if(debug)printf("Declarations4\n");}
                |       Declarations FieldDecl                              {$$ = $1; addBrother($$, $2);if(debug)printf("Declarations5\n");}
                |       Declarations SEMICOLON                              {$$ = $1;if(debug)printf("Declarations6\n");}
                ;

MethodDecl      :       PUBLIC STATIC MethodHeader MethodBody               {$$ = newNode("MethodDecl"); $$->child = $3; addBrother($3,$4);if(debug)printf("MethodDecl1\n");}

FieldDecl       :       PUBLIC STATIC Type ID SEMICOLON                     {$$ = newNode("FieldDecl"); sprintf(message,"Id(%s)",$4); $$->child = $3; addBrother($3, newNode(strdup(message)));if(debug)printf("FieldDecl1\n");}
                |       PUBLIC STATIC Type ID Variaveis SEMICOLON           {$$ = newNode("FieldDecl"); sprintf(message,"Id(%s)",$4); $$->child = $3; Node *temp = newNode(strdup(message)); addBrother($3,temp); addBrother(temp,$5);if(debug)printf("FieldDecl2\n");}
                |       error SEMICOLON                                     {$$ = newNode(NULL); erroSintatico=1;if(debug)printf("FieldDeclerror\n");}
                ;

Variaveis       :       COMMA ID                                            {sprintf(message,"Id(%s)",$2); $$ = newNode(strdup(message)); if(debug)printf("Variaveis1\n");}
                |       Variaveis COMMA ID                                  {$$ = $1; sprintf(message,"Id(%s)",$3); addBrother($1,newNode(strdup(message))); if(debug)printf("Variaveis2\n");}
                ;

Type            :       BOOL                                                {$$ = newNode("Bool");if(debug)printf("Type1\n");}
                |       INT                                                 {$$ = newNode("Int");if(debug)printf("Type2\n");}
                |       DOUBLE                                              {$$ = newNode("Double");if(debug)printf("Type3\n");}
                ;

MethodHeader    :       Type ID LPAR FormalParams RPAR                      {$$ = newNode("MethodHeader");  sprintf(message,"Id(%s)",$2); $$->child = newNode(strdup(message));if(debug)printf("MethodHeader1\n");}
                |       VOID ID LPAR FormalParams RPAR                      {$$ = newNode("MethodHeader");  sprintf(message,"Id(%s)",$2); $$->child = newNode(strdup(message));if(debug)printf("MethodHeader2\n");}
                |       Type ID LPAR RPAR                                   {$$ = newNode("MethodHeader"); $$->child = $1;if(debug)printf("MethodHeader3\n");}
                |       VOID ID LPAR RPAR                                   {$$ = newNode("MethodHeader");if(debug)printf("MethodHeader4\n");}
                ;

FormalParams    :       Type ID Parametros                                  {$$ = $1; sprintf(message,"Id(%s)",$2); Node *temp = newNode(strdup(message)); addBrother($1,temp); addBrother(temp,$3);if(debug)printf("FormalParams1\n");}
                |       Type ID                                             {$$ = $1; sprintf(message,"Id(%s)",$2); Node *temp = newNode(strdup(message)); addBrother($1,temp);if(debug)printf("FormalParams2\n");}
                |       STRING LSQ RSQ ID                                   {$$ = newNode("StringArray"); sprintf(message,"Id(%s)",$4);addBrother($$,newNode(strdup(message)));if(debug)printf("FormalParams3\n");}
                ;

Parametros      :       COMMA Type ID                                       {$$ = $2; sprintf(message,"Id(%s)",$3); addBrother($2, newNode(strdup(message)));if(debug)printf("Parametros1\n");}
                |       Parametros COMMA Type ID                            {$$ = $1; addBrother($1,$3); sprintf(message,"Id(%s)",$4); addBrother($3,newNode(strdup(message)));if(debug)printf("Parametros2\n");}
                ;                                                           //TODO: ver esta mrd melhor !!

MethodBody      :       LBRACE Expressao RBRACE                             {$$ = newNode("MethodBody"); $$->child = $2;if(debug)printf("MethodBody1\n");}
                |       LBRACE RBRACE                                       {$$ = newNode("MethodBody");if(debug)printf("MethodBody2\n");}
                ;

Expressao       :       Statement                                           {$$ = $1;if(debug)printf("Expressao1\n");}
                |       VarDecl                                             {$$ = $1;if(debug)printf("Expressao2\n");}
                |       Expressao Statement                                 {$$ = $1; addBrother($1,$2);if(debug)printf("Expressao3\n");}
                |       Expressao VarDecl                                   {$$ = $1; addBrother($1,$2);if(debug)printf("Expressao4\n");}
                ;

VarDecl         :       Type ID Variaveis SEMICOLON                         {$$ = $1; sprintf(message,"Id(%s)",$2); Node *temp = newNode(strdup(message)); addBrother($1, temp); addBrother(temp, $3);if(debug)printf("VarDecl1\n");}
                |       Type ID SEMICOLON                                   {$$ = $1; sprintf(message,"Id(%s)",$2); addBrother($1, newNode(strdup(message)));if(debug)printf("VarDecl2\n");}
                ;

Statement       :       LBRACE Statement RBRACE                             {$$ = $2;if(debug)printf("Statement1\n");}
                |       LBRACE RBRACE                                       {;if(debug)printf("Statement2\n");}
                |       IF LPAR Expr RPAR Statement ELSE Statement          {$$ = newNode("If"); $$->child=$3; addBrother($3,$5);addBrother($5,newNode("Block"));  addBrother($5,$7);if(debug)printf("Statement3\n");}
                |       IF LPAR Expr RPAR Statement                         {$$ = newNode("If"); $$->child=$3; addBrother($3,$5);addBrother($5,newNode("Block"));if(debug)printf("Statement4\n");}
                |       WHILE LPAR Expr RPAR Statement                      {$$ = $3; addBrother($3, $5);if(debug)printf("Statement5\n");}
                |       RETURN Expr SEMICOLON                               {$$ = newNode("Return"); $$->child = $2;if(debug)printf("Statement6\n");} // TODO: verificar se e $$ ou $1 e se e brother ou child
                |       RETURN SEMICOLON                                    {$$ = newNode("Return"); $$->child = NULL;if(debug)printf("Statement7\n");}
                |       Gramatica SEMICOLON                                 {$$ = $1;if(debug)printf("Statement8\n");}
                |       SEMICOLON                                           {;if(debug)printf("Statement9\n");}
                |       PRINT LPAR Expr RPAR SEMICOLON                      {$$ = newNode("Print"); $$->child = $3;if(debug)printf("Statement10\n");}
                |       PRINT LPAR STRLIT RPAR SEMICOLON                    {$$ = newNode("Print"); sprintf(message,"StrLit(%s)",$3); $$->child = newNode(strdup(message));if(debug)printf("Statement11\n");}
                |       error SEMICOLON                                     {$$ = newNode(NULL); erroSintatico=1;if(debug)printf("StatementError\n");}
                ;

Gramatica       :       MethodInvocation                                    {$$ = $1;if(debug)printf("Gramatica1\n");}
                |       Assignment                                          {$$ = $1;if(debug)printf("Gramatica2\n");}
                |       ParseArgs                                           {$$ = $1;if(debug)printf("Gramatica3\n");}
                ;
                                                                            
MethodInvocation:       ID LPAR CommaExpr RPAR                              {$$ = newNode("Call");sprintf(message,"Id(%s)",$1); $$->child = newNode(strdup(message)); addBrother($$->child,$3);if(debug)printf("MethodInvocation1\n");}
                |       ID LPAR RPAR                                        {$$ = newNode("Call");sprintf(message,"Id(%s)",$1); $$->child = newNode(strdup(message));if(debug)printf("MethodInvocation2\n");}
                |       ID LPAR error RPAR                                  {$$ = newNode(NULL); erroSintatico=1;if(debug)printf("MethodInvocationError\n");}
                ;

CommaExpr       :       Expr                                                {$$ = $1;if(debug)printf("CommaExpr1\n");}
                |       CommaExpr COMMA Expr                                {$$ = $1;addBrother($1,$3);if(debug)printf("CommaExpr2\n");}
                ;

Assignment      :       ID ASSIGN Expr                                      {sprintf(message,"Id(%s)",$1);$$ = newNode(strdup(message));addBrother($$,$3);if(debug)printf("Assignment1\n");}
                ;

ParseArgs       :       PARSEINT LPAR ID LSQ Expr RSQ RPAR                  {sprintf(message,"Id(%s)",$3);$$ = newNode(strdup(message));addBrother($$,$5);if(debug)printf("ParseArgs1\n");}
                |       PARSEINT LPAR error RPAR                            {$$ = newNode(NULL); erroSintatico=1;if(debug)printf("ParseArgsError\n");}    
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
                |       LPAR error RPAR                                     {$$ = newNode(NULL); erroSintatico=1;if(debug)printf("ExprError\n");}
                ;

%%
