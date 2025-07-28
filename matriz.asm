section .data
    matA:   dd 1, 2, 3, 4         
    matB:   dd 5, 6, 7, 8         
    res:    dd 0, 0, 0, 0         

    texto_inicio: db "Resultado da soma:", 10
    tam_texto_inicio: equ $ - texto_inicio

    espaco: db " ", 0
    nova_linha: db 10

    buffer: times 12 db 0    

section .text
    global _start

_start:
    mov esi, 0

soma_loop:
    mov eax, [matA + esi*4]
    add eax, [matB + esi*4]
    mov [res + esi*4], eax
    inc esi
    cmp esi, 4
    jl soma_loop

    mov eax, 4          
    mov ebx, 1         
    mov ecx, texto_inicio
    mov edx, tam_texto_inicio
    int 0x80

    xor esi, esi    

print_loop:
    mov eax, [res + esi*4]
    push esi
    call int_to_ascii
    pop esi

    mov edx, eax 
    mov eax, 4
    mov ebx, 1
    mov ecx, buffer
    int 0x80

    cmp esi, 1
    je print_newline
    cmp esi, 3
    je print_newline

    mov eax, 4
    mov ebx, 1
    mov ecx, espaco
    mov edx, 1
    int 0x80
    jmp continuar

print_newline:
    mov eax, 4
    mov ebx, 1
    mov ecx, nova_linha
    mov edx, 1
    int 0x80

continuar:
    inc esi
    cmp esi, 4
    jl print_loop

    mov eax, 1   
    xor ebx, ebx
    int 0x80

int_to_ascii:
    mov ecx, 10
    mov edi, buffer + 11 
    mov byte [edi], 0

    mov ebx, 0          

.convert:
    xor edx, edx
    div ecx
    add dl, '0'
    dec edi
    mov [edi], dl
    inc ebx
    test eax, eax
    jnz .convert

    mov esi, edi
    mov edi, buffer
    mov ecx, ebx

.copy:
    mov al, [esi]
    mov [edi], al
    inc esi
    inc edi
    loop .copy

    mov eax, ebx  
    ret
