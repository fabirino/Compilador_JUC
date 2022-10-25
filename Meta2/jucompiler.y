%{
    /* ===================================================================================
	    Compiladores -  Eduardo Figueiredo 2020213717
                        Fabio Santos       2020212310
    ====================================================================================== */

%}

%TOKEN BOOLLIT,AND,ASSIGN,STAR,COMMA,DIV,EQ,GE,GT,LBRACE,LE,LPAR,LSQ,LT,MINUS,MOD,NE,NOT,OR,PLUS,RBRACE,RPAR,RSQ,SEMICOLON,ARROW,LSHIFT,RSHIFT,XOR,BOOL,CLASS,DOTLENGTH,DOUBLE,ELSE,IF,INT,PRINT,PARSEINT,PUBLIC,RETURN,STATIC,STRING,VOID,WHILE,RESERVED,ID,INTLIT,REALLIT

%%

Program: CLASS ID LBRACE (MethodDecl | FieldDecl | SEMICOLON)* RBRACE // Qualquer coisa com simbolos terminais
MethodDecl: PUBLIC STATIC MethodHeader MethodBody
FieldDecl: PUBLIC STATIC Type ID
Type: BOOL | INT | DOUBLE
MethodHeader: (Type | VOID) ID LPAR FormalParams* RPAR
FormalParams: Type ID (COMMA Type ID)*
            | STRING LSQ RSQ ID
MethodBody: LBRACE {Statment | VarDecl} RBRACE
VarDecl: Type ID {COMMA ID} SEMICOLON
Statement: IF LPAR Expr RPAR Statment ELSE Statment
         | IF LPAR Expr RPAR Statment
         | WHILE LPAR Expr RPAR Statement
         | RETURN [ Expr ] SEMICOLON
         | [(MethodInvocation | Assignment | ParseArgs)] SEMICOLON
         | PRINT LPAR Expr RPAR SEMICOLON
         | PRINT LPAR STRLIT RPAR SEMICOLON
MethodInvocation: ID PAR {Expr {COMMA Expr}} RPAR
ParseArgs: PARSEINT LPAR ID LSQ Expr RSQ RPAR
Expr: Expr (PLUS | MINUS | STAR | DIV MOD ) Expr
    | Expr (AND | OR | XOR | LSHIFT | RSHIFT) Expr
    | Expr (EQ | GE | GT | LE | LT | NE) Expr
    | (MINUS | NOT | PLUS) Expr
    | LPAR Expr RPAR
    | MethodInvocation | Assignment | ParseArgs
    | ID [DOTLENGTH]
    | INTLIT | REALLIT | BOOLLIT
%%

int main(int argc, char *argv[]) {

    if(argc == 2){
        if(!strcmp(argv[1], "-l")){
            flag = 1;
        }else if(strcmp(argv[1], "-e1")!=0){
                printf("Flag nao existe");
                return 0;
        } 
    }
    
    if(argc == 3){
        for(int i = 1;i<argc;i++){
            if(!strcmp(argv[i], "-l")) flag = 1;
            else if(strcmp(argv[i], "-e1")!=0){
                printf("Flag nao existe");
                return 0;
            }
        }
    }

    yylex();
    return 0;
}

