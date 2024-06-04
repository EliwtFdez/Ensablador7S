.model small
.stack 100H
.data
    x dw 320
    y dw 240   

    WELCOME_MSG DB 'Welcome to game$', 0
    PLAY_MSG    DB 'PLAY!$', 0
    MODE_TEXT   EQU 03h
    MODE_GRAPH  EQU 13h
    
    PROGRAM_PATH DB 'C:\Users\EliwtFdez\Desktop\GameEnsamblador\TONEGAME.exe', 0
    GAME_PATH DB 'C:\Users\EliwtFdez\Desktop\GameEnsamblador\JUEGO.exe', 0
    
.code

VIDEO_INT    EQU 13h   ; Video BIOS interrupt number
MOUSE_INT    EQU 33h   ; Mouse service interrupt

CUADRO MACRO XI,YI,XF,YF,COLOR
    MOV AX, 0600H
    MOV BH, COLOR
    MOV BL, 13H
    MOV CH, YI
    MOV CL, XI
    MOV DH, YF
    MOV DL, XF
    INT 10h
ENDM
POSICION MACRO X,Y
    MOV DH, Y
    MOV DL, X
    MOV AH, 02H
    MOV BH, 00
    INT 10H
ENDM
DESPLEGAR MACRO MENSAJE
    MOV AH, 09
    MOV DX, OFFSET MENSAJE
    INT 21h
ENDM
CUADROSCOMBINADOS MACRO
    POSICION 12,00  
    DESPLEGAR WELCOME_MSG  
    CUADRO 5,5,30,9,71
    POSICION 16,7
    DESPLEGAR PLAY_MSG
ENDM

SET_VIDEO_MODE MACRO mode
    MOV AH, 00
    MOV AL, mode
    INT 10H
ENDM

LOAD_AND_EXECUTE MACRO
    MOV DX, OFFSET PROGRAM_PATH  ; Direcci?n de la cadena que contiene la ruta del programa
    MOV AL, 1                    ; Carga y ejecuci?n del programa
    MOV AH, 4Bh                  ; Servicio DOS para cargar y ejecutar
    INT 21h                      ; Interrupci?n de DOS
    JC ERROR_LOADING             ; Saltar si hay un error
    RET

ERROR_LOADING:  ;como un trycach
    RET
ENDM

main proc far
    MOV AX, @data
    MOV DS, AX
    ;------------
    mov ah, 0bh
    mov bh, 00h
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

    SET_VIDEO_MODE MODE_GRAPH
    
    CUADROSCOMBINADOS
    
    ; Por simplicidad, asumiremos que el usuario clickea correctamente para ejecutar el programa
    LOAD_AND_EXECUTE 
    
    SET_VIDEO_MODE MODE_TEXT

    
    
    
    MOV AX, 4C00h
    INT 21h
main endp

end main
