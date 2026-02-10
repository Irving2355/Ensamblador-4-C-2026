.model small

.stack 100h

.data 

a db 11h
b db 22h

.code

main:

    MOV AX, @data
    MOV DS, AX
    
    MOV ES, AX ; ES = DS
    
    MOV DI, offset b
    
    ;ACCESO FAR A DATOS ES:DI
    MOV AL, ES:[DI] ;AL = CONTENIDO DE 'b' (22h) 
    ;AQUI USA ES
    
    MOV BL, b ;AQUI USA DS
    
    ;AL = BL = 22h 
    
    MOV AH, 4Ch
    INT 21H
END main