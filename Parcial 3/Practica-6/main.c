#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

#define FILAS 8
#define COLUMNAS 8

void intercambiar(
    int *matriz,
    int columnas,
    int fila1,
    int columna1,
    int fila2,
    int columna2
);

void imprimir(int martriz[FILAS][COLUMNAS]){

}

void iniciar_matriz(int matriz[FILAS][COLUMNAS]){
    for(int i=0; i<FILAS; i++){
        for(int j=0; j<COLUMNAS; j++){
            matriz[i][j]= i * 10 + j; 
        }
    }
}

int posicion_valida(int fila, int columnas){
    if(fila < 0 || fila >= FILAS){
        return 0;
    }

    if(columnas < 0 || columnas >= COLUMNAS){
        return 0;
    }

    return 1;
}

int main(){
    int matriz[FILAS][COLUMNAS];

    int fila1, columna1, fila2, columna2;
    char direccion, continuar;

    iniciar_matriz(matriz);

    do
    {
        system("cls");

        imprimir(matriz);

        printf("\nDame una posicion: \n");
        printf("Fila: ");
        scanf("%d", &fila1);
        printf("Columna: ");
        scanf("%d", &columna1);
        printf("\nSeleccione una direccion WASD\n");
        scanf("%c", &direccion);

        direccion = tolower(direccion);

        fila2 = fila1;
        columna2 = columna1;

        if(direccion == 'w'){
            fila2--;
        }else if(direccion == 's'){
            fila2++;
        }else if(direccion == 'a'){
            columna2--;
        }else if(direccion == 'd'){
            columna2++;
        }else{
            printf("movimiento invalido");
            continue;
        }

        if(!posicion_valida(fila2, columna2)){
            printf("\nDireccion invalida...\n");
            printf("Presione Enter para continuar...");
            getchar();
            getchar();
            continue;
        }
    } while (condition);
    

    system("pause");
    return 0;
}