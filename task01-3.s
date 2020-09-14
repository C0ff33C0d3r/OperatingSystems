.intel_syntax noprefix
.global _start
.text
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

    // Read all the text (hope there is enough memory)
    xor rax, rax
    xor rdi, rdi
    mov rdx, buf_size
    syscall

    // Put address of the last character into EDI
    mov rdi, rsi 
    add rdi, rax

    // Prepare counter register
    xor rdx, rdx

    // Loop that looks for end of line and prints out the line
reverse_print_loop:
    cmp rdi, rsi
    je loop_end

    mov al, byte ptr [edi]
    cmp al, '\n'
    je print_line
    inc rdx
    dec rdi


print_line:
    mov rax, 1
    inc rdi
    

    jmp reverse_print_loop
loop_end:

    // Exit
    mov rax, sys_exit
    xor rdi, rdi
    syscall