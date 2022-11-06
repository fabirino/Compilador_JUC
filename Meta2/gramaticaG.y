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
    char printatudo[1024];
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

MethodBody      :       LBRACE Expressao RBRACE                             {$$ = newNode("MethodBody");$$->child = $2;}
                ;

Expressao       :       Statement Expressao                                 {$$ = $1;}//addBrother($$,$2);TODO:!!!
                |       VarDecl Expressao                                   {$$ = $1;addBrother($$,$2);}
                |                                                           {$$ = NULL;}
                ;
                                                                            
VarDecl         :       Type ID VariaveisVar SEMICOLON                      {$$ = newNode("VarDecl"); $$->child = $1;sprintf(message,"Id(%s)",$2); node * id = newNode(strdup(message)); addBrother($$->child,id);addBrother($$,$3);}
                ;

VariaveisVar    :       COMMA ID VariaveisVar                               {$$ = newNode("VarDecl"); node * type = newNode(strdup(lastType)); $$->child = type; sprintf(message,"Id(%s)",$2); node * id = newNode(strdup(message)); addBrother($$->child,id); addBrother($$,$3);}
                |                                                           {$$ = NULL;}
                ;

Statement       :       LBRACE recursaoS RBRACE                             {$$ = $2;}
                |       IF LPAR Expr RPAR Statement  ELSE Statement         {$$ = newNode("If"); $$->child=$3; addBrother($$->child,$5);}
                |       IF LPAR Expr RPAR Statement                         {$$ = newNode("If"); $$->child=$3; addBrother($$->child,$5); addBrother($5,newNode("Block"));}
                |       WHILE LPAR Expr RPAR Statement                      {$$ = newNode("While");}
                |       RETURN Expr SEMICOLON                               {$$ = newNode("Return");$$->child = $2;} 
                |       RETURN SEMICOLON                                    {$$ = newNode("Return");}
                |       PRINT LPAR Expr RPAR SEMICOLON                      {$$ = newNode("Print"); $$->child = $3;}
                |       PRINT LPAR STRLIT RPAR SEMICOLON                    {$$ = newNode("Print"); sprintf(printatudo,"StrLit(\"%s)",$3); $$->child = newNode(strdup(printatudo)); }  
                |       MethodInvocation SEMICOLON                          {$$ = newNode("MethodInvocation");}//DEBUG:!!
                |       Assignment SEMICOLON                                {$$ = $1;}
                |       ParseArgs SEMICOLON                                 {$$ = $1;}
                |       SEMICOLON                                           {$$ = NULL;}
                |       error SEMICOLON                                     {$$ = NULL;erro = 1;}
                ;

recursaoS       :       Statement recursaoS                                 {$$ = $1;}//addBrother($$,$2);
                |                                                           {$$ = NULL;}
                ;
                                                                            
MethodInvocation:       ID LPAR Expr CommaExpr RPAR                         {;}
                |       ID LPAR Expr RPAR                                   {;}
                |       ID LPAR RPAR                                        {;}
                |       ID LPAR error RPAR                                  {$$ = NULL;erro = 1;}
                ;

CommaExpr       :       COMMA Expr                                          {;}
                |       CommaExpr COMMA Expr                                {;}
                ;

Assignment      :       ID ASSIGN Expr                                      {$$ = newNode("Assign"); sprintf(message,"Id(%s)",$1); node * id = newNode(strdup(message)); $$->child = id;addBrother($$->child,$3);}
                ;

ParseArgs       :       PARSEINT LPAR ID LSQ Expr RSQ RPAR                  {$$ = newNode("ParseArgs"); sprintf(message,"Id(%s)",$3); node * id = newNode(strdup(message)); $$->child = id; addBrother($$->child,$5);}
                |       PARSEINT LPAR error RPAR                            {$$ = NULL;erro = 1;}
                ;

Expr            :       Expr PLUS Expr                                      {$$ = newNode("Add"); $$->child=$1; addBrother($1,$3);}
                |       Expr MINUS Expr                                     {$$ = newNode("Sub"); $$->child=$1; addBrother($1,$3);}
                |       Expr STAR Expr                                      {$$ = newNode("Mul"); $$->child=$1; addBrother($1,$3);}
                |       Expr DIV Expr                                       {$$ = newNode("Div"); $$->child=$1; addBrother($1,$3);}
                |       Expr MOD Expr                                       {$$ = newNode("Mod"); $$->child=$1; addBrother($1,$3);}
                |       Expr AND Expr                                       {$$ = newNode("And"); $$->child=$1; addBrother($1,$3);}
                |       Expr OR Expr                                        {$$ = newNode("Or"); $$->child=$1; addBrother($1,$3);}
                |       Expr XOR Expr                                       {$$ = newNode("Xor"); $$->child=$1; addBrother($1,$3);}
                |       Expr LSHIFT Expr                                    {$$ = newNode("Lshift"); $$->child=$1; addBrother($1,$3);}
                |       Expr RSHIFT Expr                                    {$$ = newNode("Rshift"); $$->child=$1; addBrother($1,$3);}
                |       Expr EQ Expr                                        {$$ = newNode("Eq"); $$->child=$1; addBrother($1,$3);}
                |       Expr GE Expr                                        {$$ = newNode("Ge"); $$->child=$1; addBrother($1,$3);}
                |       Expr GT Expr                                        {$$ = newNode("Gt"); $$->child=$1; addBrother($1,$3);}
                |       Expr LE Expr                                        {$$ = newNode("Le"); $$->child=$1; addBrother($1,$3);}
                |       Expr LT Expr                                        {$$ = newNode("Lt"); $$->child=$1; addBrother($1,$3);}
                |       Expr NE Expr                                        {$$ = newNode("Ne"); $$->child=$1; addBrother($1,$3);}
                |       MINUS Expr                                          {$$ = newNode("Minus"); $$->child=$2;}
                |       NOT Expr                                            {$$ = newNode("Not"); $$->child=$2;}
                |       PLUS Expr                                           {$$ = newNode("Plus");}
                |       LPAR Expr RPAR                                      {$$ = $2;}
                |       MethodInvocation                                    {$$ = NULL;}//$$ = $1;TODO:
                |       Assignment                                          {$$ = $1;}
                |       ParseArgs                                           {$$ = $1;}
                |       ID DOTLENGTH                                        {sprintf(message,"Id(%s)",$1); $$ = newNode(strdup(message)); addBrother($$, newNode("Length"));} 
                |       ID                                                  {sprintf(message,"Id(%s)",$1);$$ = newNode(strdup(message));}
                |       INTLIT                                              {sprintf(message, "DecLit(%s)", $1);$$ = newNode(strdup(message));}
                |       REALLIT                                             {sprintf(message, "RealLit(%s)", $1);$$ = newNode(strdup(message));}
                |       BOOLLIT                                             {sprintf(message, "BoolLit(%s)", $1);$$ = newNode(strdup(message));}
                |       LPAR error RPAR                                     {$$ = NULL;erro = 1;}
                ;

%%
