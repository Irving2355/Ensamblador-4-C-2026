.model small

.stack 100h

.data
num1 db 5
num2 db 3
arr  db 10,20,30,40 
resultado db 0

.code
main: 
    MOV AX, @data
    MOV DS,AX
    
    ;DIRECCIONAMIENTO INMEDIATO
    MOV AL,2
    
    ;REGISTRO
    MOV BL,AL
    
    ;DIRECTO A MEMORIA POR ETIQUETA
    MOV AL,num1
    
    ;INDIRECTO POR REGISTRO (PUNTERO)
    MOV SI, offset num2  ;si = direccion de num2
    add AL, [si]         ; al = al + num2  (al= 5 [si]= 3 ) 
    
    ;INDEXADO CON SI SOBRE ARRAY
    MOV SI,1
    ADD AL,arr[si]  ;AL = 8 + arr[i] = 20 = 28
    
    ;BASE + INDICE
    MOV BX, offset arr   ;base = arr
    MOV SI, 2            ;indice = 2
    ADD AL, [bx+si]      ; arr=30 -> 28+30=58
    
    ;guradamos el resultado
    MOV resultado, AL
    
    MOV AH, 4Ch
    INT 21H
END main
