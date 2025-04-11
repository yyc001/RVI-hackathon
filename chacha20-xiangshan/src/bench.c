#include <textio.h>
#include "chacha20.h"

#ifndef SEED
#define SEED 0xdeadbeef
#endif

#ifndef BENCH_LEN
#define BENCH_LEN 128
#endif

unsigned long rdcycle() {
#ifdef __riscv
    unsigned long res;
    asm volatile ("rdcycle %0" : "=r" (res));
    return res;
#else
    return 0;
#endif
}

#define BUF_LEN 1024

chacha_buf buf[BUF_LEN]  __attribute__((aligned(16))) ;

void gen_chacha_state(u32 *state, u32 seed) {
    u32 buf[16]  __attribute__((aligned(16))) ;
    for (int i = 0; i < 16; i++)
        buf[i] = seed ^ i;
    chacha20((chacha_buf *)state, buf);
}
// #include <stdint.h>
// uint64_t get_vlmax() {
//     uint64_t vlmax;
//     // 设置 vtype 并请求最大元素数（avl = -1 表示请求 VLMAX）
//     asm volatile (
//         "vsetvli %0, %1, e32, m1, ta, ma"
//         : "=r" (vlmax)                // 输出到 vlmax
//         : "r" (-1)
//         : /* 无 Clobbers */
//     );
//     return vlmax;
// }
void run_benchmark(u32 len, u32 seed) {
    // print_s("RVV e32m1 VLMAX=");print_long(get_vlmax());print_s("\n");
    u32 state[16]  __attribute__((aligned(16))) ;
    gen_chacha_state(state, seed);
    print_s("Initial state generated for LEN=");
    print_long(len);
    print_s(" SEED=");
    print_hex32(seed);
    unsigned long start = rdcycle();
    for (int i = 0; i < len; i++) {
        chacha20(&buf[i%BUF_LEN], state);
        state[15] ++;
    }
    unsigned long end = rdcycle();
    unsigned long cycles = end - start;
    print_s("Cycles: ");
    print_long(cycles);
    print_s("\n");
    print_s("Final output: \n");
    for (int i = 0; i < 16; i++) {
        print_s("ans[");
        print_long(i);
        print_s("] = ");
        print_hex32(buf[(len-1)%BUF_LEN].u[i]);
    }
}

// void view(u32 seed) {
//     print_s("RVV e32m1 VLMAX=");print_long(get_vlmax());print_s("\n");
//     u32 state[16]  __attribute__((aligned(16))) ;
//     chacha_buf result  __attribute__((aligned(16))) ;
//     for (int i = 0; i < 16; i++) state[i] = seed ^ i;
//     print_s("Initial state: \n");
//     for (int i = 0; i < 16; i++) {
//         print_s("state[");
//         print_long(i);
//         print_s("] = ");
//         print_hex32(state[i]);
//     }
//     chacha20(&result, state);
//     print_s("Chacha1 state: \n");
//     for (int i = 0; i < 16; i++) {
//         print_s("result[");
//         print_long(i);
//         print_s("] = ");
//         print_hex32(result.u[i]);
//     }
// }

int main() {
    print_s("Test Start!\n");
    // view(SEED);
    run_benchmark(BENCH_LEN, SEED);
    return 0;
}
