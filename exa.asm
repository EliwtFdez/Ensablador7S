.model small
.stack 64
.data

    HT EQU 09
    LF EQU 10
    CR EQU 13
    
    WelcomeMsj db '**** Bienvendio a tu calculadora aritm',130,'tica - l',162,'gica ****',CR, LF,'$
    
    IntroduceNum1 db 'Introduce un numero:    ',CR, LF, '$'
    IntroduceNum2 db 10,'Introduce otro numero : ',CR, LF ,'$'
  
    
    MsjOpcion   db 10,'Selecciona la operacion a realizar:', CR, LF, '$'
    msjOpcioneM db HT,'M. - Multiplicacion', CR, LF , '$' 
    msjOpcioneA db  HT,'A. - AND', CR, LF , '$' 
    msjOpcioneO db  HT,'O. - OR', CR, LF , '$' 
    msjOpcioneX db  HT,'X. - XOR', CR, LF , '$' 
   
    msj4 db 10,'El resultado es :', CR, LF, '$'
    
    
    num1 db ?
    num2 db ?
    num3 db ?
    num4 db ?
    

.code

main proc NEAR
     MOV ax, @data
     MOV ds, ax
    ;------------------
    mov AH, 06H ; Funci?n para desplazar el cursor
    mov AL, 00H ; C?digo de desplazamiento
    mov BH, 02H ; Atributo de pantalla (color) VERDE
    mov CH, 00H ; Fila de inicio
    mov CL, 00H ; Columna de inicio
    mov DH, 00H ; Fila de final
    mov DL, 4FH ; Columna de final
    int 10H     ; Llamada a la interrupci?n de video
    
    mov AH, 09H
    lea dx, WelcomeMsj
    int 21H
    
    ;capturar primer numero
    mov AH, 06H ;limpiar pantalla
    mov AL, 00H
    mov BH, 03H ;atributo AZUL
    mov CH, 01H ;Renglon inicio
    mov CL, 00H ;Columna inicio
    mov DH, 01H ;Renglon Final
    mov DL, 4FH ;Columna final
    int 10H 
    
    mov AH, 09H
    lea dx, IntroduceNum1
    int 21H
    
    mov ah,01H
    int 21H
    sub al, 48
    mov num1, AL
    
    ;capturar segundo numero
    mov AH, 06H ;limpiar pantalla
    mov AL, 00H
    mov BH, 04H ;atributo ROJO
    mov CH, 03H ;Renglon inicio
    mov CL, 00H ;Columna inicio
    mov DH, 03H ;Renglon Final
    mov DL, 4FH ;Columna final
    int 10H
    
    mov ah, 09H
    lea dx, IntroduceNum2
    int 21H
    
    mov ah,01H
    
    int 21H
    sub al, 48
    mov num2, AL
    
    ;captura para saber la operacion a realizar
    mov AH, 06H ;limpiar pantalla
    mov AL, 00H
    mov BH, 05H ;atributo Morado Lista
    mov CH, 04H ;Renglon inicio
    mov CL, 00H ;Columna inicio
    mov DH, 9H ;Renglon Final
    mov DL, 4FH ;Columna final
    int 10H
    
    ;Cuadro de opciones
    mov ah,09h
    lea dx, MsjOpcion
    int 21H
   
    mov ah,09h
    lea dx, msjOpcioneM
    int 21H
   
    mov ah,09h
    lea dx, msjOpcioneA
    int 21H

    mov ah,09h
    lea dx, msjOpcioneO
    int 21H
    
    mov ah,09h
    lea dx, msjOpcioneX
    int 21H
   
    mov AH, 06H ;limpiar pantalla
    mov AL, 02H
    mov BH, 03H ;atributo      Verde again
    mov CH, 01H ;Renglon inicio
    mov CL, 00H ;Columna inicio
    mov DH, 11H ;Renglon Final\
    mov DL, 4FH ;Columna final
    int 10H
    
    mov ah,01h
    int 21h
    
  ;opciones de la operacion
  
  CMP AL, 'M'
  JE opcionMultiplicacion
  
  CMP AL, 'A'
  JE opcionAnd
  
  CMP AL, 'O'
  JE opcionOR
  
  CMP AL, 'X'
  JE opcionXOR
  
  JMP fin ; Si no se selecciona una opci?n v?lida, saltar al final
  
opcionMultiplicacion:
    ; Multiplicacion
    mov al, num1
    mov bl, num2
    mul bl
    mov num3, al
    JMP mostrar_resultado
    
opcionAnd:
    ; AND
    mov al, num1
    and al, num2
    mov num3, al
    JMP mostrar_resultado
    
opcionOR:
    ; OR
    mov al, num1
    or al, num2
    mov num3, al
    JMP mostrar_resultado
    
opcionXOR:
    mov al, num1
    xor al, num2
    mov num3, al
    JMP mostrar_resultado
    
mostrar_resultado:
    ; Mostrar resultado
    mov AH,09H
    lea dx, msj4
    int 21H
    ; ajuste numero a ASCII
    mov AH,02H
    add al, 48
    mov dl, al
    int 21h
    mov al, num3
    
fin:
    ; salir del DOS
    mov ax, 4C00h
    int 21h
    
main endp
end main