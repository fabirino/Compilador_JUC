%{
    #include <stdio.h>
    #include <string.h>
    
    int contador_linhas = 1;
    int contador_colunas = 1;
    int flag = 0;
    int escape = 1;
    char buf[1000];
    char *s;
    int col_string =1;
    int col_comment = 1;
    int line_comment = 1;
%}

carateres               ([a-z]|[A-Z]|"_"|"$")([a-z]|[A-Z]|"_"|"$"|[0-9])*
naturais                [1-9]
inteiros                [0-9]
sinal                   "-"|"+"
SeqEscInv               "\\"[^("r|"f"|"n"|"t"|"\\"|\")]

%X COMMENT STRING    
%% 
(\r)?\n|(\n)?\r                       {contador_colunas=1; contador_linhas++;}
"\\\n"                        {printf("Line %d, col %d: invalid escape sequence(\\)\n", contador_linhas++, contador_colunas);contador_colunas=1;}
"\\\r"                        {printf("Line %d, col %d: invalid escape sequence(\\)\n", contador_linhas++, contador_colunas);contador_colunas=1;}
{SeqEscInv}                   {printf("Line %d, col %d: invalid escape sequence(%s)\n", contador_linhas, contador_colunas,yytext);contador_colunas+=yyleng;}   
"true"|"false"                {if (flag) printf("BOOLIT(%s)\n",yytext);contador_colunas+=yyleng;}
"&&"                          {if (flag) printf("AND\n");contador_colunas+=yyleng;}
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
\t                            {contador_colunas+=yyleng;}

"++"|"--"|"null"|"Integer"|"System"|"break"|"byte"|"case"|"catch"|"char"|"const"|"enum"|"extends"|"final"|"finally"|"float"      {if (flag) printf("RESERVED(%s)\n", yytext);contador_colunas+=yyleng;}
"for"|"implements"|"import"|"instanceof"|"interface"|"long"|"native"|"new"|"protected"|"short"|"strictfp"|"super"|"this"         {if (flag) printf("RESERVED(%s)\n", yytext);contador_colunas+=yyleng;}
"throw"|"throws"|"transient"|"try"|"volatile"|"abstract"|"continue"|"switch"|"assert"|"default"|"package"|"synchronized"         {if (flag) printf("RESERVED(%s)\n", yytext);contador_colunas+=yyleng;}
"do"|"goto"|"private"                                                                                                            {if (flag) printf("RESERVED(%s)\n", yytext);contador_colunas+=yyleng;}

{carateres}                   {if (flag) printf("ID(%s)\n", yytext);contador_colunas+=yyleng;}

"0"|{naturais}("_"*({inteiros}+))*                                  {if (flag) printf("INTLIT(%s)\n",yytext);contador_colunas+=yyleng;}

(("_"*{inteiros}+))+(".")?("e"|"E"){sinal}?{inteiros}("_"*{inteiros}+)*                   {printf("REALLIT(%s)\n",yytext);contador_colunas+=yyleng;}
(("_"*{inteiros}+))+"."(("_"*{inteiros}+)+(("e"|"E"){sinal}?("_"*{inteiros}+)+)?)?     {printf("REALLIT(%s)\n",yytext);contador_colunas+=yyleng;}
"."("_"*{inteiros}+)+(("e"|"E"){sinal}?("_"*{inteiros}+)+)?                   {printf("REALLIT(%s)\n",yytext);contador_colunas+=yyleng;}

\/\/.*                     {contador_colunas+=yyleng;}  /*comentario para linha unica */

\"                            { BEGIN STRING; s = buf; escape = 1;col_string = contador_colunas;contador_colunas+=yyleng;}
<STRING>\\\"                  { *s++ = '\\';*s++ = '\"'; contador_colunas+=yyleng;}
<STRING>\\\\                  { *s++ = '\\';*s++ = '\\'; contador_colunas+=yyleng;}
<STRING>\"                    { 
                                *s = 0;
                                BEGIN 0;
                                if ((flag) && (escape)) printf("STRLIT(\"%s\")\n",buf);
                                contador_colunas+=yyleng;
                              }
<STRING>(\r)?\n|(\n)?\r             {*s = 0;BEGIN 0;printf("Line %d, col %d: unterminated string literal\n", contador_linhas, col_string);contador_colunas=1; contador_linhas++;}
<STRING>"\\\n"|"\\\r"|"\\\r\n"                {printf("Line %d, col %d: invalid escape sequence(\\)\n", contador_linhas, contador_colunas);*s = 0;
                                BEGIN 0;printf("Line %d, col %d: unterminated string literal\n", contador_linhas, col_string);
                                contador_colunas=1; contador_linhas++;}
<STRING>{SeqEscInv}           {printf("Line %d, col %d: invalid escape sequence(%s)\n", contador_linhas, contador_colunas,yytext);escape =0;contador_colunas+=yyleng;}      
<STRING>.                     { *s++ = *yytext; contador_colunas+=yyleng;}
<STRING><<EOF>>               {printf("Line %d, col %d: unterminated string literal\n", contador_linhas, col_string);exit(0);}

\/\*                        {BEGIN COMMENT;col_comment = contador_colunas;line_comment =contador_linhas; contador_colunas+=yyleng;}
<COMMENT>\/\*               {contador_colunas+=yyleng;}
<COMMENT>(\r)?\n|(\n)?\r          {contador_colunas=1; contador_linhas++;}
<COMMENT>\*\/               {BEGIN 0; contador_colunas+=yyleng;}
<COMMENT>.                  { contador_colunas+=yyleng;}
<COMMENT><<EOF>>            {printf("Line %d, col %d: unterminated comment\n", line_comment, col_comment);exit(0);}

"\ "                        {contador_colunas++;}
\014                        {contador_colunas++;}

.                           {printf("Line %d, col %d: illegal character(%s)\n", contador_linhas, contador_colunas,yytext);escape = 0;contador_colunas+=yyleng;}  

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

int yywrap() {
    return 1;
}