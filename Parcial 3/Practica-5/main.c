#include <stdio.h>
#include <stdlib.h>

#define FILAS 12
#define COLUMNAS 12

#define TAM_SALIDA (FILAS * (COLUMNAS * 2 + 1) + 1)

void generar_pixel_art(int *matriz, char *salida, int filas, int columnas);

int main(){
    int imagen[FILAS][COLUMNAS] = {
        {0,0,1,3,4,4,4,4,3,1,0,0},
        {0,2,4,4,4,4,4,4,4,4,2,0},
        {2,4,4,4,4,4,4,4,4,4,4,2},
        {4,4,4,4,4,4,4,4,4,4,4,4},
        {4,4,4,4,4,4,4,4,4,4,4,4},
        {2,4,4,4,4,4,4,4,4,4,4,2},
        {0,2,4,4,4,4,4,4,4,4,2,0},
        {0,0,2,4,4,4,4,4,4,2,0,0},
        {0,0,0,2,4,4,4,4,2,0,0,0},
        {0,0,0,0,2,4,4,2,0,0,0,0},
        {0,0,0,0,0,2,2,0,0,0,0,0},
        {0,0,0,0,0,0,0,0,0,0,0,0}
    };

    char salida[TAM_SALIDA];

    system("chcp 437 > nul");
    system("color 0C");

    generar_pixel_art(&imagen[0][0], salida, FILAS, COLUMNAS);

    printf("%s", salida);
    system("pause");
    return 0;
}