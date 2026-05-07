bits 64
default rel 

global longitud_cadena, contar_vocales, contar_espacio
global a_mayusculas, invertir

section .text 

longitud_cadena:
    xor eax, eax

    .loop_len:
    mov dl, [rcx + rax]
    cmp dl, 0
    je .fin_len
    inc eax
    jmp .loop_len
    .fin_len:
    ret 

contar_vocales:
    xor eax, eax

    .loop_voc:
    mov r10b, [rcx]
    cmp r10b, 0
    je .fin_voc

    ;convertir a minusculas 
    or r10b, 32 

    cmp r10b, 'a'
    je .es_vocal
    cmp r10b, 'e'
    je .es_vocal
    cmp r10b, 'i'
    je .es_vocal
    cmp r10b, 'o'
    je .es_vocal
    cmp r10b, 'u'
    je .es_vocal

    .no_es:
    inc rcx
    jmp .loop_voc

    .es_vocal:
    inc eax
    inc rcx
    jmp .loop_voc

    .fin_voc:
    ret 

contar_espacio:
    xor eax, eax

    .loop_esp:
    mov dl, [rcx]
    cmp dl, 0
    je .fin_esp

    cmp dl, ' '
    je .espacio
    inc rcx
    jmp .loop_esp

    .espacio:
    inc eax
    inc rcx
    jmp .loop_esp

    .fin_esp:
    ret 

a_mayusculas:
    .loop_mayo:
    mov r8b, [rcx]
    cmp r8b, 0
    je .fin_mayo

    cmp r8b, 'a'
    jb .copiar_char
    cmp r8b, 'z'
    ja .copiar_char
    sub r8b, 32

    .copiar_char:
    mov [rdx], r8b
    inc rcx
    inc rdx
    jmp .loop_mayo

    .fin_mayo:
    mov byte [rdx], 0
    ret

invertir:
    mov r8, rcx  ;vector original
    mov r9, rdx  ;vector destino a donde lo voy a invertir

    xor eax, eax

    .loop_inv:
    cmp byte [r8 + rax], 0
    je .loop_inv2
    inc eax
    jmp .loop_inv

    .loop_inv2:
    test eax, eax
    jz .cadena_vacia

    ;nos ponemos al final del primer vector
    lea r10, [r8 + rax - 1]
    mov r11d, eax

    .loop_invertir:
    mov cl, [r10]
    mov [r9], cl
    inc r9
    dec r10 
    dec r11d
    jnz .loop_invertir

    mov byte [r9], 0
    ret 

    .cadena_vacia:
    mov byte [r9], 0
    ret 