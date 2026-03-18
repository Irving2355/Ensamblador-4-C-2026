;servicios 01h y 02h 
.model small
.stack 100h
.data
msg1 db 13,10,'Presiona una tecla: $'
msg2 db 13,10,'La tecla capturada fue: $'
msg3 db 13,10,'hola',13,10,'adios','$'
;("\n+hola+\n+adios\0")
car db ? 
.code
main:
    mov ax, @data
    mov ds, ax

    ;pedir la tecla
    mov ah, 09h
    lea dx, msg1
    int 21h

    ;leer caracter
    mov ah, 01h
    int 21h
    mov car, al 

    ;mostrar mensaje
    mov ah, 09h
    lea dx, msg2
    int 21h

    ;mostrar caracter
    mov dl, car 
    mov ah, 02h
    int 21h

    mov ah, 4Ch ;mov ax, 4C00h 
    int 21h
end main