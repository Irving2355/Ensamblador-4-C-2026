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

LimpiarPantalla proc
    ;int 10h y ah = 06h
    ;limpiar la ventana
    ;si al = 00h se limpia toda la area
    mov ah, 06h
    mov al, 00h
    mov bh, 07h
    mov ch, 00h
    mov cl, 00h
    mov dh, 24h
    mov dl, 79h
    int 10h

    mov dh, 0
    mov dl, 0
    call PosicionarCursor
    ret
LimpiarPantalla endp

PosicionarCursor proc
    ;dh = fila
    ;dl = columna
    ;int 10h y ah = 02h posiciona
    mov ah, 02h
    mov bh, 00h
    int 10h
    ret 
PosicionarCursor endp

ImprimirColor proc 
    siguiente_caracter:
    lodsb ;al = [si] si avanza automaticamente
    cmp al, '$'
    je fin_imprimir_color

    ;imprimir un caracter con atributo
    mov ah, 09h
    mov bh, 00h
    mov cx, 1
    int 10h

    ;avanza visualmente el cursor
    mov ah, 0Eh
    mov bh, 00h 
    int 10h

    jmp siguiente_caracter

    fin_imprimir_color:
    ret 
ImprimirColor endp 

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