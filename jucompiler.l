%{
    #include <string.h>
    int contador_linhas = 1;
    int contador_colunas = 1;
    int flag = 0;
    int flag_erros = 0;
%}

carateres               ([a-z]|[A-z]|"_"|"$")([a-z]|[A-z]|"_"|"$"|[0-9])*
naturais                [1-9]
inteiros                [0-9]
sinal                   "-"|"+"
SeqEscInv               \a|\b|\v|\'|\?|\ooo|\xhh|\xhhhh

%X COMMENT STRING    
%% 

" "                           {contador_colunas++;}       
"\r\n"|"\r"|"\n"              {contador_colunas=1; contador_linhas++;}      
"true"|"false"                {if (flag) printf("BOOLIT\n");contador_colunas+=yyleng;}
"&&"                          {if (flag) printf("END\n");contador_colunas+=yyleng;}
"="                           {if (flag) printf("ASSIGN\n");contador_colunas+=yyleng;}
"*"                           {if (flag) printf("STAR\n");contador_colunas+=yyleng;}
","                           {if (flag) printf("COMMA\n");contador_colunas+=yyleng;}
"/"                           {if (flag) printf("DIV\n");contador_colunas+=yyleng;}
"=="                          {if (flag) printf("EQ\n");contador_colunas+=yyleng;}
">="                          {if (flag) printf("GE\n");contador_colunas+=yyleng;}
">"                           {if (flag) printf("GT\n");contador_colunas+=yyleng;}
"{"                           {if (flag) printf("LBRACE\n");contador_colunas+=yyleng;}
"<="                          {if (flag) printf("LE\n");contador_colunas+=yyleng;}
"("                           {if (flag) printf("LPAR\n");contador_colunas+=yyleng;}
"["                           {if (flag) printf("LSQ\n");contador_colunas+=yyleng;}
"<"                           {if (flag) printf("LT\n");contador_colunas+=yyleng;}
"-"                           {if (flag) printf("MINUS\n");contador_colunas+=yyleng;}
"%"                           {if (flag) printf("MOD\n");contador_colunas+=yyleng;}
"!="                          {if (flag) printf("NE\n");contador_colunas+=yyleng;}
"!"                           {if (flag) printf("NOT\n");contador_colunas+=yyleng;}
"||"                          {if (flag) printf("OR\n");contador_colunas+=yyleng;}
"+"                           {if (flag) printf("PLUS\n");contador_colunas+=yyleng;}
"}"                           {if (flag) printf("RBRACE\n");contador_colunas+=yyleng;}
")"                           {if (flag) printf("RPAR\n");contador_colunas+=yyleng;}
"]"                           {if (flag) printf("RSQ\n");contador_colunas+=yyleng;}
";"                           {if (flag) printf("SEMICOLON\n");contador_colunas+=yyleng;}
"->"                          {if (flag) printf("ARROW\n");contador_colunas+=yyleng;}
"<<"                          {if (flag) printf("LSHIFT\n");contador_colunas+=yyleng;}
">>"                          {if (flag) printf("RSHIFT\n");contador_colunas+=yyleng;}
"^"                           {if (flag) printf("XOR\n");contador_colunas+=yyleng;}
"boolean"                     {if (flag) printf("BOOL\n");contador_colunas+=yyleng;}
"class"                       {if (flag) printf("CLASS\n");contador_colunas+=yyleng;}
".length"                     {if (flag) printf("DOTLENGTH\n");contador_colunas+=yyleng;}
"double"                      {if (flag) printf("DOUBLE\n");contador_colunas+=yyleng;}
"else"                        {if (flag) printf("ELSE\n");contador_colunas+=yyleng;}
"if"                          {if (flag) printf("IF\n");contador_colunas+=yyleng;}
"int"                         {if (flag) printf("INT\n");contador_colunas+=yyleng;}
"System.out.print"            {if (flag) printf("PRINT\n");contador_colunas+=yyleng;}
"Integer.parseInt"            {if (flag) printf("PARSEINT\n");contador_colunas+=yyleng;}
"public"                      {if (flag) printf("PUBLIC\n");contador_colunas+=yyleng;}
"return"                      {if (flag) printf("RETURN\n");contador_colunas+=yyleng;}
"static"                      {if (flag) printf("STATIC\n");contador_colunas+=yyleng;}
"String"                      {if (flag) printf("STRING\n");contador_colunas+=yyleng;}
"void"                        {if (flag) printf("VOID\n");contador_colunas+=yyleng;}
"while"                       {if (flag) printf("WHILE\n");contador_colunas+=yyleng;}

{carateres}                   {if (flag) printf("ID(%s)\n", yytext);contador_colunas+=yyleng;}

"_"|"0"|{naturais}{inteiros}*                                  {if (flag) printf("INTLIT\n");contador_colunas+=yyleng;}

("_"|{inteiros}+)("e"|"E"){sinal}{inteiros}+                   {printf("REALLIT\n");contador_colunas+=yyleng;}
("_"|{inteiros}+)"."({inteiros}+("e"{sinal}{inteiros}+)?)?     {printf("REALLIT\n");contador_colunas+=yyleng;}
"."{inteiros}+(("e"|"E"){sinal}{inteiros}+)?                   {printf("REALLIT\n");contador_colunas+=yyleng;}

\/\/(.*)                       {contador_colunas+=yyleng;}  /*comentario para linha unica */

\"                          {BEGIN STRING;contador_colunas+=yyleng;}
<STRING>{carateres}         {if (flag) printf("STRLIT\n");contador_colunas+=yyleng;}
<STRING><<EOF>>             {if (flag_erros) printf("Line %d, col %d: unterminated string literal", contador_linhas, contador_colunas);}
<STRING>\"                  {BEGIN 0; contador_colunas+=yyleng;}

\/\*                        {BEGIN COMMENT;contador_colunas+=yyleng;}
<COMMENT>\*\/               {BEGIN 0; contador_colunas+=yyleng;}
<COMMENT>"\n\r"|"\r"|"\n"   {contador_colunas=1; contador_linhas++;}
<COMMENT><<EOF>>            {if (flag_erros) printf("Line %d, col %d: unterminated comment", contador_linhas, contador_colunas);}
<COMMENT>(.*)               {contador_colunas+=yyleng;}

%%

int main(int argc, char *argv[]) {

    if(argc == 1){
        if(!strcmp(argv[1], "-l")){
            flag = 1;
        }
        if(!strcmp(argv[1], "-e1")){
            flag_erros = 1;
        }
    }
    
    if(argc == 2){
        if(!strcmp(argv[1], "-l")|!strcmp(argv[2], "-l")){
            flag = 1;
        }
        if(!strcmp(argv[1], "-e1")|!strcmp(argv[2], "-e1")){
            flag_erros = 1;
        }
    }
    
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}