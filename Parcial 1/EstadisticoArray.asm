.model small

.stack 100h

.data 

N       db 10
notas   db 90,75,100,64,88,92,71,85,79,95

outSum dw 0
outAvg db 0
outMax db 0

.code
main:

    mov ax, @data  ;ax 0720
    mov ds, ax     ;ds 0720
    
    xor ax, ax     ;ax 0000
    mov outSum, ax ;ax 0000
    
    mov al, notas[0] ;ax H:00 L:90dec
    mov outMax, al  ;outMax=90dec
    
    ;Preparamos recorrido
    
    xor si, si  ;int i=0
    mov cl, N   ;int contador = N
    xor ch, ch ;CX H:00 L:0A
    
L1:
    mov al, notas[si] ;al=notas[i]
    mov ah, 0   ;ax H:00 L:90dec
    add outSum, ax ;outSum += ax
    
    ;if(notas[i] > outMax) outMax = notas[i] 
    mov bl, outMax
    cmp al, bl
    jbe NoMax
    mov outMax, al
    
NoMax:

    inc si   ;i++
    loop L1  ;while(vuelta actual <= cx)
    
    mov ax, outSum
    mov bl, N
    div bl   ;AX/BL  -> AL cociente
    mov outAvg, al   ;ax H:03 L:89   0389
    

end main