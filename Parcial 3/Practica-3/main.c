#include <stdio.h>
#include <stdlib.h>

int longitud_cadena(char* texto);
int contar_vocales(char* texto);
int contar_espacio(char* texto);
void a_mayusculas(char* origen, char* destino);
void invertir(char* origen, char* destino);

int main(){
    char texto[200];

    //buffer axuiliares para nasm para la info
    char mayusculas[200];
    char invertida[200];

    int longitud, vocales, espacios;

    printf("Escribe una frase: ");
    fgets(texto, sizeof(texto), stdin);

    int i = 0;
    while (texto[i] != '\0')
    {
        if(texto[i] == '\n'){
            texto[i] = '\0'; 
            break;
        }
        i++;
    }

    longitud = longitud_cadena(texto);
    vocales = contar_vocales(texto);
    espacios = contar_espacio(texto);
    a_mayusculas(texto, mayusculas);
    invertir(texto, invertida); 
    


    system("pause");
    return 0;
}