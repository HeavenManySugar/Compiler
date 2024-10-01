    .text
    .globl main

main:
    # print (let x = 3 in x * x)
    print1:
        .local x
        .equ x, -8
        push %rbp
        mov %rsp, %rbp
        sub $8, %rsp
        push %rdi
        push %rsi

        # let x = 3
        mov $3, x(%rbp)
        mov x(%rbp), %r8
        imul x(%rbp), %r8
        mov $format, %rdi
        mov %r8, %rsi
        mov $0, %rax
        call printf

        pop %rsi
        pop %rdi
        mov %rbp, %rsp
        pop %rbp

    # print (let x = 3 in (let y = x + x in x * y) + (let z = x + 3 in z / z))
    print2:
        .local x, y, z
        .equ x, -8
        .equ y, -16
        .equ z, -24
        push %rbp
        mov %rsp, %rbp
        sub $24, %rsp
        push %rdi
        push %rsi

        # let x = 3
        mov $3, x(%rbp)
        # let y = x + x
        mov x(%rbp), %r8
        add x(%rbp), %r8
        mov %r8, y(%rbp)

        # let z = x + 3
        mov x(%rbp), %r8
        add $3, %r8
        mov %r8, z(%rbp)

        # print x * y + z / z
        mov x(%rbp), %r8
        mov y(%rbp), %r9
        imul %r9, %r8
        mov z(%rbp), %rax
        idiv z(%rbp)
        add %rax, %r8
        mov $format, %rdi
        mov %r8, %rsi
        mov $0, %rax
        call printf

        pop %rsi
        pop %rdi
        mov %rbp, %rsp
        pop %rbp


    mov $0, %rax
    ret
    .data
format:
    .string "%d\n"