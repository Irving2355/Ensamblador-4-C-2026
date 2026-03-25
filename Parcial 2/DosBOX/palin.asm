;deteccion de palindromo
.model small
.stack 100h
.data
msg1 db 13,10,'Escribe una cadena: $'
msgPalindromo   db 13,10,'Es palindromo $'
msgNoPalindromo db 13,10,'No es palindromo $'

buffer db 20
        db 0
        db 20 dup('$')
.code
main:
    mov ax, @data 
    mov ds, ax

    ;pedir palabra
    mov ah, 09h
    lea dx, msg1 
    int 21h

    mov ah, 0Ah
    lea dx, buffer
    int 21h

    ;obtener longitud
    mov si, offset buffer
    mov cl, [si+1]
    xor ch, ch 
    ;cx longitud de la cadena
    ;si apunta al inicio del buffer

    mov di, si 
    add si, 2
    add di, 2 ;si di apuntan al inicio de la cadena
    add di, cx
    dec di   ;si apunta al inicio 
            ; di apunta al final de la cadena
    
    comparar:
    cmp si, di 
    jge esPal

    mov al, [si]
    mov bl, [di]

    cmp al, bl
    jne noPal

    inc si 
    dec di 
    jmp comparar

    esPal:
    mov ah, 09h
    lea dx, msgPalindromo
    int 21h
    jmp final

    noPal:
    mov ah, 09h
    lea dx, msgNoPalindromo
    int 21h

    final:
    mov ah, 4Ch
    int 21h
end main