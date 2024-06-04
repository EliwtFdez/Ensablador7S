.model small
.stack 100h

.data
    MAXCAR db 20
    ACTCAR db ?
    CAMPODATOS db 20 DUP (' '), '$'
    

.code

print_message MACRO mensaje
    mov ah, 09h         
    lea dx, mensaje     
    int 21h             
endM

ScreenMacro MACRO XI,YI,XF,YF,COLOR
    MOV AH, 06H ; Funci?n para definir el tama?o del cursor
    MOV AL, 0
    MOV BH, COLOR ; COLOR DE FONDO Y LETRA
    MOV CX, YF-YI+1 ; N?mero de l?neas
    MOV DX, XF-XI+1 ; N?mero de columnas
    INT 10h
    MOV AH, 02H ; Funci?n para posicionar el cursor
    MOV BH, 0
    MOV DH, YI
    MOV DL, XI
    INT 10h
endM

start:
    mov ax, @data       
    mov ds, ax

    ScreenMacro 1,1,80,25,07 ; Pantalla completa en color blanco sobre negro
    
    ScreenMacro 3,3,10,10,04 ; Cuadro rojo
    ScreenMacro 11,3,18,10,02 ; Cuadro verde
    ScreenMacro 3,12,10,19,01 ; Cuadro azul
    ScreenMacro 11,12,18,19,80 ; Cuadro gris
    
    mov ah, 4Ch         
    int 21h             
end start
