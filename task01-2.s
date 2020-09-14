    .intel_syntax noprefix
    .text
    .global _start
_start:
    sys_write = 1
    sys_brk = 12
    sys_exit = 60

    buf_size = 10 * 1024 * 1024

    // Get current heap break
    mov rax, sys_brk
    xor rdi, rdi
    syscall

    // Preserve address
    mov rsi, rax 

    // Allocate buffer
    mov rdi, rax
    add rdi, buf_size
    mov rax, sys_brk
    syscall

    // Read-write loop
    rwloop:
    xor rax, rax 
    xor rdi, rdi 
    mov rdx, buf_size 
    syscall

    mov rdx, rax  
    mov rax, sys_write
    mov rdi, 1 
    syscall

    cmp rdx, 0
    jne rwloop

    // Exit
    mov rax, sys_exit
    xor rdi, rdi
    syscall
