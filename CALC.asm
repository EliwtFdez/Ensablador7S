.MODEL SMALL
.STACK 100H
.DATA
    arr DB 5 DUP(?) ; Arreglo para almacenar los 5 n?meros ingresados
    msg1 DB 'Ingrese un numero: $'
    msg2 DB 'Los datos ingresados son: $'
    msg3 DB 'Los datos ordenados son: $'
    newline DB 13, 10, '$'
.CODE
MAIN PROC
    MOV AX, SEG arr
    MOV DS, AX
    MOV ES, AX

    ; Leer 5 n?meros del teclado
    LEA SI, arr
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

    ; Mostrar los datos ingresados
    LEA DX, msg2
    MOV AH, 09H
    INT 21H ; Mostrar mensaje de datos ingresados

    LEA SI, arr
    MOV CX, 5
DisplayLoop1:
    MOV DL, [SI]
    ADD DL, 30H ; Convertir n?mero a car?cter
    MOV AH, 02H
    INT 21H ; Mostrar n?mero
    LEA DX, newline
    MOV AH, 09H
    INT 21H ; Nueva l?nea
    INC SI
    LOOP DisplayLoop1

    ; Ordenar los datos usando bubble sort
    LEA SI, arr
    MOV CX, 4

OuterLoop:
    MOV DI, SI
    MOV BX, CX

InnerLoop:
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
    JNZ InnerLoop

    DEC CX
    JNZ OuterLoop

    ; Mostrar los datos ordenados
    LEA DX, msg3
    MOV AH, 09H
    INT 21H ; Mostrar mensaje de datos ordenados

    LEA SI, arr
    MOV CX, 5
DisplayLoop2:
    MOV DL, [SI]
    ADD DL, 30H ; Convertir n?mero a car?cter
    MOV AH, 02H
    INT 21H 
    
    LEA DX, newline
    MOV AH, 09H
    INT 21H 
    INC SI
    LOOP DisplayLoop2

    ; Terminar programa
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN