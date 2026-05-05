#include <stdio.h>
#include <stdlib.h>

int suma(const int* arr, int n);

int main(){
    int datos[] = {1,2,3,4,5,6,7,8,9};

    int n = sizeof(datos) / sizeof(datos[0]);

    printf("Elementos del arreglo: ");
    for(int i=0; i<n; i++){
        printf("%d ", datos[i]);
    }

    int resultado = suma(datos,n);

    printf("\nResultado: %d\n", resultado);
    //system("pause");
    return 0;
}