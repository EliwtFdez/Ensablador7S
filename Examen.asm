.model small
.stack 100h

.data
    mensaje_bienvenido          db 10,13,'****   Bienvenido a tu calculadora aritm',130,'tica - l',162,'gica  ****$'
    mensaje_primer_numero       db 10,13,'Introduce el primer n',163,'mero:$'
    mensaje_segundo_numero      db 10,13,'Introduce el segundo n',163,'mero:$'
    mensaje_seleccion_operacion db 10,13,'Selecciona la operaci',162,'n a realizar:', 'M - Multiplicaci',162,'n, A - AND, O - OR, X - XOR$'
    mensaje_resultado           db 10,13,'***** El resultado de la operaci',162,'n es: $'
   
    primer_numero   db ?     
    segundo_numero  db ?     
    operacion       db ?         
    resultado       db ?     
    
    
    color_violeta equ 13h
    
    
.code

main proc NEAR
     MOV ax, @data
     MOV ds, ax
    ;------------------
    
    mov AH, 09H         
    lea DX, mensaje_bienvenido
    mov cx, 02H
    mov bl, 02H
    int 21H
    
    ;-----------------------
    mov AH, 09H         
    lea DX, mensaje_primer_numero
    int 21H
    
    ;entrada teclado
    mov AH, 01H        
    int 21H
    sub AL, 48
    mov primer_numero, AL
    ;-----------------------
    
    
    ;----------------------
    mov AH, 09H         
    lea DX, mensaje_segundo_numero
    int 21H
    
    ;entrada teclado
    mov AH, 01H         
    int 21H
    sub AL, 48
    mov segundo_numero, AL
    ;----------------------
    
    
    mov AH, 09H         
    lea DX, mensaje_seleccion_operacion
    int 21H
    
    
    ; Comparar la opcion ingresada
    cmp AL, 'M'
    je operacion_Mul
    
    cmp AL, 'A'
    je operacion_and
    
    cmp AL, 'O'
    je operacion_or
    
    cmp AL, 'X'
    je operacion_xor
    
    jmp fin ;brinca a la salida del Dos2
  

operacion_Mul:
    MOV AL, primer_numero
    Mov bl, segundo_numero
    MUL BL
    MOV operacion, AL
    JMP mostrar_resultado
    
operacion_and:
    MOV AL, primer_numero
    AND AL, segundo_numero
    MOV operacion, AL
    JMP mostrar_resultado
    
operacion_or:
    MOV AL, primer_numero
    OR  AL, segundo_numero
    MOV operacion, al
    JMP mostrar_Resultado

operacion_xor:
    MOV AL, primer_numero
    XOR AL, segundo_numero
    JMP mostrar_Resultado
    
mostrar_Resultado:
    MOV AH, 09H 
    LEA DX, mensaje_resultado
    INT 21H
    
    MOV AH, 02H
    ADD AL,48
    MOV DL, AL
    INT 21H
    MOV AL, operacion
    
    
    
fin:
    ;--------------
    ;salir del DOS
    ;--------------
    mov ax, 4C00h
    int 21h
    
    main endp
 end main   