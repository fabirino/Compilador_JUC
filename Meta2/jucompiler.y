%{
    /* ===================================================================================
	    Compiladores -  Eduardo Figueiredo 2020213717
                        Fabio Santos       2020212310
    ====================================================================================== */
    #include <stdio.h>
    
    int yylex(void);
    void yyerror (const char *s);
%}

%token BOOLLIT AND ASSIGN STAR COMMA DIV EQ GE GT LBRACE LE LPAR LSQ LT MINUS MOD NE NOT OR PLUS RBRACE RPAR RSQ SEMICOLON LSHIFT RSHIFT XOR BOOL CLASS DOTLENGTH DOUBLE ELSE IF INT PRINT PARSEINT PUBLIC RETURN STATIC STRING VOID WHILE ID INTLIT REALLIT STRLIT

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

%%

Program         :       CLASS ID LBRACE Declarations RBRACE 
                |       CLASS ID LBRACE RBRACE
                ;

Declarations    :       MethodDecl
                |       FieldDecl
                |       SEMICOLON
                |       Declarations MethodDecl
                |       Declarations FieldDecl
                |       Declarations SEMICOLON
                ;

MethodDecl      :       PUBLIC STATIC MethodHeader MethodBody

FieldDecl       :       PUBLIC STATIC Type ID SEMICOLON
                |       PUBLIC STATIC Type ID Variaveis SEMICOLON
                |       error SEMICOLON
                ;

Variaveis       :       COMMA ID
                |       Variaveis COMMA ID
                ;

Type            :       BOOL
                |       INT 
                |       DOUBLE
                ;

MethodHeader    :       Type ID LPAR FormalParams RPAR
                |       VOID ID LPAR FormalParams RPAR
                |       Type ID LPAR RPAR
                |       VOID ID LPAR RPAR
                ;

FormalParams    :       Type ID Parametros
                |       Type ID 
                |       STRING LSQ RSQ ID
                ;

Parametros      :       COMMA Type ID
                |       Parametros COMMA Type ID
                ;

MethodBody      :       LBRACE Expressao RBRACE
                |       LBRACE RBRACE
                ;
                
Expressao       :       Statement
                |       VarDecl
                |       Expressao Statement
                |       Expressao VarDecl
                ;

VarDecl         :       Type ID Variaveis SEMICOLON
                |       Type ID SEMICOLON
                ;

Statement       :       LBRACE Statement RBRACE
                |       LBRACE RBRACE
                |       IF LPAR Expr RPAR Statement ELSE Statement 
                |       IF LPAR Expr RPAR Statement
                |       WHILE LPAR Expr RPAR Statement
                |       RETURN Expr SEMICOLON
                |       RETURN SEMICOLON
                |       Gramatica SEMICOLON
                |       SEMICOLON
                |       PRINT LPAR Expr RPAR SEMICOLON
                |       PRINT LPAR STRLIT RPAR SEMICOLON
                |       error SEMICOLON
                ;

Gramatica       :       MethodInvocation
                |       Assignment
                |       ParseArgs
                ;

MethodInvocation:       ID LPAR CommaExpr RPAR
                |       ID LPAR RPAR
                |       ID LPAR error RPAR
                ;

CommaExpr       :       Expr
                |       CommaExpr COMMA Expr
                ;

Assignment      :       ID ASSIGN Expr
                ;

ParseArgs       :       PARSEINT LPAR ID LSQ Expr RSQ RPAR
                |       PARSEINT LPAR error RPAR
                ;

Expr            :       Expr PLUS Expr
                |       Expr MINUS Expr
                |       Expr STAR Expr
                |       Expr DIV Expr
                |       Expr MOD Expr
                |       Expr AND Expr
                |       Expr OR Expr
                |       Expr XOR Expr
                |       Expr LSHIFT Expr
                |       Expr RSHIFT Expr
                |       Expr EQ Expr
                |       Expr GE Expr
                |       Expr GT Expr
                |       Expr LE Expr
                |       Expr LT Expr
                |       Expr NE Expr 
                |       MINUS Expr
                |       NOT Expr
                |       PLUS Expr
                |       LPAR Expr RPAR
                |       MethodInvocation
                |       Assignment 
                |       ParseArgs
                |       ID DOTLENGTH
                |       ID
                |       INTLIT
                |       REALLIT
                |       BOOLLIT
                |       LPAR error RPAR
                ;

%%
