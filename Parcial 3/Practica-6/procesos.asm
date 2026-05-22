bits 64
default rel 

global intercambiar

;parametros 5 y 6
;[rsp + 40] fila2
;[rsp + 48] columna2

section .text 

intercambiar:
    ;calcular el indice = fila1 * columnas + columna1
    mov eax, r8d
    imul eax, edx
    add eax, r9d

    ;convertir indice a desplazamiento en memoria
    movsxd rax, eax
    lea r10, [rcx + rax * 4]

    ;segundo indice
    mov r11d, [rsp + 40] ;fila2
    mov eax, r11d
    imul eax, edx
    mov r11d, [rsp + 48] ;columna2
    add eax, r11d

    movsxd rax, eax
    lea r11, [rcx + rax * 4] 
    ;r10 matriz[fila1][columna1]
    ;r11 matriz[fila2][columna2]

    ;intercambio
    mov eax, [r10]
    mov r8d, [r11]

    mov [r10], r8d
    mov [r11], eax
    ret 
