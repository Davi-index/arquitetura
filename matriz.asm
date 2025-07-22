.section .data
matriz1:    .word 1, 2, 3, 4      @ Primeira matriz 2x2
matriz2:    .word 5, 6, 7, 8      @ Segunda matriz 2x2
msg1:       .asciz "Matriz 1:\n"
msg2:       .asciz "Matriz 2:\n"
format:     .asciz "%d %d\n"

.section .text
.global main
main:
    @ Exibe "Matriz 1:"
    ldr r0, =msg1
    bl printf

    ldr r1, =matriz1
    ldr r2, [r1]          @ linha 1, coluna 1
    ldr r3, [r1, #4]      @ linha 1, coluna 2
    ldr r0, =format
    mov r4, r2
    mov r5, r3
    mov r1, r4
    mov r2, r5
    bl printf

    ldr r2, [r1, #8]      @ linha 2, coluna 1
    ldr r3, [r1, #12]     @ linha 2, coluna 2
    ldr r0, =format
    mov r4, r2
    mov r5, r3
    mov r1, r4
    mov r2, r5
    bl printf

    @ Exibe "Matriz 2:"
    ldr r0, =msg2
    bl printf

    ldr r1, =matriz2
    ldr r2, [r1]
    ldr r3, [r1, #4]
    ldr r0, =format
    mov r4, r2
    mov r5, r3
    mov r1, r4
    mov r2, r5
    bl printf

    ldr r2, [r1, #8]
    ldr r3, [r1, #12]
    ldr r0, =format
    mov r4, r2
    mov r5, r3
    mov r1, r4
    mov r2, r5
    bl printf

    mov r7, #1      @ syscall exit
    mov r0, #0
    svc #0

.extern printf