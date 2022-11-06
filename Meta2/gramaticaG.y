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
    char lastType[64];
    int debug = 1; //DEBUG: variavel apenas para debug!!!
    int erro = 0; 
    node * raiz;
%}

%union{
    char *id;
    struct node * no;
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

%nonassoc ELSE IF

%%
                                                                                                                                                                                                                                                                                      
Program         :       CLASS ID LBRACE Declarations RBRACE                 {$$ = newNode("Program"); raiz = $$;sprintf(message,"Id(%s)",$2); $$->child = newNode(strdup(message)); addBrother($$->child , $4);if(erro == 0){printSTree(raiz,0);}}
                ;

Declarations    :       MethodDecl Declarations                             {$$ = $1;addBrother($$,$2);}
                |       FieldDecl Declarations                              {$$ = $1;addBrother($$,$2);}
                |       SEMICOLON Declarations                              {$$ = $2;};                
                |                                                           {$$ = NULL;}
                ;

MethodDecl      :       PUBLIC STATIC MethodHeader MethodBody               {$$ = newNode("MethodDecl");$$->child = $3;addBrother($$->child,$4);}
                                                                            
FieldDecl       :       PUBLIC STATIC Type ID Variaveis SEMICOLON           {$$ = newNode("FieldDecl"); $$->child = $3; sprintf(message,"Id(%s)",$4);node * id = newNode(strdup(message)); addBrother($$->child,id); addBrother($$,$5);}
                |       error SEMICOLON                                     {$$ = NULL;erro = 1;}
                ;

Variaveis       :       COMMA ID Variaveis                                  {$$ = newNode("FieldDecl"); node * type = newNode(strdup(lastType));$$->child = type; sprintf(message,"Id(%s)",$2); node * id = newNode(strdup(message)); addBrother($$->child,id); addBrother($$,$3); }
                |                                                           {$$ = NULL;}
                ;

Type            :       BOOL                                                {$$ = newNode("Bool");memset(lastType,0,64);strcpy(lastType,"Bool");}
                |       INT                                                 {$$ = newNode("Int");memset(lastType,0,64);strcpy(lastType,"Int");}
                |       DOUBLE                                              {$$ = newNode("Double");memset(lastType,0,64);strcpy(lastType,"Double");}
                ;

MethodHeader    :       Type ID LPAR FormalParams RPAR                      {$$ = newNode("MethodHeader"); $$->child = $1;sprintf(message,"Id(%s)",$2); node * id = newNode(strdup(message));addBrother($$->child,id);addBrother(id,$4);}
                |       VOID ID LPAR FormalParams RPAR                      {$$ = newNode("MethodHeader");$$->child = newNode("Void");sprintf(message,"Id(%s)",$2); node * id = newNode(strdup(message));addBrother($$->child,id);addBrother(id,$4);}
                |       Type ID LPAR RPAR                                   {$$ = newNode("MethodHeader");$$->child = $1;sprintf(message,"Id(%s)",$2); node * id = newNode(strdup(message));addBrother($$->child,id); addBrother(id,newNode("MethodParams"));}
                |       VOID ID LPAR RPAR                                   {$$ = newNode("MethodHeader");$$->child = newNode("Void");sprintf(message,"Id(%s)",$2); node * id = newNode(strdup(message));addBrother($$->child,id); addBrother(id,newNode("MethodParams"));}
                ;
                                                                            
FormalParams    :       Type ID Parametros                                  {$$ = newNode("MethodParams");node * param = newNode("ParamDecl"); param->child = $1; sprintf(message,"Id(%s)",$2); node * id = newNode(strdup(message)); addBrother(param->child,id); $$->child = param;addBrother($$->child,$3);}
                |       STRING LSQ RSQ ID                                   {$$ = newNode("MethodParams");node * param = newNode("ParamDecl"); node * array = newNode("StringArray"); param->child = array;sprintf(message,"Id(%s)",$4); node * id = newNode(strdup(message)); addBrother(param->child,id);$$->child = param;}
                ;

Parametros      :       COMMA Type ID Parametros                            {$$ = newNode("ParamDecl");$$->child = $2;sprintf(message,"Id(%s)",$3); node * id = newNode(strdup(message));addBrother($$->child,id);addBrother($$,$4);}
                |                                                           {$$ = NULL;}
                ;                                                           

MethodBody      :       LBRACE Expressao RBRACE                             {$$ = newNode("MethodBody");}
                ;

Expressao       :       Statement Expressao                                 {;}
                |       VarDecl Expressao                                   {;}
                |                                                           {$$ = NULL;}
                ;
                                                                            
VarDecl         :       Type ID VariaveisVar SEMICOLON                      {;}
                ;

VariaveisVar    :                                                           {;}
                |       COMMA ID VariaveisVar                               {;}
                ;

Statement       :       LBRACE recursaoS RBRACE                             {;}
                |       IF LPAR Expr RPAR Statement  ELSE Statement         {;}
                |       IF LPAR Expr RPAR Statement                         {;}
                |       WHILE LPAR Expr RPAR Statement                      {;}
                |       RETURN Expr SEMICOLON                               {;} 
                |       RETURN SEMICOLON                                    {;}
                |       PRINT LPAR Expr RPAR SEMICOLON                      {;}
                |       PRINT LPAR STRLIT RPAR SEMICOLON                    {;}  
                |       MethodInvocation SEMICOLON                          {;}
                |       Assignment SEMICOLON                                {;}
                |       ParseArgs SEMICOLON                                 {;}
                |       SEMICOLON                                           {;}
                |       error SEMICOLON                                     {erro = 1;}
                ;

recursaoS       :       Statement recursaoS                                 {;}
                |                                                           {;}
                ; 
                                                                            
MethodInvocation:       ID LPAR Expr CommaExpr RPAR                         {;}
                |       ID LPAR Expr RPAR                                   {;}
                |       ID LPAR RPAR                                        {;}
                |       ID LPAR error RPAR                                  {erro = 1;}
                ;

CommaExpr       :       COMMA Expr                                          {;}
                |       CommaExpr COMMA Expr                                {;}
                ;

Assignment      :       ID ASSIGN Expr                                      {;}
                ;

ParseArgs       :       PARSEINT LPAR ID LSQ Expr RSQ RPAR                  {;}
                |       PARSEINT LPAR error RPAR                            {erro = 1;}    
                ;

Expr            :       Expr PLUS Expr                                      {;}
                |       Expr MINUS Expr                                     {;}
                |       Expr STAR Expr                                      {;}
                |       Expr DIV Expr                                       {;}
                |       Expr MOD Expr                                       {;}
                |       Expr AND Expr                                       {;}
                |       Expr OR Expr                                        {;}
                |       Expr XOR Expr                                       {;}
                |       Expr LSHIFT Expr                                    {;}
                |       Expr RSHIFT Expr                                    {;}
                |       Expr EQ Expr                                        {;}
                |       Expr GE Expr                                        {;}
                |       Expr GT Expr                                        {;}
                |       Expr LE Expr                                        {;}
                |       Expr LT Expr                                        {;}
                |       Expr NE Expr                                        {;}
                |       MINUS Expr                                          {;}
                |       NOT Expr                                            {;}
                |       PLUS Expr                                           {;}
                |       LPAR Expr RPAR                                      {;}
                |       MethodInvocation                                    {;}
                |       Assignment                                          {;}
                |       ParseArgs                                           {;}
                |       ID DOTLENGTH                                        {;} 
                |       ID                                                  {;}
                |       INTLIT                                              {;}
                |       REALLIT                                             {;}
                |       BOOLLIT                                             {;}
                |       LPAR error RPAR                                     {erro = 1;}
                ;

%%
