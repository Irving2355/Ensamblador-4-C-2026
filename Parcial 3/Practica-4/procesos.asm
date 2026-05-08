bits 64
default rel 

global contar_aprobados, mejor_indice, subir_puntos

section .text

%define EDAD_OFFSET          32
%define CALIFICACION_OFFSET  36
%define TAM_ALUMNO           40 