#include <sys/syscall.h>

long syscall(long number, ...);

int _start() {
    const char helloWorld[] = "Hello, World!\n"; 
    syscall(SYS_write, 1, helloWorld, sizeof(helloWorld) - 1);
    syscall(SYS_exit, 0);
}