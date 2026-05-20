bits 64
default rel 

global generar_pixel_art

section .text

generar_pixel_art:
    cmp r8d, 0
    jle .salida_vacia
    cmp r9d, 0
    jle .salida_vacia

    mov r10d, r8d
    .fila_loop:
    mov r11d, r9d
    .columna_loop:
    mov eax, [rcx]

    cmp eax, 0
    je .valor_0
    cmp eax, 1
    je .valor_1
    cmp eax, 2
    je .valor_2
    cmp eax, 3
    je .valor_3

    mov al, 219
    jmp .escribir

    .valor_0:
    mov al, 32
    jmp .escribir
    .valor_1:
    mov al, 176
    jmp .escribir
    .valor_2:
    mov al, 177
    jmp .escribir
    .valor_3:
    mov al, 178
    
    .escribir:
    mov [rdx], al 
    mov [rdx + 1], al 

    ;avanzar en matriz y vector
    add rdx, 2
    add rcx, 4

    dec r11d
    jnz .columna_loop

    mov byte [rdx], 10
    inc rdx 

    dec r10d
    jnz .fila_loop

    mov byte [rdx], 0
    ret 

    .salida_vacia:
    mov byte [rdx], 0
    ret     