section .data
    ; Matrizes A e B (2x2)
    A dd 1, 2
      dd 3, 4

    B dd 5, 6
      dd 7, 8

    ; Mensagem de cabeçalho
    msg db "Resultado da soma das matrizes:", 0xA, 0
    msg_len equ $ - msg

section .bss
    ; Matriz Resultante R
    R resd 4

    ; Buffer para conversão de número em string (máx 10 dígitos + newline + null)
    num_str resb 12

section .text
    global _start

_start:
    ; -------------------
    ; Soma as matrizes
    ; -------------------
    mov esi, A
    mov edi, B
    mov ebx, R
    mov ecx, 4

soma_loop:
    mov eax, [esi]
    add eax, [edi]
    mov [ebx], eax

    add esi, 4
    add edi, 4
    add ebx, 4

    loop soma_loop

    ; -------------------
    ; Escreve cabeçalho
    ; -------------------
    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, msg_len
    int 0x80

    ; -------------------
    ; Escreve os 4 valores da matriz R
    ; -------------------
    mov esi, R        ; ponteiro para matriz R
    mov ecx, 4        ; número de elementos

print_loop:
    mov eax, [esi]    ; carrega valor
    call int_to_str   ; converte para string em num_str

    ; syscall write para mostrar string
    mov eax, 4
    mov ebx, 1
    mov ecx, num_str
    mov edx, eax      ; tamanho da string foi retornado em EAX pela função
    int 0x80

    add esi, 4
    loop print_loop

    ; fim do programa - exit(0)
    mov eax, 1
    xor ebx, ebx
    int 0x80

; -------------------------------
; Função: int_to_str
; Entrada: EAX = número inteiro
; Saída: converte número para string em num_str
; Retorna em EAX o comprimento da string (com \n)
; -------------------------------
int_to_str:
    push eax
    push ebx
    push ecx
    push edx

    mov ecx, 10         ; base decimal
    mov edi, num_str+10 ; final do buffer
    mov byte [edi], 0xA ; newline

    dec edi

    cmp eax, 0
    jnz .convert

    mov byte [edi], '0'
    dec edi
    jmp .done

.convert:
    xor edx, edx

.next_digit:
    div ecx
    add dl, '0'
    mov [edi], dl
    dec edi
    xor edx, edx
    cmp eax, 0
    jne .next_digit

.done:
    inc edi
    mov esi, edi
    mov ecx, num_str

.copy_loop:
    mov al, [esi]
    mov [ecx], al
    inc esi
    inc ecx
    cmp al, 0xA
    jne .copy_loop

    mov eax, ecx
    sub eax, num_str    ; retorna comprimento da string em EAX

    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
; Fim do programa