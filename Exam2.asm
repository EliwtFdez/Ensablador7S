.MODEL SMALL
.STACK 100h

.data
mensaje1 DB "****   Bienvenido a tu calculadora aritm?tica - l?gica  ****$"
mensaje2 DB "Introduce el primer n?mero: $"
mensaje3 DB "Introduce el segundo n?mero: $"
mensaje4 DB "Selecciona la operaci?n a realizar: M - Multiplicaci?n, A - AND, O - OR, X - XOR$"
mensaje5 DB "***** El resultado de la operaci?n es: $"

.CODE
MAIN PROC
    MOV AX, @data
    MOV DS, AX

    ; Imprimir mensaje 1 en verde
    MOV AH, 09h
    MOV DX, OFFSET mensaje1
    MOV CX, 0
    MOV BL, 0Ah  ; Verde
    INT 10h

    ; Capturar primer n?mero
    ; (aqu? deber?as implementar tu propia l?gica para capturar y almacenar el n?mero)

    ; Imprimir mensaje 2 en azul
    MOV AH, 09h
    MOV DX, OFFSET mensaje2
    MOV BL, 09h  ; Azul
    INT 10h

    ; Capturar segundo n?mero
    ; (aqu? deber?as implementar tu propia l?gica para capturar y almacenar el n?mero)

    ; Imprimir mensaje 3 en rojo
    MOV AH, 09h
    MOV DX, OFFSET mensaje3
    MOV BL, 04h  ; Rojo
    INT 10h

    ; Capturar operaci?n
    ; (aqu? deber?as implementar tu propia l?gica para capturar y almacenar la operaci?n)

    ; Imprimir mensaje 4 en violeta
    MOV AH, 09h
    MOV DX, OFFSET mensaje4
    MOV BL, 0Dh  ; Violeta
    INT 10h

    ; Realizar operaci?n
    ; (aqu? deber?as implementar tu propia l?gica para realizar la operaci?n)

    ; Imprimir resultado en verde
    MOV AH, 09h
    MOV DX, OFFSET mensaje5
    MOV BL, 0Ah  ; Verde
    INT 10h

    ; Imprimir resultado num?rico
    ; (aqu? deber?as imprimir el resultado num?rico de la operaci?n)

    ; Salir del programa
    MOV AH, 4Ch
    INT 21h
MAIN ENDP

END MAIN
