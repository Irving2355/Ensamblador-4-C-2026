;punto fijo x100
.model small

.stack 100h

.data 

;datos de entrada

A_int  db 12
A_frac db 50

B_int  db 3
B_frac db 75

;datos internos x100
A_x100 dw 0
B_x100 dw 0

;resultados x100
S_x100 dw 0 ;A+B
R_x100 dw 0 ;A-B

;dd define dobleword

P_x100 dd 0 ;(A_x100 * B_x100)/100

D_x100 dw 0 ;(A_x100 * 100)/B_x100

;******* resultados desempaquetados

S_int db 0
S_frac db 0

R_int db 0
R_frac db 0

P_int db 0
P_frac db 0

D_int db 0
D_frac db 0

errDiv0 db 0 

.code

pack_x100 proc
    ;al entero, frac en dx
    push bx
    push dx
    
    mov bl, al  ;bl = entero
    xor bh, bh  ;bx H:00 L: entero
    mov ax, bx  ;ax = entero
    
    mov bx, 100
    mul bx   ;entero*100 caber en AX si entero<=655
        
    pop dx
    ;sumamos la fraccion original 
    
    xor dh, dh
    add ax, dx ;ax H:entero L:sumamos el dx es frac
    
    pop bx
    ret
pack_x100 endp

main:

    mov ax, @data
    mov ds, ax
    
    ;empaquetar A
    mov al, A_int
    mov dl, A_frac
    call pack_x100
    mov A_x100, ax

end main