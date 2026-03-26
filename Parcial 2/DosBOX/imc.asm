;calcular el imc 
.model small
.stack 100h
.data
msgPeso db 13,10,'Ingresa tu peso (78.4 o 70): $'
msgAlt db 13,10,'Ingresa tu altura (1.65): $'
msgRes db 13,10,'IMC = $'
msgFin db 13,10,'$'

bufferPeso db 20
            db 0
            db 20 dup(0)

bufferAlt db 20
            db 0
            db 20 dup(0)

intPart dw 0
fracPart dw 0
fracDiv dw 1
digit dw 0
seenDot dw 0

numParsed dd 0.0
peso dd 0.0
altura dd 0.0
altura2 dd 0.0
imc dd 0.0

cien dw 100
imc100 dw 0
.code

ParseBufferToReal proc
    ;reiniciar varaibles

    mov cl, [si+1]
    xor ch, ch 
    add si, 2

    ParseLoop:
    cmp cx, 0
    je ConveretToReal
    mov al, [si]
    ;detectar punto decimal
    cmp al, '.'
    je setDot
    cmp al, '0'
    jb IgnoreChar
    cmp al, '9'
    jg IgnoreChar

    sub al, '0'
    xor ah, ah
    mov digit, ax

    cmp seenDot, 0
    jne FracDigit

    mov ax, intPart
    mov bx, 10
    mul bx
    add ax, digit
    mov intPart, ax
    jmp NextChar

    FracDigit:
    mov ax, fracPart
    mov bx, 10
    mul bx
    add ax, digit
    mov fracPart, ax
    
    mov ax, fracDiv
    mov bx, 10
    mul bx
    mov fracDiv, ax
    jmp NextChar 


    ret
ParseBufferToReal endp

main:
    mov ax, @data 
    mov ds, ax

    ;pedir peso
    mov ah, 09h
    lea dx, msgPeso
    int 21h

    mov ah, 0Ah
    lea dx, bufferPeso
    int 21h

    lea si, bufferPeso
    call ParseBufferToReal

    ;pedir altura
    mov ah, 09h
    lea dx, msgAlt
    int 21h

    mov ah, 0Ah
    lea dx, bufferAlt
    int 21h

    lea si, bufferAlt
    call ParseBufferToReal

end main