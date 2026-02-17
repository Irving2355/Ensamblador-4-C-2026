.model small

.stack 100h

.data  

celsius db 25

outFahr dw 0

.code
main: 

    ;mov ax, SEG celsius
    mov ax, @data
    mov ds, ax
    
    ;F = (c*9)/5 + 32
    mov al, celsius
    mov bl, 9
    mul bl  ; ax= al*bl
    
    mov bl, 5
    div bl  ; al = (c*9)/5, ah=residuo
    
    mov ah, 0 ;ax= 03 FF  00 FF
    add ax, 32 
    
    mov outFahr, ax
    
    int 3

end main