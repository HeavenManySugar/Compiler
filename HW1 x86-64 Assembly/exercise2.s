    .text
    .globl main

main:
    # 4 + 6
    mov $4, %r8
    mov $6, %r9
    mov %r8, %r10
    add %r9, %r10
    mov $format, %rdi
    mov %r10, %rsi
    mov $0, %rax
    sub $8, %rsp
    call printf
    add $8, %rsp
    # 21 * 2
    mov $21, %r8
    mov $2, %r9
    mov %r9, %r10
    imul %r8, %r10
    mov $format, %rdi
    mov %r10, %rsi
    mov $0, %rax
    sub $8, %rsp
    call printf
    add $8, %rsp
    # 4 + 7 / 2
    mov $4, %r8
    mov $7, %r9
    mov $2, %r10
    mov %r9, %rax
    idiv %r10
    mov %rax, %r11
    add %r8, %r11
    mov $format, %rdi
    mov %r11, %rsi
    mov $0, %rax
    sub $8, %rsp
    call printf
    add $8, %rsp
    # 3 - 6 * (10 / 5)
    mov $3, %r8
    mov $6, %r9
    mov $10, %r10
    mov $5, %r11
    mov %r10, %rax
    idiv %r11
    mov %rax, %r12
    imul %r9, %r12
    mov %r8, %r13
    sub %r12, %r13
    mov $format, %rdi
    mov %r13, %rsi
    mov $0, %rax
    sub $8, %rsp
    call printf
    add $8, %rsp

    mov $0, %rax
    ret
    .data

format:
    .string "%d\n"

    .section .note.GNU-stack,"",@progbits
