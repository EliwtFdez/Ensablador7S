model small
.stack 100h

.data
message1 db 'HOLA $'
message2 db 'ADIOS $'

.code

print_message macro mensaje
    mov ah, 09h         
    lea dx, mensaje     
    int 21h             
endm

start:
    mov ax, @data       
    mov ds, ax

    ; Imprimir el primer mensaje
    print_message message1

    ; Imprimir el segundo mensaje
    print_message message2

    mov ah, 4Ch         
    int 21h             
end start