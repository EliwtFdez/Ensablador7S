.model Small
.stack 100H
.data
    espacio equ 1
    duraciones dw 1, 1, 12, 12, 8, 8, 1, 1, 12, 12, 14, 14, 1, 12
    tonos dw 2273, 2025, 1805, 1136, 956, 1073, 1204, 1276, 1351
    spkOld db 0
    ktic dw 0
    k dw 0
    numNotas db 26

.code

main proc near
    mov ax, @data
    mov ds, ax

    in al, 61h
    and al, 11111100b
    mov spkOld, al

    xor si, si     ; Indice para las notas
    
loop_notas: 
    
    mov bx, offset tonos      ; Obtener direcci?n base de tonos
    add bx, si                ; A?adir desplazamiento calculado
    mov cx, [bx]              ; Cargar frecuencia en CX

    mov bx, offset duraciones ; Obtener direcci?n base de duraciones
    add bx, si                ; A?adir desplazamiento calculado
    mov ax, [bx]              ; Cargar duraci?n en AX
    mov k, ax
    call play_nota            ; Tocar la nota

    add si, 2                 ; Incrementar si por el tama?o de la palabra (correcto)
    mov bl, numNotas          ; Cargar el n?mero de notas en BL
    xor bh, bh                ; Limpiar el byte alto de BX
       
    shl bx, 1                 ; Multiplicar por 2 para obtener el l?mite superior correcto
    cmp si, bx
    jl loop_notas             ; Repetir hasta que se toquen todas las notas

    mov al, spkOld            ; Restablecer estado del parlante
    out 61h, al
    ret
main endp

play_nota proc
    mov dx, 12h               ; fc = 1193180 = 1234DCh
    mov ax, 34DCh             ; Calcular valor de N
    div cx                    ; En CX est? el periodo N = fc/fn => dx:ax/cx -> N = ax
    mov dx, ax                ; dx <= N

    mov al, 0B6h              ; Configurar el 8254 (palabra de control -> 0B6h)
    out 43h, al               ; Carga de la configuraci?n en el temporizador 8254
    mov al, dl                ; Pasamos el byte bajo del contador N = dh:dl -> dl
    out 42h, al
    mov al, dh                ; Ahora pasamos el byte alto del contador N = dh:dl -> dh
    out 42h, al

    mov al, spkOld            ; Encender el parlante
    or al, 00000011b          ; Gate2=1 y Out2=1 (Se habilita la conexi?n contador 2 con el altavoz)
    out 61h, al
    call retardo

    mov al, spkOld            ; Apagamos el parlante
    and al, 11111100b
    out 61h, al
    mov k, espacio
    call retardo
    ret
play_nota endp

; Otras subrutinas existentes (tic, retardo, etc.)
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

end main
