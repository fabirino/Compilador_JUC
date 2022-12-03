`Meta1`
lex jucompiler.l
clang-14 -o jucompiler lex.yy.c
./jucompiler -l < Factorial.java > Factorial.out
./jucompiler < Factorial.java
diff ficheiro1 ficheiro2
./Comp2022.git/test.sh jucompiler.l

`Meta2`

- lex jucompiler.l
- yacc -y -d -t -v jucompiler.y
- clang-14 -o jucompiler y.tab.c lex.yy.c STree.c

`lex jucompiler.l && yacc -y -d -t -v jucompiler.y && clang-14 -o jucompiler y.tab.c lex.yy.c STree.c`

- ./jucompiler -t <../Comp2022.git/meta2/simples.java >teste.out

`Meta3`

- lex jucompiler.l
- yacc -y -d -t -v jucompiler.y
- clang-14 -o jucompiler y.tab.c lex.yy.c STree.c symtab.c

`lex jucompiler.l && yacc -y -d -t -v jucompiler.y && clang-14 -o jucompiler y.tab.c lex.yy.c STree.c symtab.c mymath.c`

- ./jucompiler -s <../Comp2022.git/meta3/FieldDecErrors.java >teste.out