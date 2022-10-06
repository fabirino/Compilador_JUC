%{
    int contador_linhas = 1;
    int contador_colunas = 1;
%}

carateres               ([a-z]|[A-z]|"_"|"$")([a-z]|[A-z]|"_"|"$"|[0-9])*
naturais                [1-9]
inteiros                [0-9]

%%


" "                           {contador_colunas++;}       
"\r\n"                        {contador_colunas=1; contador_linhas++;}      
"true"|"false"                {printf("BOOLIT\n");contador_colunas+=yyleng;}
"&&"                          {printf("END\n");contador_colunas+=yyleng;}
"="                           {printf("ASSIGN\n");contador_colunas+=yyleng;}
"*"                           {printf("STAR\n");contador_colunas+=yyleng;}
","                           {printf("COMMA\n");contador_colunas+=yyleng;}
"/"                           {printf("DIV\n");contador_colunas+=yyleng;}
"=="                          {printf("EQ\n");contador_colunas+=yyleng;}
">="                          {printf("GE\n");contador_colunas+=yyleng;}
">"                           {printf("GT\n");contador_colunas+=yyleng;}
"{"                           {printf("LBRACE\n");contador_colunas+=yyleng;}
"<="                          {printf("LE\n");contador_colunas+=yyleng;}
"("                           {printf("LPAR\n");contador_colunas+=yyleng;}
"["                           {printf("LSQ\n");contador_colunas+=yyleng;}
"<"                           {printf("LT\n");contador_colunas+=yyleng;}
"-"                           {printf("MINUS\n");contador_colunas+=yyleng;}
"%"                           {printf("MOD\n");contador_colunas+=yyleng;}
"!="                          {printf("NE\n");contador_colunas+=yyleng;}
"!"                           {printf("NOT\n");contador_colunas+=yyleng;}
"||"                          {printf("OR\n");contador_colunas+=yyleng;}
"+"                           {printf("PLUS\n");contador_colunas+=yyleng;}
"}"                           {printf("RBRACE\n");contador_colunas+=yyleng;}
")"                           {printf("RPAR\n");contador_colunas+=yyleng;}
"]"                           {printf("RSQ\n");contador_colunas+=yyleng;}
";"                           {printf("SEMICOLON\n");contador_colunas+=yyleng;}
"->"                          {printf("ARROW\n");contador_colunas+=yyleng;}
"<<"                          {printf("LSHIFT\n");contador_colunas+=yyleng;}
">>"                          {printf("RSHIFT\n");contador_colunas+=yyleng;}
"^"                           {printf("XOR\n");contador_colunas+=yyleng;}
"boolean"                     {printf("BOOL\n");contador_colunas+=yyleng;}
"class"                       {printf("CLASS\n");contador_colunas+=yyleng;}
".length"                     {printf("DOTLENGTH\n");contador_colunas+=yyleng;}
"double"                      {printf("DOUBLE\n");contador_colunas+=yyleng;}
"else"                        {printf("ELSE\n");contador_colunas+=yyleng;}
"if"                          {printf("IF\n");contador_colunas+=yyleng;}
"int"                         {printf("INT\n");contador_colunas+=yyleng;}
"System.out.print"            {printf("PRINT\n");contador_colunas+=yyleng;}
"Integer.parseInt"            {printf("PARSEINT\n");contador_colunas+=yyleng;}
"public"                      {printf("PUBLIC\n");contador_colunas+=yyleng;}
"return"                      {printf("RETURN\n");contador_colunas+=yyleng;}
"static"                      {printf("STATIC\n");contador_colunas+=yyleng;}
"String"                      {printf("STRING\n");contador_colunas+=yyleng;}
"void"                        {printf("VOID\n");contador_colunas+=yyleng;}
"while"                        {printf("WHILE\n");contador_colunas+=yyleng;}

{carateres}                    {printf("ID(%s)\n", yytext);contador_colunas+=yyleng;}
"_"|"0"|{naturais}{inteiros}*  {printf("INTLIT\n");contador_colunas+=yyleng;}

"//"

%%

int main() {
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}