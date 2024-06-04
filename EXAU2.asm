.model Small
.stack 64
.data

    HT EQU 09
    LF EQU 10
    CR EQU 13
    
    msj1 db 'Introduce un numero: ',CR, LF, '$'
    msj2 db 10, 'Introduce otro numero : ', CR, LF ,'$'
    msj3 db 10, 'Selecciona la operacion a realizar:''M. - Multiplicacion ,  A. - AND ,  O. - OR ,  X. - XOR', CR, LF, '$'
    msj4 db 'El resultado es :', CR, LF, '$'
    msj0 db '*Bienvenido a tu calculadora logica-aritmetica*', CR, LF, '$'
    num1 db ?
    num2 db ?
    num3 db ?
    num4 db ?
    .code

main proc NEAR
     MOV ax, @data
     MOV ds, ax
    ;------------------
    mov AH, 06H ;limpiar pantalla
    mov AL, 00H
    mov BH, 02H ;atibuto
    mov CH, 00H ;Renglon inicio
    mov CL, 00H ;Columna inicio
    mov DH, 00H ;Renglon Final
    mov DL, 4FH ;Columna final
    int 10H
    
    mov AH, 09H
    lea dx, msj0
    int 21H
    
    ;capturar primer numero
    mov AH, 06H ;limpiar pantalla
    mov AL, 00H
    mov BH, 03H ;atibuto
    mov CH, 01H ;Renglon inicio
    mov CL, 00H ;Columna inicio
    mov DH, 01H ;Renglon Final
    mov DL, 4FH ;Columna final
    int 10H 
    
   
    mov AH, 09H
    lea dx, msj1
    int 21H
    
    
    
    
    mov ah,01H
    int 21H
    sub al, 48
    mov num1, AL
    ;capturar segundo numero
      mov AH, 06H ;limpiar pantalla
    mov AL, 00H
    mov BH, 04H ;atibuto
    mov CH, 03H ;Renglon inicio
    mov CL, 00H ;Columna inicio
    mov DH, 03H ;Renglon Final
    mov DL, 4FH ;Columna final
    int 10H
    
    mov ah, 09H
    lea dx, msj2
    int 21H
    
   
    ;capturar el segundo numero 
    
    mov ah,01H
    int 21H
    sub al, 48
    mov num2, AL
    ;captura para saber si es suma o resta
    
    mov AH, 06H ;limpiar pantalla
    mov AL, 00H
    mov BH, 05H ;atibuto
    mov CH, 04H ;Renglon inicio
    mov CL, 00H ;Columna inicio
    mov DH, 06H ;Renglon Final
    mov DL, 4FH ;Columna final
    int 10H
    
    mov ah,09h
    lea dx, msj3
    int 21H
    
    mov ah,01h
    int 21h
    
  ;opciones de la opreacion
  
  CMP AL, 'M'
  jmp opcion1
  
  CMP AL, 'A'
  jmp opcion2
  
  CMP AL, 'O'
  jmp opcion3
  
  CMP AL, 'X'
  jmp opcion4
  
  
  
  ;opciones
  
opcion1:
   
    mov al, num1
    add al, num2
    mov ah, 00H
    AAA
    mov num3, al
    mov num4, ah
    int 21h
    
opcion2:
    
    
    
    int 21H
opcion3:
    
    
    int 21H
    
opcion4:
    
    int 21h
    
    
 ;suma y ajuste de la suma
    mov al, num1
    add al, num2
    mov ah, 00H
    AAA
    mov num3, al
    mov num4, ah
    
    
    
    mov AH,09H
    lea dx, msj4
    int 21H
    ;ajuste numero a ASCII
    mov AH,02H
    mov al, num4
    add al, 48
    mov dl, al
    int 21h
    
    
    
    mov AH,02h
    mov al, num3
    add al, 48
    mov dl, al
    int 21h
    
    ;--------------
    ;salir del DOS
    ;--------------
    mov ax, 4C00h
    int 21h
    
    main endp
 end main