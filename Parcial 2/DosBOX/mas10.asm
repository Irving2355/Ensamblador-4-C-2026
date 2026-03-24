;programa que pide numero y le suma 10
.model small
.stack 100h
.data
msg1 db 13,10,'Ingresa un numero: $'
msg2 db 13,10,'Resultado + 10: $'

buffer db 20
        db 0
        db dup('$')

numero dw 0
.code
main:
    mov ax, @data 
    mov ds, ax

    ;pedir numero
    mov ah, 09h
    lea dx, msg1
    int 21h

    mov ah, 0Ah
    lea dx, buffer
    int 21h

    ;convertir texto a numero
    mov si, offset buffer 
    mov cl, [si + 1]
    xor ch, ch 

    add si, 2 ;apuntar al inicio de numero
    ;si el inicio y el cx el final
    mov numero, 0

    convertir:
    cmp cx, 0
    je listo

    mov al, [si] 
    ;validar que sea digito
    cmp al, '0'
    jb siguiente
    cmp al, '9'
    ja siguiente

    sub al, '0' ;convertir ascii a numero

    ;numero = numero *10 + digito 
    mov bx, numero
    mov ax, bx
    mov dx, 0
    mov bx, 10
    mul bx
    add ax, al
    mov numero, ax

    siguiente:
    inc si 
    dec cx
    jmp convertir

    listo:
    add numero, 10

    mov ah, 09h
    lea dx, msg2
    int 21h

    mov ax, numero
    call PrintAX

    mov ah, 4Ch
    int 21h

    PrintAX proc
        push ax
        push bx
        push cx
        push dx 

        cmp ax,0
        jne convertirNumero

        mov dl, '0'
        mov ah, 02h
        int 21h
        jmp finPrint

        convertirNumero:
        mov bx, 10
        xor cx, cx

        ciclo1:
        xor dx, dx
        div bx
        push dx
        inc cx
        cmp ax, 0
        jne ciclo1

        ciclo2:
        pop dx
        add dl, '0'
        mov ah, 02h
        int 21h
        loop ciclo2

        finPrint:
        pop dx
        pop cx
        pop bx
        pop ax
        ret
    PrintAX endp
end main