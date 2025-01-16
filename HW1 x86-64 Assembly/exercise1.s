    .text
    .globl main

main:
    mov $format, %rdi
    sub $8, %rsp
    mov $42, %rsi
    mov $0, %rax
    call printf
    add $8, %rsp
    mov $0, %rax
    ret
    .data

format:
    .string "n = %d\n"

    .section .note.GNU-stack,"",@progbits
    