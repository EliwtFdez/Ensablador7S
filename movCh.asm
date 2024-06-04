.model small
.stack 100h

.data
    renglonPantalla db 25
    columnaPantalla db 80
    caracter db '#'

.code
main:
    mov ax, @data
    mov ds, ax

    mov ah, 0    
    mov al, 3    
    int 10h

    mov bl, 0    
    mov dl, 0    

moveLoop:
    ; Mover hacia la derecha
    mov ah, 2  
    mov bh, 0  
    mov dh, dl 
    mov dl, bl 
    int 10h    
    mov ah, 9  
    mov al, caracter ; Car?cter a imprimir
    mov bh, 0    ; P?gina de visualizaci?n
    mov cx, 1    ; N?mero de veces a imprimir el car?cter
    int 10h      ; Llamar a la interrupci?n de video

    inc bl      ; Incrementar la columna

    ; Si llega al final de la pantalla, retrocede
    cmp bl, columnaPantalla
    jne moveLoop

    mov bl, columnaPantalla - 1  ; Establecer en el extremo derecho

moveBackwardLoop:
    ; Mover hacia la izquierda
    mov ah, 2    ; Funci?n para colocar el cursor
    mov bh, 0    ; P?gina de visualizaci?n
    mov dh, dl  ; Fila
    mov dl, bl  ; Columna
    int 10h      ; Llamar a la interrupci?n de video
    mov ah, 9    ; Funci?n para imprimir un car?cter en pantalla
    mov al, caracter ; Car?cter a imprimir
    mov bh, 0    ; P?gina de visualizaci?n
    mov cx, 1    ; N?mero de veces a imprimir el car?cter
    int 10h      ; Llamar a la interrupci?n de video

    dec bl      ; Decrementar la columna

    ; Si llega al inicio de la pantalla, avanza
    cmp bl,
