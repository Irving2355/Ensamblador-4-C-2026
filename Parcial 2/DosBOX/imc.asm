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
seenDot db 0

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
    mov word ptr intPart, 0
    mov word ptr fracPart, 0
    mov word ptr fracDiv, 1
    mov byte ptr seenDot, 0 

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

    setDot:
    mov seenDot, 1
    jmp NextChar

    IgnoreChar:
    ;ignora espacios letras o otros simbolos
    nop

    NextChar:
    inc si
    dec cx 
    jmp ParseLoop

    ConveretToReal:
    fild intPart 

    cmp fracDiv, 1
    je SaveNumber

    fild fracPart
    fidiv fracDiv
    fadd 
    SaveNumber:
    fstp numParsed
    ret
ParseBufferToReal endp


PrintAX proc
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
        ret
PrintAX endp

Print2Digits proc
    push bx
    push dx

    xor dx, dx
    mov bx, 10
    div bx  

    mov bl, al
    mov bh, dl 

    mov dl, bl
    add dl, '0'
    mov ah, 02h
    int 21h

    mov dl, bh
    add dl, '0'
    mov ah, 02h
    int 21h

    pop dx
    pop bx
    ret
Print2Digits endp

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

    fld numParsed
    fstp peso

    ;pedir altura
    mov ah, 09h
    lea dx, msgAlt
    int 21h

    mov ah, 0Ah
    lea dx, bufferAlt
    int 21h

    lea si, bufferAlt
    call ParseBufferToReal

    fld numParsed
    fstp altura

    ;calculo de imc
    fld altura
    fmul altura
    fstp altura2
    
    fld peso
    fdiv altura2
    fstp imc 

    ;mostrar el resultado
    mov ah, 09h
    lea dx, msgRes
    int 21h

    ;convertir el imc escalado a 100
    ;28.88 -> 2888
    fld imc 
    fimul cien 
    fistp imc100 

    xor ax, ax 
    mov ax, imc100 
    xor dx, dx
    mov bx, 100
    div bx

    call PrintAX

    mov dl, '.'
    mov ah, 02h
    int 21h

    mov ax, dx 
    call Print2Digits

    mov ah, 4Ch
    int 21h
end main