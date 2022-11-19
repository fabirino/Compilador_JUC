%{
    /* ===================================================================================
	    Compiladores -  Eduardo Figueiredo 2020213717
                        Fábio Santos       2020212310
    ====================================================================================== */
    #include <stdio.h>
    #include "STree.h"
    
    int yylex(void);
    extern int mostraTree;
    char message[1024];
    char lastType[64];
    int debug = 1; //DEBUG: variavel apenas para debug!!!
    extern int erroSintax; 
    extern struct node * raiz;
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
                                                                                                                                                                                                                                                                                      
Program         :       CLASS ID LBRACE Declarations RBRACE                 {$$ = raiz = newNode("Program",""); sprintf(message,"Id(%s)",$2); $$->child = newNode(strdup(message),strdup($2)); addBrother($$->child , $4); }
                ;

Declarations    :       MethodDecl Declarations                             {$$ = $1;addBrother($$,$2);}
                |       FieldDecl Declarations                              {$$ = $1;addBrother($$,$2);}
                |       SEMICOLON Declarations                              {$$ = $2;};                
                |                                                           {$$ = NULL;}
                ;

MethodDecl      :       PUBLIC STATIC MethodHeader MethodBody               {$$ = newNode("MethodDecl","");$$->child = $3;addBrother($$->child,$4);}
                                                                            
FieldDecl       :       PUBLIC STATIC Type ID Variaveis SEMICOLON           {$$ = newNode("FieldDecl",""); $$->child = $3; sprintf(message,"Id(%s)",$4);struct node * id = newNode(strdup(message),strdup($4)); addBrother($$->child,id); addBrother($$,$5);}
                |       error SEMICOLON                                     {$$ = newNode(NULL,"");erroSintax = 1;}
                ;

Variaveis       :       COMMA ID Variaveis                                  {$$ = newNode("FieldDecl",""); struct node * type = newNode(strdup(lastType),"");$$->child = type; sprintf(message,"Id(%s)",$2); struct node * id = newNode(strdup(message),strdup($2)); addBrother($$->child,id); addBrother($$,$3); }
                |                                                           {$$ = NULL;}
                ;

Type            :       BOOL                                                {$$ = newNode("Bool","");memset(lastType,0,64);strcpy(lastType,"Bool");}
                |       INT                                                 {$$ = newNode("Int","");memset(lastType,0,64);strcpy(lastType,"Int");}
                |       DOUBLE                                              {$$ = newNode("Double","");memset(lastType,0,64);strcpy(lastType,"Double");}
                ;

MethodHeader    :       Type ID LPAR FormalParams RPAR                      {$$ = newNode("MethodHeader",""); $$->child = $1;sprintf(message,"Id(%s)",$2); node * id = newNode(strdup(message),strdup($2));addBrother($$->child,id);addBrother(id,$4);}
                |       VOID ID LPAR FormalParams RPAR                      {$$ = newNode("MethodHeader","");$$->child = newNode("Void","");sprintf(message,"Id(%s)",$2); node * id = newNode(strdup(message),strdup($2));addBrother($$->child,id);addBrother(id,$4);}
                |       Type ID LPAR RPAR                                   {$$ = newNode("MethodHeader","");$$->child = $1;sprintf(message,"Id(%s)",$2); node * id = newNode(strdup(message),strdup($2));addBrother($$->child,id); addBrother(id,newNode("MethodParams",""));}
                |       VOID ID LPAR RPAR                                   {$$ = newNode("MethodHeader","");$$->child = newNode("Void","");sprintf(message,"Id(%s)",$2); node * id = newNode(strdup(message),strdup($2));addBrother($$->child,id); addBrother(id,newNode("MethodParams",""));}
                ;
                                                                            
FormalParams    :       Type ID Parametros                                  {$$ = newNode("MethodParams","");node * param = newNode("ParamDecl",""); param->child = $1; sprintf(message,"Id(%s)",$2); node * id = newNode(strdup(message),strdup($2)); addBrother(param->child,id); $$->child = param;addBrother($$->child,$3);}
                |       STRING LSQ RSQ ID                                   {$$ = newNode("MethodParams","");node * param = newNode("ParamDecl",""); node * array = newNode("StringArray",""); param->child = array;sprintf(message,"Id(%s)",$4); node * id = newNode(strdup(message),strdup($4)); addBrother(param->child,id);$$->child = param;}
                ;

Parametros      :       COMMA Type ID Parametros                            {$$ = newNode("ParamDecl","");$$->child = $2;sprintf(message,"Id(%s)",$3); node * id = newNode(strdup(message),strdup($3));addBrother($$->child,id);addBrother($$,$4);}
                |                                                           {$$ = NULL;}
                ;                                                           

MethodBody      :       LBRACE Expressao RBRACE                             {$$ = newNode("MethodBody","");$$->child = $2;}
                ;

Expressao       :       Statement Expressao                                 {if($1) {$$ = $1; addBrother($$, $2);}else{$$=$2;}}
                |       VarDecl Expressao                                   {$$ = $1;addBrother($$,$2);}
                |                                                           {$$ = NULL;}
                ;
                                                                            
VarDecl         :       Type ID VariaveisVar SEMICOLON                      {$$ = newNode("VarDecl",""); $$->child = $1;sprintf(message,"Id(%s)",$2); node * id = newNode(strdup(message),strdup($2)); addBrother($$->child,id);addBrother($$,$3);}
                ;

VariaveisVar    :       COMMA ID VariaveisVar                               {$$ = newNode("VarDecl",""); node * type = newNode(strdup(lastType),""); $$->child = type; sprintf(message,"Id(%s)",$2); node * id = newNode(strdup(message),strdup($2)); addBrother($$->child,id); addBrother($$,$3);}
                |                                                           {$$ = NULL;}
                ;

Statement       :       LBRACE recursaoS RBRACE                             {if ($2!=NULL){if ($2->brother != NULL){$$ = newNode("Block",""); $$->child = $2;} else {$$ = $2;}} else {$$ = $2;};}
                |       IF LPAR Expr RPAR Statement  ELSE Statement         {$$ = newNode("If",""); $$->child = $3;
                                                                                    if ($5 != NULL && numBrothers($5) == 1) {
                                                                                        addBrother($3, $5);
                                                                                        if ($7 != NULL && numBrothers($7) == 1){
                                                                                            addBrother($5, $7);
                                                                                        } else {
                                                                                            addBrother($5, newNode("Block",""));
                                                                                            $5->brother->child = $7;
                                                                                        }
                                                                                    } else {
                                                                                        struct node * temp = newNode("Block","");
                                                                                        addBrother($3, temp);
                                                                                        temp->child = $5;
                                                                                        if($7 != NULL && numBrothers($7) == 1){
                                                                                            addBrother(temp, $7); 
                                                                                        }
                                                                                        else{
                                                                                            addBrother(temp, newNode("Block",""));
                                                                                            temp->brother->child = $7;
                                                                                        }
                                                                                    }
                                                                            }
                |       IF LPAR Expr RPAR Statement                         {$$ = newNode("If",""); $$->child = $3;
                                                                                    if ($5!=NULL && numBrothers($5) == 1) {
                                                                                        addBrother($3, $5);
                                                                                        addBrother($5, newNode("Block",""));
                                                                                    } else {
                                                                                        struct node * temp = newNode("Block","");
                                                                                        addBrother($3, temp);
                                                                                        temp->child = $5;
                                                                                        addBrother(temp, newNode("Block",""));
                                                                                    }
                                                                            }
                |       WHILE LPAR Expr RPAR Statement                      {$$ = newNode("While",""); $$->child = $3; 
                                                                                    if($5 != NULL && numBrothers($5) < 2){
                                                                                        addBrother($3, $5);
                                                                                    } else{
                                                                                        addBrother($3, newNode("Block",""));
                                                                                        $3->brother->child = $5;
                                                                                    }
                                                                            }
                |       RETURN Expr SEMICOLON                               {$$ = newNode("Return",""); $$->child = $2;} 
                |       RETURN SEMICOLON                                    {$$ = newNode("Return","");}
                |       PRINT LPAR Expr RPAR SEMICOLON                      {$$ = newNode("Print",""); $$->child = $3;}
                |       PRINT LPAR STRLIT RPAR SEMICOLON                    {$$ = newNode("Print",""); sprintf(message, "StrLit(\"%s)", $3); $$->child = newNode(strdup(message),strdup($3));}  
                |       MethodInvocation SEMICOLON                          {$$ = $1;}
                |       Assignment SEMICOLON                                {$$ = $1;}
                |       ParseArgs SEMICOLON                                 {$$ = $1;}
                |       SEMICOLON                                           {$$ = NULL;}
                |       error SEMICOLON                                     {$$ = newNode(NULL,NULL);erroSintax = 1;}
                ;

recursaoS       :       Statement recursaoS                                 {if($$!=NULL){$$=$1; addBrother($$,$2);} else{$$=$2;}}
                |                                                           {$$ = NULL;}
                ; 
                                                                            
MethodInvocation:       ID LPAR Expr CommaExpr RPAR                         {$$ = newNode("Call",""); sprintf(message, "Id(%s)", $1); $$->child = newNode(strdup(message),strdup($1)); addBrother($$->child, $3); addBrother($3, $4);}
                |       ID LPAR RPAR                                        {$$ = newNode("Call",""); sprintf(message, "Id(%s)", $1); $$->child = newNode(strdup(message),strdup($1));}
                |       ID LPAR error RPAR                                  {$$ = newNode(NULL,NULL);erroSintax = 1;}
                ;

CommaExpr       :       COMMA Expr CommaExpr                                {$$ = $2; addBrother($2, $3);}
                |                                                           {$$ = NULL;}
                ;

Assignment      :       ID ASSIGN Expr                                      {$$ = newNode("Assign",""); sprintf(message, "Id(%s)", $1); $$->child = newNode(strdup(message),strdup($1)); addBrother($$->child, $3);}
                ;

ParseArgs       :       PARSEINT LPAR ID LSQ Expr RSQ RPAR                  {$$ = newNode("ParseArgs",""); sprintf(message, "Id(%s)", $3); $$->child = newNode(strdup(message),strdup($3)); addBrother($$->child, $5);}
                |       PARSEINT LPAR error RPAR                            {$$ = newNode(NULL,NULL);erroSintax = 1;}    
                ;

Expr            :       Assignment                                          {$$ = $1;}
                |       Expr2                                               {$$ = $1;}
                ;


Expr2           :       Expr2 PLUS Expr2                                    {$$ = newNode("Add",""); $$->child=$1; addBrother($1,$3);}
                |       Expr2 MINUS Expr2                                   {$$ = newNode("Sub",""); $$->child=$1; addBrother($1,$3);}
                |       Expr2 STAR Expr2                                    {$$ = newNode("Mul",""); $$->child=$1; addBrother($1,$3);}
                |       Expr2 DIV Expr2                                     {$$ = newNode("Div",""); $$->child=$1; addBrother($1,$3);}
                |       Expr2 MOD Expr2                                     {$$ = newNode("Mod",""); $$->child=$1; addBrother($1,$3);}
                |       Expr2 AND Expr2                                     {$$ = newNode("And",""); $$->child=$1; addBrother($1,$3);}
                |       Expr2 OR Expr2                                      {$$ = newNode("Or",""); $$->child=$1; addBrother($1,$3);}
                |       Expr2 XOR Expr2                                     {$$ = newNode("Xor",""); $$->child=$1; addBrother($1,$3);}
                |       Expr2 LSHIFT Expr2                                  {$$ = newNode("Lshift",""); $$->child=$1; addBrother($1,$3);}
                |       Expr2 RSHIFT Expr2                                  {$$ = newNode("Rshift",""); $$->child=$1; addBrother($1,$3);}
                |       Expr2 EQ Expr2                                      {$$ = newNode("Eq",""); $$->child=$1; addBrother($1,$3);}
                |       Expr2 GE Expr2                                      {$$ = newNode("Ge",""); $$->child=$1; addBrother($1,$3);}
                |       Expr2 GT Expr2                                      {$$ = newNode("Gt",""); $$->child=$1; addBrother($1,$3);}
                |       Expr2 LE Expr2                                      {$$ = newNode("Le",""); $$->child=$1; addBrother($1,$3);}
                |       Expr2 LT Expr2                                      {$$ = newNode("Lt",""); $$->child=$1; addBrother($1,$3);}
                |       Expr2 NE Expr2                                      {$$ = newNode("Ne",""); $$->child=$1; addBrother($1,$3);}
                |       MINUS Expr2        %prec NOT                        {$$ = newNode("Minus",""); $$->child=$2;}
                |       PLUS Expr2         %prec NOT                        {$$ = newNode("Plus",""); $$->child=$2;}
                |       NOT Expr2                                           {$$ = newNode("Not",""); $$->child=$2;}
                |       LPAR Expr RPAR                                      {$$ = $2;}
                |       MethodInvocation                                    {$$ = $1;}
                |       ParseArgs                                           {$$ = $1;}
                |       ID DOTLENGTH                                        {$$ = newNode("Length",""); sprintf(message, "Id(%s)", $1); $$->child = newNode(strdup(message),strdup($1));} 
                |       ID                                                  {sprintf(message, "Id(%s)", $1); $$ = newNode(strdup(message),strdup($1));}
                |       INTLIT                                              {sprintf(message, "DecLit(%s)", $1); $$ = newNode(strdup(message),strdup($1));}
                |       REALLIT                                             {sprintf(message, "RealLit(%s)", $1); $$ = newNode(strdup(message),strdup($1));}
                |       BOOLLIT                                             {sprintf(message, "BoolLit(%s)", $1); $$ = newNode(strdup(message),strdup($1));}
                |       LPAR error RPAR                                     {$$ = newNode(NULL,NULL); erroSintax = 1;}
                ;

%%
