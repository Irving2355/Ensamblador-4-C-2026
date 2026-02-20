.model small

.stack 100h

.data

M    dw 65521
A    dw 75
seed dw 1234 ;semilla menor a M mayor a A 

rand1 db 0
rand2 db 0

MINVAL db 10
MAXVAL db 20 

.code
 
NextLehmer16:
    mov ax, seed
    mul A   ;DX:AX = AX * A 
    div M   ;DX residuo
    mov seed, dx
    ret
    
main:  

    mov ax, @data
    mov ds, ax
    
    call NextLehmer16
    mov al, dl
    mov rand1, al  
    
    ;segundo aleatorio acotado 
    ; vm + rand()%(VM-vm+1)
    mov al, MAXVAL
    sub al, MINVAL
    inc al
    mov bl, al ;(VM-vm+1)
    
    call NextLehmer16 ;rand()
    mov al, dl
    
    xor ah, ah
    div bl  ;ah residuo rand % width  
    ;rand()%(VM-vm+1) = ah
    
    mov al, ah
    add al, MINVAL ;sumo el minimo
    mov rand2, al
    
    mov dx, 0
    mov dx, offset rand1

end main