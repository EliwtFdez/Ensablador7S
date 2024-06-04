    .model small
.stack 100h

.data
    M1 DB "1$"
    M2 DB "2$"
    M3 DB "3$"
    M4 DB "4$"
    WELCOME_MSG DB "Welcome to game$", 0


.code

; Macro para dibujar un cuadro en la pantalla
CUADRO MACRO XI,YI,XF,YF,COLOR

    MOV AX, 0600H ; Funci?n para definir tama?o y color del borde
    MOV BH, COLOR ; COLOR DE FONDO Y LETRA
    MOV BL, 00H
    MOV CH, YI ; Y INICIAL
    MOV CL, XI ; X INICIAL
    MOV DH, YF ; Y FINAL
    MOV DL, XF ; X FINAL
    INT 10h
ENDM

; Macro para posicionar el cursor en una ubicacion espec?fica
POSICION MACRO X,Y
    MOV DH, Y ; Posici?n en Y
    MOV DL, X ; Posici?n en X
    MOV AH, 02H ; Funci?n para posicionar el cursor
    MOV BH, 00
    INT 10H
ENDM

; Macro para desplegar un mensaje en la pantalla
DESPLEGAR MACRO MENSAJE
    MOV AH, 09 ; Funci?n para mostrar mensaje
    MOV DX, OFFSET MENSAJE
    INT 21h
ENDM

; Macro para desplegar cuatro cuadros y mensajes en la pantalla formando uno solo
CUADROSCOMBINADOS MACRO

    POSICION 32,0  ; Set the position to the top middle of the screen.
    DESPLEGAR WELCOME_MSG  ; Display the 'Welcome to game" message.
    
    CUADRO 1,1,40,10,71 ; Primer cuadro
    POSICION 10,3
    
    CUADRO 41,1,80,10,22 ; Segundo cuadro
    POSICION 50,3
   
    CUADRO 1,11,40,20,33 ; Tercer cuadro
    POSICION 10,13
   
    CUADRO 41,11,80,20,54 ; Cuarto cuadro
    POSICION 50,13

ENDM

PRINCIPAL PROC
    MOV AX, @data
    MOV DS, AX
;---------------------
     
    CUADROSCOMBINADOS

    
    MOV AH, 4Ch
    INT 21h
PRINCIPAL ENDP

END PRINCIPAL
