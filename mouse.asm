.model Small
.stack 64

.data

    x dw 320
    y dw 240

.code
    
main proc NEAR
    mov ax, @data
    mov ds, ax
    ;-----------
    
    mov ah,00h
    mov al,13h ;modo grafico 640x480 pixeles
    mov bh,00 ;pagina 0, color negro
    int 10h
    
    mov ah, 0bh
    mov bh, 00h
    mov bl, 01h ;color fondo
    int 10h
    
    ; inicializa mouse
    mov ax,00h
    int 33h
    
    cmp al,00h ; si no enontro driver se sale del programa 
    je salir
    
    ; muestra puntero de mouse
    mov ax,01h
    int 33h
    
    ; ubica el  mouse
    mov ax,04h
    mov cx,x
    mov dx,y
    int 33h
    
    
    ; detecta estado del mouse
    
cursor:
    mov ax,03h
    int 33h
    cmp bx,2 ; detecta click derecho y sale del programa
    je salir
    jmp cursor
    
salir: 
    mov ax,02h ;oculto raton
    int 33h
    mov ah,00h
    mov al,03h
    int 10h
    
    
    ; salir de DOS
    
    mov ax, 4C00H
    int 21h
    
    main endp
end main