#include <memmap.h>

.arch armv8-a
.text
.section ".boot","ax"
.global entry
.type   entry,function
entry:
    ldr     x5, =UART_REG_BASE
begin_print:
    ldr     x0, ='B'
    bl      print
    ldr     x0, ='O'
    bl      print
    ldr     x0, ='O'
    bl      print
    ldr     x0, ='T'
    bl      print
    ldr     x0, ='\n'
    bl      print
    b begin_print

    mov     sp, #0x40000000

print:
    // 发送字符到UART函数
    // 参数: x0 = 字符的ASCII码
    // 等待发送缓冲区空
    1: ldr x1, [x0, #0x14] // 读取UART状态寄存器的寄存器偏移量0x14处
       tst x1, #0x20      // 检查发送缓冲区空位是否为1
       b.eq 1b            // 如果发送缓冲区空位为0，则继续等待
    // 发送字符
    strb w0, [x0, #0x0] // 将字符写入UART数据寄存器的寄存器偏移量0x0处
    ret
