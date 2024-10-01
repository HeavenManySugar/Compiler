    .text
    .globl main

print_bool:
    push %rbp
    movq %rsp, %rbp
    cmp $0, %rax
    jne true
    mov $false_str, %rdi
    jmp print_bool_end
true:
    mov $true_str, %rdi
print_bool_end:
    mov $0, %rax
    call printf
    mov $0, %rax
    pop %rbp
    ret

main:
    # true && false
    mov $1, %r8
    mov $0, %r9
    and %r8, %r9
    mov %r9, %rax
    call print_bool

    # if 3 <> 4 then 10 * 2 else 14
    mov $3, %r8
    mov $4, %r9
    cmp %r9, %r8
    jne if_true
    mov $format, %rdi
    mov $14, %rsi
    jmp if_end
    if_true:
    mov $format, %rdi
    mov $10, %r10
    mov $2, %r11
    imul %r10, %r11
    mov %r11, %rsi
    if_end:
    call printf

    # 2 = 3 || 4 <= 2 * 3
    mov $2, %r8
    mov $3, %r9
    mov $4, %r10
    mov $2, %r11
    mov $3, %r12
    cmp %r9, %r8
    je or_true
    cmp %r10, %r8
    jle or_true
    mov $0, %rax
    jmp or_end
    or_true:
    mov $1, %rax
    or_end:
    call print_bool

    mov $0, %rax
    ret

    .data
true_str:
    .string "true\n"

false_str:
    .string "false\n"

format:
    .string "%d\n"