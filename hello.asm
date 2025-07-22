section .data
    msg db "Hello, World!", 0xA  ; Mensagem + newline
    len equ $ - msg              ; Calcula tamanho da mensagem

section .text
    global _start

_start:
    ; syscall: write(int fd, const void *buf, size_t count)
    mov eax, 4       ; syscall número 4 = sys_write
    mov ebx, 1       ; file descriptor 1 = stdout
    mov ecx, msg     ; ponteiro para a mensagem
    mov edx, len     ; tamanho da mensagem
    int 0x80         ; chamada de sistema

    ; syscall: exit(int status)
    mov eax, 1       ; syscall número 1 = sys_exit
    xor ebx, ebx     ; código de saída 0
    int 0x80         ; chamada de sistema
    ; Fim do programa