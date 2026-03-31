;Practica Final sobre buffer 
;e interrupciones de video
.model small
.stack 100h
.data

; buffer db 30
;         db 0
;         db 30 dup(0)

;buffer db 30,0,30 dup(0)

bufferNombre db 30
contNombre db 0
cadNombre db 30 dup(0)

nombreLimpio db 31 dup('$')

titulo db '****Practica Final: Cadenas y video ****$'
msgPedir db 'Escribe tu nombre: $'
msgMostrar db 'Tu nombre fue: $'
msgLimpio db 'El buffer original fue limpiado $'
msgRepetir db 'Otra vez (S/N): $' 
.code
main:
    ;Priemro cargar el ds 
    mov ax, @data
    mov ds, ax

    inicio_programa:
    ;limpiar la pantalla
    call LimpiarPantalla

    ;Posicionar el cursor y mostrar titulo
    mov dh, 1
    mov dl, 15
    call PosicionarCursor  

    lea si, titulo
    mov bl, 1Eh  ;atributo de color
    call ImprimirColor 

    ;mostrar mensaje para pedir nombre

    mov ah, 09h
    lea dx, msgPedir
    int 21h

    ;leer la cadena para guardar el nombre 

    mov ah, 0Ah
    lea dx, bufferNombre
    int 21h

    ;copiar la cadena a otra variable

    call CopiarCadena

    ;limpiar el buffer

    call LimpiarBuffer

    ;mostrar mensaje capturado

    mov dh, 8
    mov dl, 10
    call PosicionarCursor

    mov ah, 09h
    lea dx, msgMostrar
    int 21h

    mov ah, 09h
    lea dx, nombreLimpio
    int 21h

    ;mensaje que dice que ya se limpio el buffer
    mov dh, 10
    mov dl, 10
    call PosicionarCursor

    mov ah, 09h
    lea dx, msgLimpio
    int 21h

    ;preguntar si otra vez
    mov dh, 13
    mov dl, 10
    call PosicionarCursor

    mov ah, 09h
    lea dx, msgRepetir
    int 21h

    mov ah, 01h
    int 21h

    cmp al, 's'
    je repetir
    cmp al, 'S'
    je repetir 

    ;fin del programa
    mov ah, 4Ch
    int 21h

    repetir:
    call LimpiarDestino
    jmp inicio_programa
end main