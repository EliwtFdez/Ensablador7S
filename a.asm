.model Small
.stack 64
.data
    mensaje db 'Chadowkadizz', '$'
    renglonPantalla db 0
    columnaPantalla db 0
 
.code

main proc NEAR
    MOV ax, @data
    MOV ds, ax
    ;------------------
    MOV CL,20
    
ciclo:
    ;POSICIONA EL CUROSR
    MOV AH, 02H                 ;fija el curson a una pusocion
    MOV BH, 00H
    MOV DH, renglonPantalla     ;pon el cursor de la posicion
    MOV DL, columnaPantalla
    INT 10H
    ;TERMINA DE POSICIONAR
    
    ;IMPRIME LETRA EN PANTALLA
    MOV AL, mensaje[SI] ;
    MOV AH, 02H
    MOV DL, AL
    INT 21H
    ;////////////////////////
    
    INC SI
    INC renglonPantalla 
    INC columnaPantalla
    LOOP ciclo
    
    
    ;--------------
    ;salir del DOS
    ;--------------
    mov ax, 4C00h
    int 21h
    
    
    main endp
 end main