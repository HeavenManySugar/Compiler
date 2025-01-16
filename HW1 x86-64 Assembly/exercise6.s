.text
    .globl main

isqrt:
        xorq    %rax, %rax      
        movq    $1, %rcx        
        jmp     T1
L1:     incq    %rax
        leaq    1(%rcx, %rax, 2), %rcx
T1:     cmpq    %rdi, %rcx      
        jle     L1
        ret

main:
    .local n
    .equ n, -8
    push %rbp
    movq %rsp, %rbp
    sub $32, %rsp
    movq $0, n(%rbp)        
loop:
    movq n(%rbp), %rdi
    call isqrt
    # print
    movq $format, %rdi
    movq n(%rbp), %rsi
    movq %rax, %rdx
    movq $0, %rax
    call printf

    incq n(%rbp)
    cmpq $20, n(%rbp)
    jle loop

    xor %rax, %rax
    movq %rbp, %rsp
    pop %rbp
    ret

.data
format:
    .string "sqrt(%2d) = %2d\n"
    
    .section .note.GNU-stack,"",@progbits
