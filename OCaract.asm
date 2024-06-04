;Crear un programa que te imprima un solo numero 
.model Small
.stack 64
.data

    HT EQU 09
    LF EQU 10
    CR EQU 13
    mensaje db 'Escribe un numero',CR, LF, '$'
    mensaje2 db 'Tu numero es:', CR, LF ,'$'
    ; DATOS LABEL BYTE
    unidades db ?
    decenas db ?
    caracter db ?
    
.code


main proc NEAR
     MOV AX, @data
     MOV DS, AX
    ;------------------
    
    ;----------------------
    mov AH, 09H
    lea DX, mensaje
    int 21H
    
    mov AH, 01H
    int 21H
    mov decenas, AL
        
    mov AH, 01H
    int 21H
    mov unidades,DL
   
    ;----------------------
    ;INTRODUCIR
    ;----------------------
    
    
    ;mov AH, 3fH
    ;mov bx, 00
    ;mov cx, 100
    ;mov DX, offset [caracter]
    ;int 21H
    ;
    
    mov AH, 09H
    lea DX, mensaje2
    int 21H
    
    mov AH,02H
    mov DL,AL
    int 21H

    ;--------------
    ;salir del DOS
    ;--------------
    mov AX, 4C00h
    int 21h
    
    main endp
 end main   