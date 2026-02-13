.model small

.stack 100h

.data 

pin_guardado    db 23 ;pin correcto
pin_ingresado   db 24 
acceso          db 0  ;1 = acceso permitido

.code

main: 

    mov ax, @data
    mov ds, ax
    
    mov al, pin_ingresado
    
    cmp al, pin_guardado  ;zf=1
    
    je pin_ok 
    
    pin_mal:
        mov acceso, 0
        jmp fin
    
    pin_ok:
        mov acceso, 1
    
    fin:
        mov ah, 4Ch
        int 21h
end main