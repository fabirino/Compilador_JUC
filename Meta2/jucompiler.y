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

Program         :       CLASS ID LBRACE Declarations RBRACE                 {$$ = newNode("Program"); $$->child=$4; if(printTree && erroSintatico){printTree($$,0);} else {freeTree($$);}}
                |       CLASS ID LBRACE RBRACE                              {$$ = newNode("Program");}
                ;

Declarations    :       MethodDecl                                          {$$ = $1;}
                |       FieldDecl                                           {$$ = $1;}
                |       SEMICOLON                                           {$$ = $1;}
                |       Declarations MethodDecl                             {$$ = $1; addBrother($$, $2);}
                |       Declarations FieldDecl                              {$$ = $1; addBrother($$, $2);}
                |       Declarations SEMICOLON                              {$$ = $1; addBrother($$, $2);}
                ;

MethodDecl      :       PUBLIC STATIC MethodHeader MethodBody               {$$ = newNode("MethodDecl"); $$->child = $2; addBrother($2,$3);}

FieldDecl       :       PUBLIC STATIC Type ID SEMICOLON                     {$$ = newNode("FieldDecl"); $$->child = $3;}
                |       PUBLIC STATIC Type ID Variaveis SEMICOLON           {$$ = newNode("FieldDecl"); $$->child = $3; addBrother($3,$5)}
                |       error SEMICOLON                                     {$$ = newNode(NULL); erroSintatico=1;}
                ;

Variaveis       :       COMMA ID                                            {} //FIXME: genuinamente nao sei o que por aqui
                |       Variaveis COMMA ID                                  {}
                ;

Type            :       BOOL                                                {$$ = newNode("Bool");}
                |       INT                                                 {$$ = newNode("Int");}
                |       DOUBLE                                              {$$ = newNode("Double");}
                ;

MethodHeader    :       Type ID LPAR FormalParams RPAR                      {$$ = newNode("MethodHeader"); $$->child = $1; addBrother($1, $4)}
                |       VOID ID LPAR FormalParams RPAR                      {$$ = newNode("MethodHeader"); $$->child = $4}
                |       Type ID LPAR RPAR                                   {$$ = newNode("MethodHeader"); $$->child = $1}
                |       VOID ID LPAR RPAR                                   {$$ = newNode("MethodHeader");}
                ;

FormalParams    :       Type ID Parametros                                  {$$ = $1;}      //FIXME: tambem podera estar mal, nao tinha meio de comparacao
                |       Type ID                                             {$$ = $1;}
                |       STRING LSQ RSQ ID                                   {$$ = NULL;}
                ;

Parametros      :       COMMA Type ID                                       {$$ = $2;}
                |       Parametros COMMA Type ID                            {$$ = $1; addBrother($$, $3);}  //TODO: verificar se e child ou brother
                ;

MethodBody      :       LBRACE Expressao RBRACE                             {$$ = newNode("MethodBody"); $$->child = $2;}
                |       LBRACE RBRACE                                       {$$ = newNode("MethodBody");}
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
