model small
.stack 100h
.data
  
    ;music
    espacio    equ 0
    duraciones dw 1, 1, 12, 12, 8, 8, 1, 1, 12, 12, 14, 14,1,0
    tonos      dw 2273, 2025, 1805, 1136, 956, 1073, 1204,1003,0
    spkOld     db 0
    ktic       dw 0
    k          dw 0
    numNotas   db 14
    
    ;music para agregar cuadros correctos
    espacio1    equ 0
    duraciones1 dw 1
    tonos1      dw 1116
    spkOld1     db 0
    ktic1       dw 0
    k1          dw 0
    numNotas1   db 1
    
    
    ;music para error en la selecion de cuadros correctos
    espacio2    equ 0
    duraciones2 dw 1
    tonos2      dw 2273
    spkOld2     db 0
    ktic2       dw 0
    k2          dw 0
    numNotas2   db 14
    
    
    
    WELCOME_MSG         DB "BIENVENIDOS$",0,'$'
    NAMEGAME_MSG        DB "Juego de Memoria",0,'$'
    PLAY_MSG            DB "    JUGAR!    ",0,'$'
    MSG_CREATORS        DB "Creado por Angel Y Eliw$"
    
   ; Player Table
    PlayerTable         DB "Name     Score$",  0
    PLAYER_TABLE_HEADER DB "Player   Score", 0Dh, 0Ah, '$'
    PLAYER1_INFO        DB "Player 1:    ", 0Dh, 0Ah, '$'
    PLAYER2_INFO        DB "Player 2:    ", 0Dh, 0Ah, '$'
    PLAYER3_INFO        DB "Player 3:    ", 0Dh, 0Ah, '$'
    PLAYER4_INFO        DB "Player 4:    ", 0Dh, 0Ah, '$'
    
    
    Score table
    PLAYER1_SCORE       DW  0
    PLAYER2_SCORE       DW  0   
    PLAYER3_SCORE       DW  0
    PLAYER4_SCORE       DW  0
    
    ;Tiros
    TIRO_Game           DB 15 dup (' ')
    
    
.code
; Mouse interrupt handler functions
MOUSE_INIT MACRO 
    INT 33H
    MOV AX, 1 ; Show mouse cursor
    INT 33H
    
    mov ax,04h
    mov cx,320
    mov dx,240
    int 33h
ENDM
MOUSE_CLICK_HANDLER PROC NEAR
    
    MOV AX,03H  ;obtiene las cordenadas del clic del mouse
    INT 33H
    
    ;comprueba en que cuadro se hiso click y actualizar el puntaje
    CMP cx,20       ;Comprueba el click en el area del caudro roj
    JL NOT_RED
    CMP CX,40
    JG NOT_RED
    CMP DX,3
    JL NOT_RED
    CMP DX,12
    JG NOT_RED
    
    INC WORD PTR [PLAYER1_SCORE]
    JMP UPDATE_SCORE

NOT_RED:
    

UPDATE_SCORE:
   
    
MOUSE_CLICK_HANDLER endp

; Macro para dibujar un cuadro en la pantalla
CUADRO MACRO XI,YI,XF,YF,COLOR

    MOV AX, 0600H ; Funcion para definir tama?o y color del borde
    MOV BH, COLOR ; COLOR DE FONDO Y LETRA
    MOV BL, 13H
    MOV CH, YI ; Y INICIAL
    MOV CL, XI ; X INICIAL
    MOV DH, YF ; Y FINAL
    MOV DL, XF ; X FINAL
    INT 10h
ENDM

; Macro para posicionar el cursor en una ubicacion espec?fica
POSICION MACRO X,Y
    MOV DH, Y ; Posici?n en Y
    MOV DL, X ; Posici?n en X
    MOV AH, 02H ; Funci?n para posicionar el cursor
    MOV BH, 00
    INT 10H
ENDM

; Macro para desplegar un mensaje en la pantalla
DESPLEGAR MACRO MENSAJE
    MOV AH, 09 ; Funcion para mostrar mensaje
    MOV DX, OFFSET MENSAJE
    INT 21h
ENDM

CUADROSPAG1 MACRO

    POSICION 32,0 
    DESPLEGAR WELCOME_MSG  

    CUADRO 20,3,58,10,71 ; Primer cuadro (adjustar X final)
    POSICION 32,6
    DESPLEGAR PLAY_MSG
    
    POSICION 35,24
    DESPLEGAR MSG_CREATORS
    

ENDM

; Macro para desplegar cuatro cuadros y mensajes en la pantalla formando uno solo
CUADROSPAG2 MACRO

    POSICION 32,0 
    DESPLEGAR NAMEGAME_MSG  

    CUADRO 20,3,40,12,71 ; Primer cuadro 
    POSICION 20,3

    CUADRO 40,3,60,12,22 ; Segundo cuadro
    POSICION 40,3

    CUADRO 20,13,39,22,33 ; Tercer cuadro
    POSICION 10,13

    CUADRO 40,13,60,22,54 ; Cuarto cuadro
    POSICION 45,13
    
    
ENDM

PLAYER_TABLE MACRO
    ; Display del tablero del jugar
    POSICION 2, 2
    DESPLEGAR PLAYER_TABLE_HEADER
    
    ;DESPLEGAR PLAYER1_SCORE

    ; Display player 1 info
    POSICION 2, 4
    DESPLEGAR PLAYER1_INFO

    ; Display player 2 info
    POSICION 2, 5
    DESPLEGAR PLAYER2_INFO

    ; Display player 3 info
    POSICION 2, 6
    DESPLEGAR PLAYER3_INFO
    
    POSICION 2, 7
    DESPLEGAR PLAYER4_INFO
    
    
ENDM

PRINCIPAL PROC FAR
    MOV AX, @data
    MOV DS, AX
    MOUSE_INIT ;instancia del mouse
;---------------------
    ;PANTALLA
    CUADROSPAG1
   
    
    je cursor
    
cursor:
    
    mov ax,03h
    int 33h
    cmp bx,1 ; detecta click derecho y sale del programa
    je clickiz
    jmp cursor
    
    
clickiz:
    int 33h
    mov ah,00h
    mov al,03h
    int 10h
    CUADROSPAG2
    PLAYER_TABLE
    
    MOUSE_INIT 320, 240  
    
    call play_music
    
    
    
    ;Presionar una tecla para salir
    MOV AH, 00
    INT 16h ;interrupcion
    ;-------------
    MOV AH, 4Ch
    INT 21h
PRINCIPAL ENDP


Segundapantalla PROC FAR
    mov ax, @data
    mov ds, ax

    
    CUADROSPAG2
    PLAYER_TABLE
    
    
    RET
Segundapantalla ENDP


retardo proc near
    push cx
    call tic
    add dx, k ;Modificar el TIC
    mov ktic, dx

    r10:
    call tic
    cmp dx, ktic
    jne r10
    pop cx
    ret
retardo endp

tic proc near

    mov ah, 0
    int 01ah
    ret
tic endp



play_nota proc near
    mov dx, 12h               ; fc = 1193180 = 1234DCh
    mov ax, 34DCh             ; Calcular valor de N
    div cx                    ; En CX est? el periodo N = fc/fn => dx:ax/cx -> N = ax
    mov dx, ax                ; dx <= N

    mov al, 0B6h              ; Configurar el 8254 (palabra de control -> 0B6h)
    out 43h, al               ; Carga de la configuracion en el temporizador 8254
    mov al, dl                ; Pasamos el byte bajo del contador N = dh:dl -> dl
    out 42h, al
    mov al, dh                ; Ahora pasamos el byte alto del contador N = dh:dl -> dh
    out 42h, al

    mov al, spkOld            ; Encender el parlante
    or al, 00000011b          ; Gate2=1 y Out2=1 (Se habilita la conexion contador 2 con el altavoz)
    out 61h, al
    call retardo

    mov al, spkOld            ; Apagamos el parlante
    and al, 11111100b
    out 61h, al
    mov k, espacio
    call retardo
    ret
play_nota endp

; Music playing function
play_music proc near
        mov ax, @data
        mov ds, ax

        in al, 61h
        and al, 11111100b
        mov spkOld, al

        xor si, si     ; Indice para las notas

    loop_notas: 
        mov bx, offset tonos      ; Obtener direccion base de tonos
        add bx, si                ; A?adir desplazamiento calculado
        mov cx, [bx]              ; Cargar frecuencia en CX

        mov bx, offset duraciones ; Obtener direccion base de duraciones
        add bx, si                ; A?adir desplazamiento calculado
        mov ax, [bx]              ; Cargar duracion en AX
        mov k, ax
        call play_nota            ; Tocar la nota

        add si, 2                 ; Incrementar si por el tama?o de la palabra (correcto)
        mov bl, numNotas          ; Cargar el n??mero de notas en BL
        xor bh, bh                ; Limpiar el byte alto de BX

        shl bx, 1                 ; Multiplicar por 2 para obtener el limite superior correcto
        cmp si, bx
        jl loop_notas             ; Repetir hasta que se toquen todas las notas

        mov al, spkOld            ; Restablecer estado del parlante
        out 61h, al
        ret
    play_music endp
    
END PRINCIPAL