.model Small
.stack 64
.data

    HT EQU 09
    LF EQU 10
    CR EQU 13
    mensaje db 'Escribe tu mensaje',CR, LF, '$'
    mensaje2 db 'Tu mensaje es:', CR, LF ,'$'
    ; DATOS LABEL BYTE
    MAXCAR db 20
    ACTCAR db ?
    CAMPODATOS db 20 DUP (' '), '$'
    
.code

main proc NEAR
     MOV ax, @data
     MOV ds, ax
    ;------------------
    
    ;----------------------
    mov AH, 09H
    lea dx, mensaje
    int 21H
    ;----------------------
    
    ;----------------------
    ;INTRODUCIR
    ;----------------------
    mov AH, 3fH
    mov bx, 00
    mov cx, 100
    mov DX, offset [CAMPODATOS]
    int 21H
    
    mov AH, 06H ;limpiar pantalla
    mov AL, 00H
    mov BH, 06H ;atibuto
    mov CH, 03H ;Renglon inicio
    mov CL, 00H ;Columna inicio
    mov DH, 18H ;Renglon Final
    mov DL, 4FH ;Columna final
    int 10H
    
    mov AH, 09H
    lea dx, mensaje2
    int 21H
    
    
    MOV AH, 09h
    lea dx, CAMPODATOS
    ;mov DX, offset {CAMPODATOS}
    int 21H
    
    
    ;--------------
    ;salir del DOS
    ;--------------
    mov ax, 4C00h
    int 21h
    
    main endp
 end main