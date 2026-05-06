#include <stdio.h>

long long suma(const int* arr, int n);
int contar_pares(const int* arr, int n);
int obtener_max(const int* arr, int n);

void imprimir(const int* arr, int n){
    int i;
    printf("Arreglo: ");
    for(i=0; i<n; i++){
        printf("%d", arr[i]);
        if(i < n-1){
            printf(", ");
        }
    }
    printf("\n");
}

int main(){
    return 0;
}