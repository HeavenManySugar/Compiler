    .text
    .globl main

main:
    push %rbp
    movq %rsp, %rbp 
    # let y = x * x
    mov x(%rip), %r8d
    imul %r8d, %r8d
    mov %r8d, y(%rip)
    
    # y + x
    mov y(%rip), %r8d
    mov x(%rip), %r9d
    add %r9d, %r8d

    mov $format, %rdi
    mov %r8d, %esi
    mov $0, %rax
    call printf

    pop %rbp
    mov $0, %rax
    ret
    .data
    x:
        .int 2
    y:
        .int 0
format:
    .string "%d\n"

    .section .note.GNU-stack,"",@progbits
