.model Small
.stack 64

.data
    x dw 320
    y dw 240

    ; Colores iniciales de los cuadros
    colors db 71, 22, 33, 54
    ; Rangos para cada cuadro (x inicial, y inicial, x final, y final)
    ranges db 1, 1, 40, 10, 41, 1, 80, 10, 1, 11, 40, 20, 41, 11, 80, 20
    WELCOME_MSG DB "Welcome to game$", 0

    
.code

; Macro para dibujar un cuadro en la pantalla
CUADRO MACRO XI, YI, XF, YF, COLOR
    MOV AX, 0600H         ; Funci?n para definir tama?o y color del borde
    MOV BH, COLOR         ; Color de fondo y letra
    MOV BL, 00H
    MOV CH, YI            ; Y inicial
    MOV CL, XI            ; X inicial
    MOV DH, YF            ; Y final
    MOV DL, XF            ; X final
    INT 10H
ENDM

; Macro para posicionar el cursor en una ubicaci?n espec?fica
POSICION MACRO X, Y
    MOV DH, Y             ; Posici?n en Y
    MOV DL, X             ; Posici?n en X
    MOV AH, 02H           ; Funci?n para posicionar el cursor
    MOV BH, 00
    INT 10H
ENDM

; Macro para desplegar un mensaje en la pantalla
DESPLEGAR MACRO MENSAJE
    MOV AH, 09            ; Funci?n para mostrar mensaje
    MOV DX, OFFSET MENSAJE
    INT 21H
ENDM

; Macro para desplegar cuatro cuadros y mensajes en la pantalla formando uno solo
CUADROSCOMBINADOS MACRO

    POSICION 10,0  ; Set the position to the top middle of the screen.
    DESPLEGAR WELCOME_MSG  ; Display the "Welcome to game" message.

    CUADRO 1, 1, 40, 10, byte ptr colors[0] ; Primer cuadro
    POSICION 10, 3
    
    CUADRO 41, 1, 80, 10, byte ptr colors[1] ; Segundo cuadro
    POSICION 50, 3
   
    CUADRO 1, 11, 40, 20, byte ptr colors[2] ; Tercer cuadro
    POSICION 10, 13
   
    CUADRO 41, 11, 80, 20, byte ptr colors[3] ; Cuarto cuadro
    POSICION 50, 13
ENDM

main proc NEAR
    mov ax, @data
    mov ds, ax

    ; Configurar modo gr?fico
    mov ah, 00h
    mov al, 12h ; Modo gr?fico 640x480 p?xeles
    int 10h

    ; Inicializar mouse
    mov ax, 0000h
    int 33h
    cmp al, 00h
    
    ; Mostrar puntero de mouse
    mov ax, 0001h
    int 33h

    ; Ubicar el mouse en el centro inicial
    mov ax, 0004h
    mov cx, x
    mov dx, y
    int 33h

    ; Mostrar cuadros combinados
    CUADROSCOMBINADOS

cursor:
    mov ax, 0003h
    int 33h
    cmp bx, 0001h
    je cambiar
    jne cursor

cambiar:
    ; Asumiendo que cx contiene la posici?n x del mouse y dx la posici?n y
    mov bx, 0          ; ?ndice para los cuadros
    cmp_cuarto:
        mov al, [ranges + bx]       ; x inicial del cuadro
        cmp cx, ax
        jl next_cuarto              ; Si cx < x inicial, no es este cuadro
        mov al, [ranges + bx + 2]   ; x final del cuadro
        cmp cx, ax
        jg next_cuarto              ; Si cx > x final, no es este cuadro
        mov al, [ranges + bx + 1]   ; y inicial del cuadro
        cmp dx, ax
        jl next_cuarto              ; Si dx < y inicial, no es este cuadro
        mov al, [ranges + bx + 3]   ; y final del cuadro
        cmp dx, ax
        jg next_cuarto              ; Si dx > y final, no es este cuadro

        ; Si pasamos todas las comprobaciones, bx es el ?ndice del cuadro clickeado
        
        ; Cambiar el color del cuadro correspondiente
        jmp redraw
        ;inc byte ptr [colors + bx / 4] ; Cambia el color aumentando el valor

    next_cuarto:
        add bx, 4
        cmp bx, 16     ; 4 cuadros * 4 bytes por datos de rango
        jl cmp_cuarto

redraw:
    CUADROSCOMBINADOS
    jmp cursor

salir:
    mov ax, 0002h
    int 33h
    mov ah, 00h
    mov al, 03h
    int 10h

    ; Salir de DOS
    mov ax, 4C00H
    int 21h

main endp
end main
