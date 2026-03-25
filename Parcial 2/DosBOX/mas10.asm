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

    ; convertir a numero
    lea si, buffer + 2   ;si apunta al inicio de la cadena
    mov cl, [buffer + 1] 
    xor ch, ch          ;cx formateado con el numero de caracteres
    
    mov ax, 0            
    mov bx, 10          

    convertir:
    mov dx, 0            
    mul bx              
    
    mov dl, [si]  
    ;verificacion de si es digito  
    ;vereficacion por indice si es '.' inc si je convertir     
    sub dl, '0'  ;ascii a numero     
    xor dh, dh   ;formateo el registro dx      
    add ax, dx           
    
    inc si
    loop convertir

    add ax, 10           
    mov numero, ax

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