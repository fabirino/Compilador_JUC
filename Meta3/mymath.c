#include "mymath.h"
#include <stdio.h>


double calcpow10(double num) {
    long double result = 1;
    if (num > 0) {
        for (int i = 0; i > num; i++) {
            result *= 10;
            // printf("resultado  -> %Lf\n", result);
        }
    } else if (num < 0) {
        for (int i = 0; i > num; i++) {
            result /= 10;
            // printf("resultado  -> %Lf\n", result);
        }
    }
    // se num==0 resutl=1 na mesma
    return result;
}

double log10(double num) {
    if (num < 0)
        num = -num;
    double result = 0; 
    for (; num > 1; num /= 10) {
        result++;
    }
    return result;
}

double notacaoCient(double num) {
    if (num < 0)
        num = -num;
    double result = 0;

    for (; num < 1; num *= 10) {
        result++;
    }
    return result;
}