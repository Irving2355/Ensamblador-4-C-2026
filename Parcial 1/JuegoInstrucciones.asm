.model small

.stack 100h

.data 

ARR DB 10,20,30,40 
MSG DB "HOLA MUNDO","$"

.code

main:  

    MOV AX, @data
    MOV DS, AX

    ;XCHG EXCHANGE INTERCAMBIA
    MOV AX, 5
    MOV BX, 9
    XCHG AX, BX 
    
    ;LEA LOAD EFFECTIVE ADDRESS "CARGA DIRECCION"
    ;LEA NO CARGA MEMORIA SOLO CALCULA OFFSETS
    LEA SI, ARR
    MOV AL, ARR
    
    LEA DX, MSG
    
    ;************   ALU ***************
    ;ADD SUMAR
    ;SUB SUBRTRACT = RESTA
    
    ;SIMPRE LIMPIA EL REGISTRO
    MOV AX,0
    
    MOV AL, 10
    ADD AL, 5
    
    MOV AL, 10
    SUB AL, 10 ; AL = 00h Y ZF=1
    
    ;INC = INCREMENTO
    ;DEC = DECREMENTO
    
    MOV CX, 0
    INC CX
    DEC CX
    
    ;INC Y DEC NO ACTIVAN LA CF
    
    ;************** LOGICA  *************** 
    
    MOV AL, 0Fh   ;00001111
    AND AL, 03h   ;00000011 
                  ;SOLO QUEDAN LOS 2 BITS BAJOS
    
    ;XOR CAMBIO/TOGGLE
    MOV AL, 55h
    XOR AL, 0FFh ;INVIERETE LOS BITS EN ESTE CASO
    
    MOV AL, 99h
    XOR AL, AL ; AL = 0 
    
    MOV AL, 55h
    NOT AL ; AL = AA

END main