;dividir pantalla en 4 colores(background) y en el centro de cada cuadro este una frase
.model small
.stack 64
.data
    
    renglonPantalla db 25
    columnaPantalla db 80
    
    msgP1 db 'Hellow word! $'
    msgP2 db 'Hola mundo! $'
    msgP3 db 'Ciao mundo' 
    msgP4 db 'Hallo welt'
    
    
.code

main proc NEAR
     MOV AX, @data
     MOV DS, AX
            
    ;----------------------
    
    
    
    
    
    
    ;--------------
    ;salir del DOS
    ;--------------
    mov ax, 4C00h
    int 21h
    
    main endp
 end main   