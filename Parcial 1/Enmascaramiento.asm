; Permisos para un registro de control
; bit0 LED    bit1 MOTOR
; bit2 ALARMA bit3 MODO_SEGURO 

.model small

.stack 100h

.data 
;tranformar binarios a hexa
regCtrl db 03h;00000011b

MASK_LED    equ 01h;00000001  ;equ es una cosntante
MASK_MOTOR  equ 02h;00000010  ;simbolica
MASK_ALARM  equ 04h;00000100
MASK_SAFE   equ 08h;00001000

outAfterOr  db 0
outAfterAnd db 0
outSafeIsOn db 0 ;1 si es modo seguro

.code
main:   

    mov ax, @data
    mov ds, ax
    
    ;encender led y alarma 
    ;OR enciende bits
    mov al, regCtrl 
    or  al, (MASK_LED + MASK_ALARM) ;no se permite or en las mascaras 
    mov outAfterOr, al
    
    ;apagar motor
    ;usamos and para apagar bits
    mov al, outAfterOr     ;00000011
    mov bl, MASK_MOTOR
    not bl
    and al, bl             ;11111101
                           ;00000001
    mov outAfterAnd, al
    
    ;modo seguro
    ;TEST no cambia al, cambia banderas
    mov al, outAfterAnd
    test al, MASK_SAFE 
    jz SafeOff
SafeOn:
    mov outSafeIsOn, 1
    jmp Done
SafeOff:
    mov outSafeIsOn, 0
Done:
    int 3   

end main