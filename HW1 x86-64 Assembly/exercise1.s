    .text
    .globl main

main:
    push %rbp
    movq %rsp, %rbp 
    mov $format, %rdi
    mov $42, %rsi
    mov $0, %rax
    call printf
    pop %rbp
    mov $0, %rax
    ret
    .data

format:
    .string "n = %d\n"

    .section .note.GNU-stack,"",@progbits
    