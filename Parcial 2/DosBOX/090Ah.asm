;servicios 09h y 0Ah 
.model small
.stack 100h
.data
msg1 db 13,10,'Escribe tu nombre: $'
msg2 db 13,10,'Hola $'

bufferNombre  db 20    ;maximo de caracteres
              db 0     ;cuantos caracteres se han capturado
              db 20 dup('$')  ;$$$$$$$Juan$

.code
main:
    mov ax, @data 
    mov ds, ax

    ;pedir nombre
    mov ah, 09h
    lea dx, msg1
    int 21h

    ;leer nombre con el buffer
    mov ah, 0Ah
    lea dx, bufferNombre
    int 21h

    ;convertir el final en '$'
    ;cantidad del buffer+1
    mov si, offset bufferNombre
    mov cl, [si+1]
    xor ch, ch 

    ;en buffer+2 empieza el texto
    add si, 2
    add si, cx
    mov byte ptr [si], '$'

    ;mostrar saludo
    mov ah, 09h
    lea dx, msg2
    int 21h

    ;mostrar el nombre
    mov ah, 09h
    lea dx, bufferNombre+2
    int 21h

    mov ah, 4Ch
    int 21h
end main