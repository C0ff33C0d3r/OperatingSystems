#include <sys/syscall.h>
#include <unistd.h>

long syscall(long number, ...);

const size_t BUF_SIZE = 10 * 1024 * 1024; // 10 Mb of data

void _start()
{
    char* buffer = (char*)syscall(SYS_brk, 0); // Get old heap break;
    syscall(SYS_brk, buffer + BUF_SIZE);

    ssize_t result = BUF_SIZE;

    while (result == BUF_SIZE) {
        result = syscall(SYS_read, 0, buffer, BUF_SIZE);
        syscall(SYS_write, 1, buffer, result);
    }

    syscall(SYS_exit, 0);
}