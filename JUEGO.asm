.model small
.stack 100h

; Macros para manipulaci?n de UI
CUADRO MACRO COLOR, POINTI,POINTF
    MOV AH, 06H     ; Funci?n de desplazamiento hacia arriba.
    MOV BH, COLOR   ; Atributo de color (por ejemplo, 1F = fondo azul, texto blanco)
    MOV CX, POINTI  ; Esquina superior izquierda (rengl?n = 0, columna = 0)
    MOV DX, POINTF  ; Esquina inferior derecha (fila 12, columna 39)
    MOV AL, 0       ; N?mero de l?neas para desplazar (0 = limpiar toda la pantalla)
    INT 10H
ENDM

CUADROS_GAME MACRO
 
    CUADRO 05h,030AH, 0C27H ; Primer cuadro 
    
    CUADRO 0Ch,0327H, 0C45H; Segundo cuadro
    
    CUADRO 0Eh,0C0AH, 1527H ; Tercer cuadro
    
    CUADRO 0Ah,0C27H, 1545H ; Cuarto cuadro
  
ENDM

CHANGE_COLOR macro px, py
    mov cx, px
    mov dx, py
    
    cmp cx, 130h
    jb izquierda
    
    cmp cx, 27h
    
    jg derecha
    jmp cursor

izquierda:
    cmp dx, 0B4h
    jb cambiar_q1
    cmp dx, 32h
    jg cambiar_q3

derecha:
    cmp dx, 0B4h
    jl cambiar_q2
    cmp dx, 32h
    ja cambiar_q4

cambiar_q1:
    mov eleccion_temp, 1
    cuadro 0CH, 030AH, 0b26H ;Rosa
    
    int 10h
    jmp return_cambiar_color

cambiar_q2:
    mov eleccion_temp, 2  
    cuadro 0aH, 0327H, 0b45H ;Verde claro
    
    int 10h
    jmp return_cambiar_color

cambiar_q3:
    mov eleccion_temp, 3   
    cuadro 0bH, 0C0AH, 1526H ;Cyan
    
    int 10h
    jmp return_cambiar_color

cambiar_q4:
    mov eleccion_temp, 4 
    cuadro 0eH, 0C27H, 1545H ;Amarillo claro
    
    int 10h
    jmp return_cambiar_color

return_cambiar_color:
endm

;--------------  C L I C K S [ + & - ] --------------

error_click macro
    sonar_nota D4, 9, k
    call play_nota ;subrutina tocar nota
endm  

corret_click macro ;sonido para cuando se inserta una nota correcta
    sonar_nota C5, 5, k
    call play_nota ;subrutina tocar nota
    sonar_nota F5, 5, k
    call play_nota ;subrutina tocar nota
    sonar_nota G5, 5, k
    call play_nota ;subrutina tocar nota
endm


Ganador macro
    sonar_nota b5, 15, k
    call play_nota ;subrutina tocar nota
endm

;--------------- L O G I S T I C A  G A M E --------------

cambiar_de_turno macro
    cmp turno_jugador, 03
    je reset_turno_jugador
    inc turno_jugador
    jmp cambiar_turno_salir
    
    reset_turno_jugador:
    mov turno_jugador, 0

    cambiar_turno_salir:
endm

mostrar_ronda macro
    mov al, numero_ronda
    add al, 31h
    mov mensaje_numero_ronda, al
    mensaje mensaje_numero_ronda, 28, 45, 1d ; ronda
endm

mostrar_turno macro
    mov al, turno_jugador
    add al, 31h
    mov mensaje_turno_jugador, al
    mensaje mensaje_turno_jugador, 28, 28, 1d ; TURNO JUGADOR 
endm

win macro
    sonar_nota b5, 15, k
    call play_nota ;subrutina tocar nota
endm  

;-----------------  M E N S A J E S -----------------------

mensaje macro Smensaje, filaMsj, columnaMsj, longCad
    mov ah, 13h             ; Funci?n para escribir cadena de texto
    mov al, 0               ; Modo de escritura (0 = solo actualizar caracteres)
    mov bh, 0               ; P?gina de video
    mov bl, 0Fh             ; Atributos de color para el texto
    mov cx, longCad         ; Longitud de la cadena
    mov dh, filaMsj         ; Fila (aproximadamente el centro del cuadrante)
    mov dl, columnaMsj      ; Columna (aproximadamente el centro)
    push ds                 ; La funci?n 13h espera ES:BP como puntero a la cadena
    pop es                  ; as? que igualamos ES a DS
    lea bp, Smensaje        ; Carga la direcci?n de msg1 en BP
    int 10h                 ; Escribe el texto en pantalla
endm

actualizar_barra_vida macro
    mensaje jugador_vida[0], 24, 4, 1d  ;Estado de vida Player1  
    mensaje jugador_vida[1], 24, 26, 1d ;Estado de vida Player2
    mensaje jugador_vida[2], 24, 48, 1d ;Estado de vida Player3
    mensaje jugador_vida[3], 24, 70, 1d ;Estado de vida Player4
endm

;-------------  S O N I D O ---------------------

iniciar_bocina macro
    in al, 61h          ;guardar el estado del parlante
    and al, 11111100b   ;gate2=0, out2=0 (desactivar conexi?n contador 2 con el altavoz)
    mov spk, al
endm

sonar_nota macro tono, durac, k
    mov cx, tono         ; obtenemos la frecuencia de la nota
    mov ax, durac        ; obtenemos la duraci?n de la nota
    mov k, ax
endm

apagar_bocina macro
    mov al, spk         ; apagar y desconectar
    and al, 11111100b   ; parlante del canal 2 del 8254
    out 61h, al
    ret
endm


;------------ F I N  D E  M A C R O S ---------------

.data
    x  dw 320
    y  dw 240
    
    py dw 0
    px dw 0
    
    eleccion_temp db 00
    
    vivo equ 03h
    muerto equ 58H
    
    numero_jugadores dw 00h
    turno_jugador    db 00h
    jugador_vida     db 58h, 58h, 58h, 58h
    
    numero_click     db 00
    numero_ronda     db 00h
    
    save_pos         dw 0
    save             db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

    click_note dw 196 
    
    C5 dw 523             
    F5 dw 698             
    G5 dw 783             
    B5 dw 987
    E6 dw 1318
    D6 dw 1174
    D4 dw 294
    CS4 dw 277
    C4 dw 261
    B4 dw 493

    buffer db 0

    
    
.code
PRINCIPAL PROC FAR
    MOV AX, @data
    MOV DS, AX
   ;--------------
    MOV ah, 00h
    MOV al, 12h 
    MOV bh, 00h   ;pag0, color negro
    INT 10h
    
    MOV ah, 0bh
    MOV bh, 00h
    
    ;Cuadros de color    
    cuadro 04h, 030AH, 0C27H ;Rojo
    cuadro 02H, 0327H, 0C45H ;Verde
    cuadro 01H, 0C0AH, 1527H ;Azul
    cuadro 06H, 0C27H, 1545H ;Amarillo
    int 10h
   
    MOV numero_jugadores, 4
    MOV turno_jugador, 0
    MOV SI, 0
    
;---------  V I D A  D E  P L A Y E R S -----------
ciclo_numero_jugadores:
    MOV al, vivo
    MOV jugador_vida[si], al
    INC si
    CMP si, numero_jugadores
    JL ciclo_numero_jugadores
    
    mensaje mensaje_turno_j1, 23, 0, 9d   ;VIDA Player 1
    mensaje mensaje_turno_j2, 23, 22, 9d  ;VIDA Player 2
    mensaje mensaje_turno_j3, 23, 44, 9d  ;VIDA Player 3
    mensaje mensaje_turno_j4, 23, 66, 9d  ;VIDA Player 4  
    actualizar_barra_vida
    mensaje mensaje_turno, 28, 01, 26d     ; MENSAJE TURNO
    mensaje mensaje_ronda, 28, 35, 7d 
    
    
    
    call ini_mou
    
     ;Muestra puntero de mouse
    mov ax, 01h
    int 33h
    
    ;Ubica el mouse
    mov ax, 04h
    mov cx, x
    mov dx, y 
    int 33h

;------------CICLO DE INICIADO DE CURSOR------------------------    
    mov si, 0
inicio_de_turno:
    mostrar_turno
    mostrar_ronda
    
    mov numero_click, 0
    
    cursor:
    mov ax, 03h
    int 33h
    cmp bx, 1 ; DETECTA QUE SE DA UN CLICK IZQUIERDO
    je continuar
    jmp cursor
    
    ;---------------------
    ;CUANDO SE DETECTA UN CLICK DERECHO LLEGA AQU?
    ;---------------------
    
    bandera_de_salida:
    apagar_bocina
    jmp salir
    
    ;---------------------
    ;CUANDO SE DETECTA UN CLICK IZQUIERDO LLEGA AQU?
    ;---------------------
    
continuar:
    mov pos_x, cx
    mov pos_y, dx
    cambiar_color pos_x, pos_y
    
    cmp save[si], 0
    je registrar_color
    
    mov al, save[si]
    cmp eleccion_temp, al
    je eleccion_correcta_yei
    
    paso_para_cambiar_intento1:
    error_click
    dec numero_jugadores
    mov al, turno_jugador
    mov ah, 0
    mov di, ax
    mov jugador_vida[di], 58h
    jmp cambiar_de_turno_jmp
    
    eleccion_correcta_yei:
    correct_click ;SONIDO de tururu
    jmp finalizar_click
    
registrar_color:
    new_color_click
    mov al, eleccion_temp
    mov save[si], al
    inc save_pos
    jmp cambiar_de_turno_jmp
    
finalizar_click:
    cmp si, save_pos ; SE CHEQUEA SI YA PASARON LOS 10 TURNOS
    je cambiar_de_turno_jmp
    inc si
    reset_color
    int 10h ; sin esto el reset color mata el c?digo
    jmp inicio_de_turno ;----REINICIO DE LA RONDA
    
cambiar_de_turno_jmp:
    actualizar_barra_vida
    cambiar_de_turno
    mov al, turno_jugador
    mov ah, 0
    mov di, ax
    cmp jugador_vida[di], 58h
    je cambiar_de_turno_jmp   
    mov si, 0 ; reiniciamos el contador del arreglo

    cmp save_pos, 30
    je reiniciamos_save_pos

return_reiniciamos_save_pos:
    cmp numero_jugadores, 1
    je terminar_game

    jmp inicio_de_turno

reiniciamos_save_pos:
    mov save_pos, 29
    jmp return_reiniciamos_save_pos

terminar_game:
    b5 dw 988 ; Frecuencia de sonido correspondiente a la nota B5
    win
    mov al, turno_jugador
    add mensaje_jugador_ganador, al
    mensaje mensaje_jugador_ganador, 28, 63, 1d ; TURNO JUGADOR
cursor2:
    mensaje mensaje_ganador, 28, 35, 25d ; TURNO JUGADOR
    mov ax, 03h
    int 33h
    cmp bx, 2 ;detecta clic derecho y sale del programa
    je bandera_de_salida2
    jmp cursor2

bandera_de_salida2:
    apagar_bocina
    jmp salir

salir:
    mov ax, 02h ; oculto el rat?n
    int 33h
    mov ah, 00h
    mov al, 03h
    int 10h
    
    ;---------------------
    ;Salir del DOS
    ;---------------------
    
    mov ax, 4C00H
    int 21H  
    
    
PRINCIPAL ENDP 


ini_mou proc
    mov ax, 00h
    int 33h
    cmp al, 00h 
    je salir
    ret
ini_mou endp

play_nota proc
    mov dx, 12h ;fc= 1193180 = 1234DCh
    mov ax, 34DCh ;calcular valor de N
    div cx ;en cx est? el per?odo N = fc / fn => dx:ax / cx -> N = ax
    mov dx, ax ;dx <= N

    mov al, 0B6h ; configurar 8254 (palabra de control -> 0B6h)
    out 43h, al ; carga de la configuraci?n en el temporizador 8254

    mov dx, ax ;dx <= N

    mov al, 0B6h 
    out 43h, al
    mov al, dl
    out 42h, al
    mov al, dh
    out 42h, al

    mov al, spk
    or al, 00000011b
    out 61h, al
    call retardo

    mov al, spk
    and al, 11111100b
    out 61h, al
    mov k, espacio
    call retardo
    ret
play_nota endp

tic proc
    mov ah, 0
    int 01ah
    ret
tic endp

retardo proc
    push cx
    call tic
    add dx, k ;modificar tic
    mov ktic, dx
r10:
    call tic
    cmp dx, ktic
    jne r10
    pop cx
    ret
retardo endp 

end PRINCIPAL

    

        

    