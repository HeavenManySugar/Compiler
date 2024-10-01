    .text
    .globl main

main:
    mov $format, %rdi
    mov $42, %rsi
    mov $0, %rax
    call printf
    mov $0, %rax
    ret
    .data

format:
    .string "n = %d\n"