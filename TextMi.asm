TITLE CENTER_TEXT

DATOS SEGMENT
    Mensaje DB 'UwU', '$'   ; Mensaje a imprimir
    LongitudEqu EQU $ - Mensaje           ; Calcula la longitud del mensaje
    AnchuraPantalla EQU 80                ; Ancho de la pantalla en caracteres
    LongitudLinea EQU 160                 ; Longitud de una l?nea de pantalla en bytes (80 caracteres * 2 bytes por caracter)
DATOS ENDS

CODE SEGMENT
MAIN PROC FAR
    ASSUME DS:DATOS, CS:CODE

    MOV AX, DATOS
    MOV DS, AX

    ; Calcula la posici?n de inicio para imprimir el texto centrado
    MOV SI, AnchuraPantalla
    SUB SI, LongitudEqu
    SHR SI, 1

    ; Calcula la posici?n en la memoria de v?deo donde se imprimir? el texto
    MOV DI, SI
    SHR DI, 1                 ; Divide por 2 porque cada car?cter ocupa 2 bytes en modo de texto
    ADD DI, 0B800h            ; Direcci?n base de la memoria de v?deo

    ; Configura DS para apuntar a la memoria de v?deo
    MOV AX, 0B800h
    MOV DS, AX

    ; Imprime el texto centrado en pantalla
    MOV CX, LongitudEqu      ; Carga la longitud del texto en CX
    MOV BX, 0Fh              ; Configura el color del texto (blanco sobre negro)
    REP MOVSB                 ; Copia los caracteres del mensaje a la memoria de v?deo

    ; Espera a que el usuario presione una tecla para salir
    MOV AH, 0
    INT 16h

    RET
MAIN ENDP
CODE ENDS
END MAIN
