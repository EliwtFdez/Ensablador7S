;Angel y Cristo
.MODEL SMALL
.STACK 100H
.data
    
    arreglo DB 5 DUP(?) 
    
    msg1 DB 10,'Ingrese un numero: $',10,13
    
    msg2 DB 13, 10, 'Los datos ingresados son: $'
    msg3 DB 13, 10, 'Los datos ordenados son: $'
    
    newline DB 13, 10, '$'
    space DB ' $'
    
.code

MAIN PROC
    MOV AX, @data
    MOV DS, AX
    
    ; Leer 5 n?meros del teclado
    MOV ES, AX
    LEA SI, arreglo
    MOV CX, 5

ReadLoop:
    
    LEA DX, msg1
    MOV AH, 09H
    INT 21H ; Mostrar mensaje de ingreso


    MOV AH, 01H
    INT 21H ; Leer un car?cter del teclado
    SUB AL, 30H ; Convertir car?cter a n?mero
    MOV [SI], AL
    INC SI
    LOOP ReadLoop
    
    ; Nueva linea pa que se vea bonis
    LEA DX, newline
    MOV AH, 09H
    INT 21H
    
    ; Mostrar los datos ingresados
    LEA DX, msg2
    MOV AH, 09H
    INT 21H 

    LEA SI, arreglo
    MOV CX, 5
    
DisplayLoop1:
    MOV DL, [SI]
    ADD DL, 30H ; Convertir n?mero a car?cter
    MOV AH, 02H
    INT 21H ; Mostrar n?mero
    LEA DX, space
    MOV AH, 09H
    INT 21H 
    
    INC SI
    LOOP DisplayLoop1

    ; Nueva l?nea
    LEA DX, newline
    MOV AH, 09H
    INT 21H

    ; Ordenar los datos usando metodo de burbuja
    LEA SI, arreglo
    MOV CX, 4

ExteriorLoop:
    MOV DI, SI
    MOV BX, CX

InteriorLoop:
    MOV AL, [DI]
    MOV AH, [DI+1]
    CMP AL, AH
    JBE SkipSwap
    XCHG AL, AH
    MOV [DI], AL
    MOV [DI+1], AH

SkipSwap:
    INC DI
    DEC BX
    JNZ InteriorLoop

    DEC CX
    JNZ ExteriorLoop

    ; Mostrar los datos ordenados
    LEA DX, msg3
    MOV AH, 09H
    INT 21H 

    LEA SI, arreglo
    MOV CX, 5
    
DisplayLoop2:
    MOV DL, [SI]
    ADD DL, 30H ; Convertir n?mero a car?cter
    MOV AH, 02H
    INT 21H ; Mostrar n?mero
    LEA DX, space
    
    MOV AH, 09H
    INT 21H ; Espacio
    INC SI
    LOOP DisplayLoop2

    ; Nueva l?nea
    LEA DX, newline
    MOV AH, 09H
    INT 21H

    ; Salida Dos
    MOV AX, 4C00h
    INT 21H
MAIN ENDP
END MAIN
