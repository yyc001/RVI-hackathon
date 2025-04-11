/* main.c */
#define exit(v) asm volatile("mv a0, %0\n\t ebreak" :: "r"(v) : "a0")
#define putch(ch) asm volatile("mv a0, %0\n\t ecall" :: "r"(ch) : "a0")
#define assert(cond) do { if (!(cond)) exit(10); } while (0)

void main();

// 汇编启动代码
__attribute__((naked, section(".text.boot"))) void _boot() {
    asm volatile(
        "la sp, _stack_end\n\t"  // 强制设置栈指针
        "j main"               // 跳转到主入口
    );
}

volatile int mem[4]; // 用于测试 lw/sw

void main() {
    int a = 5, b = 3, c;

    // 算术和逻辑指令
    putch('0');
    assert((a + b) == 8);        // add
    assert((a - b) == 2);        // sub
    assert((a << 2) == 20);      // sll
    assert(((unsigned)a) >> 1 == 2);   // srl
    assert(((-a) >> 1) == -3);   // sra (算术右移)
    assert((a ^ b) == 6);        // xor
    assert((a | b) == 7);        // or
    assert((a & b) == 1);        // and

    // 立即数指令
    putch('1');
    assert((a + 10) == 15);      // addi
    assert((a ^ 7) == 2);        // xori
    assert((a | 7) == 7);        // ori
    assert((a & 7) == 5);        // andi
    assert((a << 1) == 10);      // slli
    assert(((unsigned)a) >> 1 == 2);  // srli
    assert(((-a) >> 2) == -2);   // srai

    // 比较指令
    putch('2');
    assert((a < b) == 0);        // slt
    assert(((unsigned)a < (unsigned)b) == 0); // sltu

    // 条件跳转逻辑（手动模拟）
    putch('3');
    if (a == b) assert(0);       // beq false
    if (a != b) assert(1);       // bne true
    if (a < b)  assert(0);       // blt false
    if (a >= b) assert(1);       // bge true

    // 内存访问
    putch('4');
    mem[0] = a;                  // sw
    c = mem[0];                  // lw
    assert(c == 5);

    // LUI / AUIPC 验证只检查能执行（结果机器相关）
    putch('5');
    int x;
    asm volatile("lui %0, 0x12345" : "=r"(x));
    assert((x & 0xFFFFF000) == 0x12345000);

    asm volatile("auipc %0, 0" : "=r"(x)); // 不验证值，只看能否执行

    // JAL 测试
    putch('6');
    int ret = 0;
    asm volatile(
        "jal ra, 1f\n"
        "li %0, 99\n"        // 不应执行
        "1:\n"
        "li %0, 42\n"        // 正确路径
        : "=r"(ret));
    assert(ret == 42);

    // JALR 测试
    putch('7');
    asm volatile(
        "auipc t0, 0\n"
        "addi t0, t0, 16\n"
        "jalr zero, t0, 0\n"
        "li %0, 99\n"        // 不应执行
        : "=r"(c));

    putch('8');
    exit(0); // 正常结束
}