bits 64
default rel 

global contar_aprobados, mejor_indice, subir_puntos

section .text

%define EDAD_OFFSET          32
%define CALIFICACION_OFFSET  36
%define TAM_ALUMNO           40 

contar_aprobados:
    xor eax, eax

    cmp edx, 0
    jle .fin_contar
    .loop_contar:
    mov r10d, [rcx + CALIFICACION_OFFSET]

    cmp r10d, r8d
    jl .no_aprobo

    inc eax

    .no_aprobo:
    add rcx, TAM_ALUMNO
    dec edx
    jnz .loop_contar
    .fin_contar:
    ret 

mejor_indice:
    cmp edx, 0
    jg .hay_alumnos

    mov eax, -1
    ret 
    .hay_alumnos:
    mov r10d, [rcx + CALIFICACION_OFFSET]

    xor eax, eax
    mov r9d, 1
    
    add rcx, TAM_ALUMNO
    dec edx
    jz .fin_mejor

    .loop_mejor:
    mov r11d, [rcx + CALIFICACION_OFFSET]

    cmp r11d, r10d
    jle .no_es_mejor

    mov r10d, r11d
    mov eax, r9d

    .no_es_mejor:
    add rcx, TAM_ALUMNO
    inc r9d
    dec edx
    jnz .loop_mejor

    .fin_mejor:
    ret 

subir_puntos:
    cmp edx, 0
    jle .fin_subir

    .loop_subir:
    mov eax, [rcx + CALIFICACION_OFFSET]

    add eax, r8d

    cmp eax, 100
    jle .guardar

    mov eax, 100

    .guardar
    mov [rcx + CALIFICACION_OFFSET], eax

    add rcx, TAM_ALUMNO
    dec edx
    jnz .loop_subir
    .fin_subir:
    ret 