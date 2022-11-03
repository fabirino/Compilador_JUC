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

Program         :       CLASS ID LBRACE Declarations RBRACE                 {$$ = newNode("Program"); sprintf(message,"Id(%s)",$2); $$->child = newNode(strdup(message));  addBrother($$->child, $4); if(mostraTree && erroSintatico){printTree($$,0);} else {freeTree($$);}}
                |       CLASS ID LBRACE RBRACE                              {$$ = newNode("Program"); sprintf(message,"Id(%s)",$2); $$->child = newNode(strdup(message)); if(mostraTree && erroSintatico){printTree($$,0);} else {freeTree($$);}}
                ;

Declarations    :       MethodDecl                                          {$$ = $1;}
                |       FieldDecl                                           {$$ = $1;}
                |       SEMICOLON                                           {;}
                |       Declarations MethodDecl                             {$$ = $1; addBrother($$, $2);}
                |       Declarations FieldDecl                              {$$ = $1; addBrother($$, $2);}
                |       Declarations SEMICOLON                              {$$ = $1;}
                ;

MethodDecl      :       PUBLIC STATIC MethodHeader MethodBody               {$$ = newNode("MethodDecl"); $$->child = $3; addBrother($3,$4);}

FieldDecl       :       PUBLIC STATIC Type ID SEMICOLON                     {$$ = newNode("FieldDecl"); sprintf(message,"Id(%s)",$4); $$->child = $3; addBrother($3, newNode(strdup(message)));}
                |       PUBLIC STATIC Type ID Variaveis SEMICOLON           {$$ = newNode("FieldDecl"); sprintf(message,"Id(%s)",$4); $$->child = $3; Node *temp = newNode(strdup(message)); addBrother($3,temp); addBrother(temp,$5);}
                |       error SEMICOLON                                     {$$ = newNode(NULL); erroSintatico=1;}
                ;

Variaveis       :       COMMA ID                                            {sprintf(message,"Id(%s)",$2); $$ = newNode(strdup(message));}
                |       Variaveis COMMA ID                                  {sprintf(message,"Id(%s)",$3); $$ = newNode(strdup(message));}
                ;

Type            :       BOOL                                                {$$ = newNode("Bool");}
                |       INT                                                 {$$ = newNode("Int");}
                |       DOUBLE                                              {$$ = newNode("Double");}
                ;

MethodHeader    :       Type ID LPAR FormalParams RPAR                      {$$ = newNode("MethodHeader");  sprintf(message,"Id(%s)",$2); $$->child = newNode(strdup(message));}
                |       VOID ID LPAR FormalParams RPAR                      {$$ = newNode("MethodHeader");  sprintf(message,"Id(%s)",$2); $$->child = newNode(strdup(message));}
                |       Type ID LPAR RPAR                                   {$$ = newNode("MethodHeader"); $$->child = $1;}
                |       VOID ID LPAR RPAR                                   {$$ = newNode("MethodHeader");}
                ;

FormalParams    :       Type ID Parametros                                  {$$ = $1; sprintf(message,"Id(%s)",$2); Node *temp = newNode(strdup(message)); addBrother($1,temp); addBrother(temp,$3);}
                |       Type ID                                             {$$ = $1; sprintf(message,"Id(%s)",$2); Node *temp = newNode(strdup(message)); addBrother($1,temp);}
                |       STRING LSQ RSQ ID                                   {$$ = newNode("StringArray"); sprintf(message,"Id(%s)",$4);addBrother($$,newNode(strdup(message)));}
                ;

Parametros      :       COMMA Type ID                                       {$$ = $2; sprintf(message,"Id(%s)",$3); addBrother($2, newNode(strdup(message)));}
                |       Parametros COMMA Type ID                            {$$ = $1; addBrother($1,$3); sprintf(message,"Id(%s)",$4); addBrother($3,newNode(strdup(message)));}
                ;

MethodBody      :       LBRACE Expressao RBRACE                             {$$ = newNode("MethodBody"); $$->child = $2;}
                |       LBRACE RBRACE                                       {$$ = newNode("MethodBody");}
                ;

Expressao       :       Statement                                           {$$ = $1;}
                |       VarDecl                                             {$$ = $1;}
                |       Expressao Statement                                 {$$ = $1; addBrother($1,$2);}
                |       Expressao VarDecl                                   {$$ = $1; addBrother($1,$2);}
                ;

VarDecl         :       Type ID Variaveis SEMICOLON                         {$$ = $1; sprintf(message,"Id(%s)",$2); Node *temp = newNode(strdup(message)); addBrother($1, temp); addBrother(temp, $3);}
                |       Type ID SEMICOLON                                   {$$ = $1; sprintf(message,"Id(%s)",$2); addBrother($1, newNode(strdup(message)));}
                ;

Statement       :       LBRACE Statement RBRACE                             {$$ = $2;}
                |       LBRACE RBRACE                                       {;}
                |       IF LPAR Expr RPAR Statement ELSE Statement          {$$ = $3; addBrother($3, $5); addBrother($5, $7);}/*$$ = newNode("If"); $$->child=$3; if(!$5){$5=newNode("Null");} if(!$7){$7=newNode("Null");} addBrother($3,$5);addBrother($5,$7);*/
                |       IF LPAR Expr RPAR Statement                         {$$ = $3; addBrother($3, $5);/*$$ = newNode("If"); $$->child=$3; if(!$5){$5=newNode("Null");} addBrother($3,$5); addBrother($5,newNode("Null"));*/}
                |       WHILE LPAR Expr RPAR Statement                      {$$ = $3; addBrother($3, $5);}
                |       RETURN Expr SEMICOLON                               {$$ = newNode("Return"); $$->child = $2;} // TODO: verificar se e $$ ou $1 e se e brother ou child
                |       RETURN SEMICOLON                                    {$$ = newNode("Return"); $$->child = NULL;}
                |       Gramatica SEMICOLON                                 {$$ = $1;}
                |       SEMICOLON                                           {;}
                |       PRINT LPAR Expr RPAR SEMICOLON                      {$$ = newNode("Print"); $$->child = $3;}
                |       PRINT LPAR STRLIT RPAR SEMICOLON                    {$$ = newNode("Print"); sprintf(message,"StrLit(%s)",$3); $$->child = newNode(strdup(message));}
                |       error SEMICOLON                                     {$$ = newNode(NULL); erroSintatico=1;}
                ;

Gramatica       :       MethodInvocation                                    {$$ = $1;}
                |       Assignment                                          {$$ = $1;}
                |       ParseArgs                                           {$$ = $1;}
                ;

MethodInvocation:       ID LPAR CommaExpr RPAR                              {sprintf(message,"Id(%s)",$1); $$ = newNode(strdup(message)); addBrother($$,$3);}
                |       ID LPAR RPAR                                        {sprintf(message,"Id(%s)",$1); $$ = newNode(strdup(message));}
                |       ID LPAR error RPAR                                  {$$ = newNode(NULL); erroSintatico=1;}
                ;

CommaExpr       :       Expr                                                {$$ = $1;}
                |       CommaExpr COMMA Expr                                {$$ = $1;addBrother($1,$3);}
                ;

Assignment      :       ID ASSIGN Expr                                      {sprintf(message,"Id(%s)",$1);$$ = newNode(strdup(message));addBrother($$,$3);}
                ;

ParseArgs       :       PARSEINT LPAR ID LSQ Expr RSQ RPAR                  {sprintf(message,"Id(%s)",$3);$$ = newNode(strdup(message));addBrother($$,$5);}
                |       PARSEINT LPAR error RPAR                            {$$ = newNode(NULL); erroSintatico=1;}    
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
                |       PLUS Expr                                           {$$ = newNode("Plus"); $$->child=$2;}
                |       LPAR Expr RPAR                                      {$$ = $2;}
                |       MethodInvocation                                    {$$ = $1;}
                |       Assignment                                          {$$ = $1;}
                |       ParseArgs                                           {$$ = $1;}
                |       ID DOTLENGTH                                        {sprintf(message,"Id(%s)",$1); $$ = newNode(strdup(message)); addBrother($$,  newNode("Length"));} // FIXME: aqui talvez nao seja brother e sim filho do $1
                |       ID                                                  {sprintf(message,"Id(%s)",$1);$$ = newNode(strdup(message));}
                |       INTLIT                                              {sprintf(message, "DecLit(%s)", $1);$$ = newNode(strdup(message));}
                |       REALLIT                                             {sprintf(message, "RealLit(%s)", $1);$$ = newNode(strdup(message));}
                |       BOOLLIT                                             {sprintf(message, "BoolLit(%s)", $1);$$ = newNode(strdup(message));}
                |       LPAR error RPAR                                     {$$ = newNode(NULL); erroSintatico=1;}
                ;

%%
