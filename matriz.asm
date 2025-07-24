.section .data
matriz1:    .word 1, 2, 3, 4      @ Primeira matriz 2x2 (elementos em ordem linear)
matriz2:    .word 5, 6, 7, 8      @ Segunda matriz 2x2 (elementos em ordem linear)
msg1:       .asciz "Matriz 1:\n"  @ Mensagem para exibir antes da matriz 1
msg2:       .asciz "Matriz 2:\n"  @ Mensagem para exibir antes da matriz 2
format:     .asciz "%d %d\n"      @ Formato para imprimir duas colunas

.section .text
.global main
main:
    @ Exibe "Matriz 1:"
    ldr r0, =msg1                 @ Carrega endereço da mensagem msg1 em r0
    bl printf                     @ Chama printf para exibir msg1

    @ Exibe primeira linha da matriz 1
    ldr r1, =matriz1              @ Carrega endereço da matriz1 em r1
    ldr r2, [r1]                  @ Carrega elemento [0] (linha 1, coluna 1) em r2
    ldr r3, [r1, #4]              @ Carrega elemento [1] (linha 1, coluna 2) em r3
    ldr r0, =format               @ Carrega endereço do formato em r0
    mov r4, r2                    @ Move valor de r2 para r4 (primeiro argumento)
    mov r5, r3                    @ Move valor de r3 para r5 (segundo argumento)
    mov r1, r4                    @ Prepara r1 para printf (primeiro valor a imprimir)
    mov r2, r5                    @ Prepara r2 para printf (segundo valor a imprimir)
    bl printf                     @ Chama printf para exibir a primeira linha

    @ Exibe segunda linha da matriz 1
    ldr r2, [r1, #8]              @ Carrega elemento [2] (linha 2, coluna 1) em r2
    ldr r3, [r1, #12]             @ Carrega elemento [3] (linha 2, coluna 2) em r3
    ldr r0, =format               @ Carrega endereço do formato em r0
    mov r4, r2                    @ Move valor de r2 para r4
    mov r5, r3                    @ Move valor de r3 para r5
    mov r1, r4                    @ Prepara r1 para printf
    mov r2, r5                    @ Prepara r2 para printf
    bl printf                     @ Chama printf para exibir a segunda linha

    @ Exibe "Matriz 2:"
    ldr r0, =msg2                 @ Carrega endereço da mensagem msg2 em r0
    bl printf                     @ Chama printf para exibir msg2

    @ Exibe primeira linha da matriz 2
    ldr r1, =matriz2              @ Carrega endereço da matriz2 em r1
    ldr r2, [r1]                  @ Carrega elemento [0] (linha 1, coluna 1) em r2
    ldr r3, [r1, #4]              @ Carrega elemento [1] (linha 1, coluna 2) em r3
    ldr r0, =format               @ Carrega endereço do formato em r0
    mov r4, r2                    @ Move valor de r2 para r4
    mov r5, r3                    @ Move valor de r3 para r5
    mov r1, r4                    @ Prepara r1 para printf
    mov r2, r5                    @ Prepara r2 para printf
    bl printf                     @ Chama printf para exibir a primeira linha

    @ Exibe segunda linha da matriz 2
    ldr r2, [r1, #8]              @ Carrega elemento [2] (linha 2, coluna 1) em r2
    ldr r3, [r1, #12]             @ Carrega elemento [3] (linha 2, coluna 2) em r3
    ldr r0, =format               @ Carrega endereço do formato em r0
    mov r4, r2                    @ Move valor de r2 para r4
    mov r5, r3                    @ Move valor de r3 para r5
    mov r1, r4                    @ Prepara r1 para printf
    mov r2, r5                    @ Prepara r2 para printf
    bl printf                     @ Chama printf para exibir a segunda linha

    @ Finaliza o programa
    mov r7, #1                    @ Código da syscall exit
    mov r0, #0                    @ Código de saída 0
    svc #0                        @ Chama o kernel para encerrar o programa

.extern printf                    @ Declara printf como função externa