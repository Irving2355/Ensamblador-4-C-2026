#include <stdio.h>
#include <stdlib.h>

typedef struct
{
    char nombre[32];
    int edad;
    int calificacion;
} Alumno; //tamaño aproximado de 40 bytes

int contar_aprobados(Alumno* alumnos, int n, int calificacion);
int mejor_indice(Alumno* alumnos, int n);
void subir_puntos(Alumno* alumnos, int n, int puntos);

void imprimir(Alumno* alumnos, int n){
    printf("%-15s %-8s %-12s", "Nombre", "Edad", "Calificacion");
    for(int i=0; i<n; i++){
        printf(
            "%-15s %-8d %-12d",
            alumnos[i].nombre,
            alumnos[i].edad,
            alumnos[i].calificacion
        );
    }
    printf("\n\n");
}


int main(){

    Alumno grupo[]={
        {"Ana 1", 20, 85},
        {"Ana 2", 21, 90},
        {"Ana 3", 19, 20},
        {"Ana 4", 21, 55},
        {"Ana 5", 22, 68},
        {"Ana 6", 20, 82},
        {"Ana 7", 19, 99}
    };

    int n = sizeof(grupo) / sizeof(grupo[0]);
    int aprobados, indice_mejor;

    printf("Grupo original: \n");
    imprimir(grupo,n);

    aprobados = contar_aprobados(grupo,n,65);
    indice_mejor = mejor_indice(grupo,n);

    printf("Resultados: \n");
    printf("Alumnos aprobados: %d", aprobados);

    if(indice_mejor >=0){
        printf("Mejor alumno: %s\n",grupo[indice_mejor].nombre);
        printf("Calificacion: %d\n",grupo[indice_mejor].calificacion);
    }

    printf("Subir puntos\n");
    subir_puntos(grupo,n,1);

    printf("Grupo actualizado\n");
    imprimir(grupo,n);

    system("pause");
    return 0;
}