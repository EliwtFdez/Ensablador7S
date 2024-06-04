model Small
.stack 64

.data
    espacio equ 1 ;Tiempo entre notas
    durac dw 1
    tono dw 130 
    spkOld  db 0 ;Estado del parlante
    ktic    dw 0 ;Tic del sistema
    k       dw 0 ;Control de retardo
    ;cont dw 24
.code

main proc NEAR
    mov ax, @data
    mov ds, ax
    
    in al, 61h ;Guardar el estado del parlante
    and al, 11111100b ;Gate2=0, Out2=0 (desactivar conexi?n contador 2 con el altavoz)
    mov spkOld, al
    
    ;---------------------------------------------------------
    mov cx, tono    ; obtenemos la frecuencia de la nota
    mov ax, durac   ;obtenemos la duracion de la nota
    mov k, ax   
    call play_nota  ;subrutina tocar nota
    
    mov al, spkOld     ; Apagar y desconectar
    and al, 11111100b  ;parlante del canal 2 del 8254
    out 61h, al
    ret
    main endp
    ;---------------------------------------------------------
    
    play_nota proc
    mov dx, 12h         ; fc = 1193180 = 1234DCh
    mov ax, 34DCh       ; Calcular valor de N
    div cx              ; En CX esta el periodo N = fc/fn => dx:ax/cx -> N = ax
    mov dx, ax          ; dx <= N
    
    mov al, 0B6h        ; Configurar el 8254 (palabra de control -> 0B6h)
    out 43h, al         ; Carga de la configuracion en el temporizador 8254
    mov al, dl          ; Pasamos el byte bajo del contador N = dh:dl -> dl
    out 42h, al
    mov al, dh          ; Ahora pasamos el byte alto del contador N = dh:dl -> dh
    out 42h, al
    
    mov al, spkOld      ; Encender el parlante
    or al, 00000011b    ; Gate2=1 y Out2=1 (Se habilita la conexion contador 2 con el altavoz)
    out 61h, al
    call retardo
    
    mov al, spkOld      ;Apagamos el parlante
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
        
        ;---------------------------------------------------------
        ;                   RETARDO EN BASE AL TIC
        ;---------------------------------------------------------
    
        
     retardo proc
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
     
     ;---------------------------------------------------------
     ;codigo ends
     end main