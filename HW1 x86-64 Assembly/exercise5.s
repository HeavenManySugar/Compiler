    .text
    .globl main

main:
    push %rbp
    movq %rsp, %rbp 
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
        movq $3, x(%rbp)
        movq x(%rbp), %r8
        imulq x(%rbp), %r8
        movq $format, %rdi
        movq %r8, %rsi
        movq $0, %rax
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
        movq $3, x(%rbp)
        # let y = x + x
        mov x(%rbp), %r8
        add x(%rbp), %r8
        mov %r8, y(%rbp)

        # let z = x + 3
        movq x(%rbp), %r8
        addq $3, %r8
        movq %r8, z(%rbp)

        # print x * y + z / z
        movq x(%rbp), %r8
        movq y(%rbp), %r9
        imulq %r9, %r8
        movq z(%rbp), %rax
        cqo
        idivq z(%rbp)
        addq %rax, %r8
        movq $format, %rdi
        movq %r8, %rsi
        movq $0, %rax
        call printf

        pop %rsi
        pop %rdi
        mov %rbp, %rsp
        pop %rbp

    pop %rbp
    mov $0, %rax
    ret
    .data
format:
    .string "%d\n"

    .section .note.GNU-stack,"",@progbits
