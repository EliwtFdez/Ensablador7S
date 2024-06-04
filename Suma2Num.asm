;Hacer un prgrama que te sume 2 numeros y te lo imprima
.model Small
.stack 64
.data
    
    num1     db 00
    num2     db 00
    resSuma  db 00       
    
    mensaje  db 10,13,'Escribe un numero ', '$'
    mensaje2 db 10,13,'Escriba otro numero ', '$'
    mensaje3 db 10,13,'la suma es: ', '$'
    mensaje4 db 10,13,'la multiplicacion es: $'
    
    unidades db ?
    decenas  db ?
    caracter db ?

.code

main proc NEAR
     MOV AX, @data
     MOV DS, AX
            
    ;----------------------
    ;INTRODUCIR
    ;----------------------
    
    mov AH, 09H         ;imprime msg
    lea DX, mensaje
    int 21H
    
    mov AH, 01H         ;entrada teclado
    int 21H
    sub AL, 48
    mov num1, AL
    
    mov AH,09H          ;imprime msg2
    lea DX, mensaje2
    int 21H
    
    mov AH, 01H         ;entrada teclado
    int 21H
    sub AL, 48
    
    
    
    
    
    
    
    mov num2, AL
    
    
    
   
    mov AL, num1
    add AL, num2
    add AL, 30H
    
    mov resSuma, AL
    
    mov AH, 09H
    lea DX, mensaje3
    int 21H
    
    
    mov AH, 02H
    mov DL, resSuma
    int 21H
    
    
    
    
    ;--------------
    ;salir del DOS
    ;--------------
    mov AX, 4C00h
    int 21h
    
    main endp
 end main   