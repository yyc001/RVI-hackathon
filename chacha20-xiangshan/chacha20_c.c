/*
 * Copyright 2015-2020 The OpenSSL Project Authors. All Rights Reserved.
 *
 * Licensed under the Apache License 2.0 (the "License").  You may not use
 * this file except in compliance with the License.  You can obtain a copy
 * in the file LICENSE in the source distribution or at
 * https://www.openssl.org/source/license.html
 */

/* Adapted from the public domain code by D. Bernstein from SUPERCOP. */

#include <chacha20.h>
#include <textio.h>

# define ROTATE(v, n) (((v) << (n)) | ((v) >> (32 - (n))))

/* QUARTERROUND updates a, b, c, d with a ChaCha "quarter" round. */
# define QUARTERROUND(a,b,c,d) ( \
x[a] += x[b], x[d] = ROTATE((x[d] ^ x[a]),16), \
x[c] += x[d], x[b] = ROTATE((x[b] ^ x[c]),12), \
x[a] += x[b], x[d] = ROTATE((x[d] ^ x[a]), 8), \
x[c] += x[d], x[b] = ROTATE((x[b] ^ x[c]), 7)  )

/* chacha_core performs 20 rounds of ChaCha on the input words in
 * |input| and writes the 64 output bytes to |output|. */
void chacha20(chacha_buf *output, const u32 input[16])
{
    #ifdef __riscv
    void chacha20v(chacha_buf *output, const u32 input[16]);
    chacha20v(output, input);
    return;
    #endif

    u32 x[16];
    int i;

    for (int i = 0; i < 16; i++) {
        x[i] = input[i];
    }

    for (i = 20; i > 0; i -= 2) {
        QUARTERROUND(0, 4, 8, 12);
        QUARTERROUND(1, 5, 9, 13);
        QUARTERROUND(2, 6, 10, 14);
        QUARTERROUND(3, 7, 11, 15);

        QUARTERROUND(0, 5, 10, 15);
        QUARTERROUND(1, 6, 11, 12);
        QUARTERROUND(2, 7, 8, 13);
        QUARTERROUND(3, 4, 9, 14);
    }

    for (i = 0; i < 16; ++i)
        output->u[i] = x[i] + input[i];
}

#ifdef __riscv
void print_vec(u32 *a) {
    for (int i = 0; i < 16; i++) {
        print_s("v[");
        print_long(i);
        print_s("] = ");
        print_hex32(a[i]);
    }
}
#define PRINT_VREG(vreg)                      \
    do {                                       \
        u32 a[16]; \
        /* 将向量寄存器 vreg 内的 32 位数据保存到数组 a 中 */  \
        asm volatile (\
            "vse32.v " #vreg ", (%0) \n" \
                      : /* 无输出 */         \
                      : "r" (a)             \
                      : "memory");          \
        /* 调用函数或宏打印数组 a 的内容 */      \
        print_s(#vreg ":\n");                         \
        print_vec(a);                         \
    } while(0)


#include <stdint.h>
void chacha20v(chacha_buf *output, const u32 input[16])
{
    // print_s("chacha20 in\n");
    const static int index[16] __attribute__((aligned(16))) = {
         0, 1, 2, 3, 
         1, 2, 3, 0,
         2, 3, 0, 1,
         3, 0, 1, 2,
    };

    if (((uintptr_t)input % 16) != 0 || ((uintptr_t)output % 16) != 0) {
        print_s("input/output misaliged\n");
        return;
    }

    asm volatile (
        "vsetivli t0, 4, e32, m1, ta, ma         \n\t"
        "vle32.v    v0, (%[inp0])                  \n\t"
        "vle32.v    v1, (%[inp1])                  \n\t"
        "vle32.v    v2, (%[inp2])                  \n\t"
        "vle32.v    v3, (%[inp3])                  \n\t"
        "vmv.v.v    v12, v0                       \n\t" 
        "vmv.v.v    v13, v1                       \n\t" 
        "vmv.v.v    v14, v2                       \n\t" 
        "vmv.v.v    v15, v3                       \n\t" 
        "vle32.v    v8, (%[idx0])                  \n\t"
        "vle32.v    v9, (%[idx1])                  \n\t"
        "vle32.v    v10, (%[idx2])                  \n\t"
        "vle32.v    v11, (%[idx3])                  \n\t"
        : 
        : [inp0] "r" (input),
          [inp1] "r" (&input[4]),
          [inp2] "r" (&input[8]),
          [inp3] "r" (&input[12]),
          [idx0] "r" (&index[0]),
          [idx1] "r" (&index[4]),
          [idx2] "r" (&index[8]),
          [idx3] "r" (&index[12])
        : "t0", "v0", "v8", "memory"
    );
    // PRINT_VREG(v0);

    
    // print_s("chacha20 N\n");

    // 主循环：每轮进行两次 Quarter Round 操作
    // for (int i = 20; i > 0; i -= 2) 
    {
        // print_s("chacha20 ");print_long(i);print_s("\n");
        asm volatile (
            // 第一组操作：计算、异或、轮转等
            "vadd.vv    v0, v0, v1           \n\t" 
            "vxor.vv    v3, v3, v0           \n\t" 
            "vror.vi    v3, v3, 16           \n\t"

            "vadd.vv    v2, v2, v3           \n\t" 
            "vxor.vv    v1, v1, v2           \n\t" 
            "vror.vi    v1, v1, 12           \n\t"
            
            "vadd.vv    v0, v0, v1           \n\t" 
            "vxor.vv    v3, v3, v0           \n\t" 
            "vror.vi    v3, v3, 8            \n\t"
            
            "vadd.vv    v2, v2, v3           \n\t" 
            "vxor.vv    v1, v1, v2           \n\t" 
            "vror.vi    v1, v1, 7            \n\t"
        );
        // PRINT_VREG(v0);
        // print_s("QUARTERROUND L\n");
        asm volatile (
            // 第一次 vrgather 重排序，使用索引调整顺序
            "vrgather.vv v4, v0, v8       \n\t"  
            "vrgather.vv v5, v1, v9       \n\t"  // 利用 v4 重排（左移1：{1,2,3,0}）
            "vrgather.vv v6, v2, v10       \n\t"  // 利用 v5 重排（移2：{2,3,0,1}）
            "vrgather.vv v7, v3, v11       \n\t"  // 利用 v6 重排（右移1：{3,0,1,2})
        );
        // print_s("gather L\n");
        asm volatile (
            // 第二组操作
            "vadd.vv    v4, v4, v5           \n\t" 
            "vxor.vv    v7, v7, v4           \n\t" 
            "vror.vi    v7, v7, 16           \n\t"

            "vadd.vv    v6, v6, v7           \n\t" 
            "vxor.vv    v5, v5, v6           \n\t" 
            "vror.vi    v5, v5, 12           \n\t"
            
            "vadd.vv    v4, v4, v5           \n\t" 
            "vxor.vv    v7, v7, v4           \n\t" 
            "vror.vi    v7, v7, 16           \n\t"

            "vadd.vv    v6, v6, v7           \n\t" 
            "vxor.vv    v5, v5, v6           \n\t" 
            "vror.vi    v5, v5, 12           \n\t"
        );
        // print_s("QUARTERROUND R\n");
        asm volatile (
            // 第二次 vrgather 重排序：顺序调整（顺序与第一次不同，根据算法要求）
            "vrgather.vv v0, v4, v8       \n\t"  
            "vrgather.vv v1, v5, v11      \n\t"
            "vrgather.vv v2, v6, v10      \n\t"
            "vrgather.vv v3, v7, v9       \n\t" 
            :
            : /* 无输入 */
            : "v0", "v1", "v2", "v3", "memory"
        );
        // print_s("gather R\n");
        asm volatile (
            // 第一组操作：计算、异或、轮转等
            "vadd.vv    v0, v0, v1           \n\t" 
            "vxor.vv    v3, v3, v0           \n\t" 
            "vror.vi    v3, v3, 16           \n\t"

            "vadd.vv    v2, v2, v3           \n\t" 
            "vxor.vv    v1, v1, v2           \n\t" 
            "vror.vi    v1, v1, 12           \n\t"
            
            "vadd.vv    v0, v0, v1           \n\t" 
            "vxor.vv    v3, v3, v0           \n\t" 
            "vror.vi    v3, v3, 8            \n\t"
            
            "vadd.vv    v2, v2, v3           \n\t" 
            "vxor.vv    v1, v1, v2           \n\t" 
            "vror.vi    v1, v1, 7            \n\t"
        );
        // PRINT_VREG(v0);
        // print_s("QUARTERROUND L\n");
        asm volatile (
            // 第一次 vrgather 重排序，使用索引调整顺序
            "vrgather.vv v4, v0, v8       \n\t"  
            "vrgather.vv v5, v1, v9       \n\t"  // 利用 v4 重排（左移1：{1,2,3,0}）
            "vrgather.vv v6, v2, v10       \n\t"  // 利用 v5 重排（移2：{2,3,0,1}）
            "vrgather.vv v7, v3, v11       \n\t"  // 利用 v6 重排（右移1：{3,0,1,2})
        );
        // print_s("gather L\n");
        asm volatile (
            // 第二组操作
            "vadd.vv    v4, v4, v5           \n\t" 
            "vxor.vv    v7, v7, v4           \n\t" 
            "vror.vi    v7, v7, 16           \n\t"

            "vadd.vv    v6, v6, v7           \n\t" 
            "vxor.vv    v5, v5, v6           \n\t" 
            "vror.vi    v5, v5, 12           \n\t"
            
            "vadd.vv    v4, v4, v5           \n\t" 
            "vxor.vv    v7, v7, v4           \n\t" 
            "vror.vi    v7, v7, 16           \n\t"

            "vadd.vv    v6, v6, v7           \n\t" 
            "vxor.vv    v5, v5, v6           \n\t" 
            "vror.vi    v5, v5, 12           \n\t"
        );
        // print_s("QUARTERROUND R\n");
        asm volatile (
            // 第二次 vrgather 重排序：顺序调整（顺序与第一次不同，根据算法要求）
            "vrgather.vv v0, v4, v8       \n\t"  
            "vrgather.vv v1, v5, v11      \n\t"
            "vrgather.vv v2, v6, v10      \n\t"
            "vrgather.vv v3, v7, v9       \n\t" 
            :
            : /* 无输入 */
            : "v0", "v1", "v2", "v3", "memory"
        );
        // print_s("gather R\n");
        asm volatile (
            // 第一组操作：计算、异或、轮转等
            "vadd.vv    v0, v0, v1           \n\t" 
            "vxor.vv    v3, v3, v0           \n\t" 
            "vror.vi    v3, v3, 16           \n\t"

            "vadd.vv    v2, v2, v3           \n\t" 
            "vxor.vv    v1, v1, v2           \n\t" 
            "vror.vi    v1, v1, 12           \n\t"
            
            "vadd.vv    v0, v0, v1           \n\t" 
            "vxor.vv    v3, v3, v0           \n\t" 
            "vror.vi    v3, v3, 8            \n\t"
            
            "vadd.vv    v2, v2, v3           \n\t" 
            "vxor.vv    v1, v1, v2           \n\t" 
            "vror.vi    v1, v1, 7            \n\t"
        );
        // PRINT_VREG(v0);
        // print_s("QUARTERROUND L\n");
        asm volatile (
            // 第一次 vrgather 重排序，使用索引调整顺序
            "vrgather.vv v4, v0, v8       \n\t"  
            "vrgather.vv v5, v1, v9       \n\t"  // 利用 v4 重排（左移1：{1,2,3,0}）
            "vrgather.vv v6, v2, v10       \n\t"  // 利用 v5 重排（移2：{2,3,0,1}）
            "vrgather.vv v7, v3, v11       \n\t"  // 利用 v6 重排（右移1：{3,0,1,2})
        );
        // print_s("gather L\n");
        asm volatile (
            // 第二组操作
            "vadd.vv    v4, v4, v5           \n\t" 
            "vxor.vv    v7, v7, v4           \n\t" 
            "vror.vi    v7, v7, 16           \n\t"

            "vadd.vv    v6, v6, v7           \n\t" 
            "vxor.vv    v5, v5, v6           \n\t" 
            "vror.vi    v5, v5, 12           \n\t"
            
            "vadd.vv    v4, v4, v5           \n\t" 
            "vxor.vv    v7, v7, v4           \n\t" 
            "vror.vi    v7, v7, 16           \n\t"

            "vadd.vv    v6, v6, v7           \n\t" 
            "vxor.vv    v5, v5, v6           \n\t" 
            "vror.vi    v5, v5, 12           \n\t"
        );
        // print_s("QUARTERROUND R\n");
        asm volatile (
            // 第二次 vrgather 重排序：顺序调整（顺序与第一次不同，根据算法要求）
            "vrgather.vv v0, v4, v8       \n\t"  
            "vrgather.vv v1, v5, v11      \n\t"
            "vrgather.vv v2, v6, v10      \n\t"
            "vrgather.vv v3, v7, v9       \n\t" 
            :
            : /* 无输入 */
            : "v0", "v1", "v2", "v3", "memory"
        );
        // print_s("gather R\n");
        asm volatile (
            // 第一组操作：计算、异或、轮转等
            "vadd.vv    v0, v0, v1           \n\t" 
            "vxor.vv    v3, v3, v0           \n\t" 
            "vror.vi    v3, v3, 16           \n\t"

            "vadd.vv    v2, v2, v3           \n\t" 
            "vxor.vv    v1, v1, v2           \n\t" 
            "vror.vi    v1, v1, 12           \n\t"
            
            "vadd.vv    v0, v0, v1           \n\t" 
            "vxor.vv    v3, v3, v0           \n\t" 
            "vror.vi    v3, v3, 8            \n\t"
            
            "vadd.vv    v2, v2, v3           \n\t" 
            "vxor.vv    v1, v1, v2           \n\t" 
            "vror.vi    v1, v1, 7            \n\t"
        );
        // PRINT_VREG(v0);
        // print_s("QUARTERROUND L\n");
        asm volatile (
            // 第一次 vrgather 重排序，使用索引调整顺序
            "vrgather.vv v4, v0, v8       \n\t"  
            "vrgather.vv v5, v1, v9       \n\t"  // 利用 v4 重排（左移1：{1,2,3,0}）
            "vrgather.vv v6, v2, v10       \n\t"  // 利用 v5 重排（移2：{2,3,0,1}）
            "vrgather.vv v7, v3, v11       \n\t"  // 利用 v6 重排（右移1：{3,0,1,2})
        );
        // print_s("gather L\n");
        asm volatile (
            // 第二组操作
            "vadd.vv    v4, v4, v5           \n\t" 
            "vxor.vv    v7, v7, v4           \n\t" 
            "vror.vi    v7, v7, 16           \n\t"

            "vadd.vv    v6, v6, v7           \n\t" 
            "vxor.vv    v5, v5, v6           \n\t" 
            "vror.vi    v5, v5, 12           \n\t"
            
            "vadd.vv    v4, v4, v5           \n\t" 
            "vxor.vv    v7, v7, v4           \n\t" 
            "vror.vi    v7, v7, 16           \n\t"

            "vadd.vv    v6, v6, v7           \n\t" 
            "vxor.vv    v5, v5, v6           \n\t" 
            "vror.vi    v5, v5, 12           \n\t"
        );
        // print_s("QUARTERROUND R\n");
        asm volatile (
            // 第二次 vrgather 重排序：顺序调整（顺序与第一次不同，根据算法要求）
            "vrgather.vv v0, v4, v8       \n\t"  
            "vrgather.vv v1, v5, v11      \n\t"
            "vrgather.vv v2, v6, v10      \n\t"
            "vrgather.vv v3, v7, v9       \n\t" 
            :
            : /* 无输入 */
            : "v0", "v1", "v2", "v3", "memory"
        );
        // print_s("gather R\n");
        asm volatile (
            // 第一组操作：计算、异或、轮转等
            "vadd.vv    v0, v0, v1           \n\t" 
            "vxor.vv    v3, v3, v0           \n\t" 
            "vror.vi    v3, v3, 16           \n\t"

            "vadd.vv    v2, v2, v3           \n\t" 
            "vxor.vv    v1, v1, v2           \n\t" 
            "vror.vi    v1, v1, 12           \n\t"
            
            "vadd.vv    v0, v0, v1           \n\t" 
            "vxor.vv    v3, v3, v0           \n\t" 
            "vror.vi    v3, v3, 8            \n\t"
            
            "vadd.vv    v2, v2, v3           \n\t" 
            "vxor.vv    v1, v1, v2           \n\t" 
            "vror.vi    v1, v1, 7            \n\t"
        );
        // PRINT_VREG(v0);
        // print_s("QUARTERROUND L\n");
        asm volatile (
            // 第一次 vrgather 重排序，使用索引调整顺序
            "vrgather.vv v4, v0, v8       \n\t"  
            "vrgather.vv v5, v1, v9       \n\t"  // 利用 v4 重排（左移1：{1,2,3,0}）
            "vrgather.vv v6, v2, v10       \n\t"  // 利用 v5 重排（移2：{2,3,0,1}）
            "vrgather.vv v7, v3, v11       \n\t"  // 利用 v6 重排（右移1：{3,0,1,2})
        );
        // print_s("gather L\n");
        asm volatile (
            // 第二组操作
            "vadd.vv    v4, v4, v5           \n\t" 
            "vxor.vv    v7, v7, v4           \n\t" 
            "vror.vi    v7, v7, 16           \n\t"

            "vadd.vv    v6, v6, v7           \n\t" 
            "vxor.vv    v5, v5, v6           \n\t" 
            "vror.vi    v5, v5, 12           \n\t"
            
            "vadd.vv    v4, v4, v5           \n\t" 
            "vxor.vv    v7, v7, v4           \n\t" 
            "vror.vi    v7, v7, 16           \n\t"

            "vadd.vv    v6, v6, v7           \n\t" 
            "vxor.vv    v5, v5, v6           \n\t" 
            "vror.vi    v5, v5, 12           \n\t"
        );
        // print_s("QUARTERROUND R\n");
        asm volatile (
            // 第二次 vrgather 重排序：顺序调整（顺序与第一次不同，根据算法要求）
            "vrgather.vv v0, v4, v8       \n\t"  
            "vrgather.vv v1, v5, v11      \n\t"
            "vrgather.vv v2, v6, v10      \n\t"
            "vrgather.vv v3, v7, v9       \n\t" 
            :
            : /* 无输入 */
            : "v0", "v1", "v2", "v3", "memory"
        );
        // print_s("gather R\n");
        asm volatile (
            // 第一组操作：计算、异或、轮转等
            "vadd.vv    v0, v0, v1           \n\t" 
            "vxor.vv    v3, v3, v0           \n\t" 
            "vror.vi    v3, v3, 16           \n\t"

            "vadd.vv    v2, v2, v3           \n\t" 
            "vxor.vv    v1, v1, v2           \n\t" 
            "vror.vi    v1, v1, 12           \n\t"
            
            "vadd.vv    v0, v0, v1           \n\t" 
            "vxor.vv    v3, v3, v0           \n\t" 
            "vror.vi    v3, v3, 8            \n\t"
            
            "vadd.vv    v2, v2, v3           \n\t" 
            "vxor.vv    v1, v1, v2           \n\t" 
            "vror.vi    v1, v1, 7            \n\t"
        );
        // PRINT_VREG(v0);
        // print_s("QUARTERROUND L\n");
        asm volatile (
            // 第一次 vrgather 重排序，使用索引调整顺序
            "vrgather.vv v4, v0, v8       \n\t"  
            "vrgather.vv v5, v1, v9       \n\t"  // 利用 v4 重排（左移1：{1,2,3,0}）
            "vrgather.vv v6, v2, v10       \n\t"  // 利用 v5 重排（移2：{2,3,0,1}）
            "vrgather.vv v7, v3, v11       \n\t"  // 利用 v6 重排（右移1：{3,0,1,2})
        );
        // print_s("gather L\n");
        asm volatile (
            // 第二组操作
            "vadd.vv    v4, v4, v5           \n\t" 
            "vxor.vv    v7, v7, v4           \n\t" 
            "vror.vi    v7, v7, 16           \n\t"

            "vadd.vv    v6, v6, v7           \n\t" 
            "vxor.vv    v5, v5, v6           \n\t" 
            "vror.vi    v5, v5, 12           \n\t"
            
            "vadd.vv    v4, v4, v5           \n\t" 
            "vxor.vv    v7, v7, v4           \n\t" 
            "vror.vi    v7, v7, 16           \n\t"

            "vadd.vv    v6, v6, v7           \n\t" 
            "vxor.vv    v5, v5, v6           \n\t" 
            "vror.vi    v5, v5, 12           \n\t"
        );
        // print_s("QUARTERROUND R\n");
        asm volatile (
            // 第二次 vrgather 重排序：顺序调整（顺序与第一次不同，根据算法要求）
            "vrgather.vv v0, v4, v8       \n\t"  
            "vrgather.vv v1, v5, v11      \n\t"
            "vrgather.vv v2, v6, v10      \n\t"
            "vrgather.vv v3, v7, v9       \n\t" 
            :
            : /* 无输入 */
            : "v0", "v1", "v2", "v3", "memory"
        );
        // print_s("gather R\n");
        asm volatile (
            // 第一组操作：计算、异或、轮转等
            "vadd.vv    v0, v0, v1           \n\t" 
            "vxor.vv    v3, v3, v0           \n\t" 
            "vror.vi    v3, v3, 16           \n\t"

            "vadd.vv    v2, v2, v3           \n\t" 
            "vxor.vv    v1, v1, v2           \n\t" 
            "vror.vi    v1, v1, 12           \n\t"
            
            "vadd.vv    v0, v0, v1           \n\t" 
            "vxor.vv    v3, v3, v0           \n\t" 
            "vror.vi    v3, v3, 8            \n\t"
            
            "vadd.vv    v2, v2, v3           \n\t" 
            "vxor.vv    v1, v1, v2           \n\t" 
            "vror.vi    v1, v1, 7            \n\t"
        );
        // PRINT_VREG(v0);
        // print_s("QUARTERROUND L\n");
        asm volatile (
            // 第一次 vrgather 重排序，使用索引调整顺序
            "vrgather.vv v4, v0, v8       \n\t"  
            "vrgather.vv v5, v1, v9       \n\t"  // 利用 v4 重排（左移1：{1,2,3,0}）
            "vrgather.vv v6, v2, v10       \n\t"  // 利用 v5 重排（移2：{2,3,0,1}）
            "vrgather.vv v7, v3, v11       \n\t"  // 利用 v6 重排（右移1：{3,0,1,2})
        );
        // print_s("gather L\n");
        asm volatile (
            // 第二组操作
            "vadd.vv    v4, v4, v5           \n\t" 
            "vxor.vv    v7, v7, v4           \n\t" 
            "vror.vi    v7, v7, 16           \n\t"

            "vadd.vv    v6, v6, v7           \n\t" 
            "vxor.vv    v5, v5, v6           \n\t" 
            "vror.vi    v5, v5, 12           \n\t"
            
            "vadd.vv    v4, v4, v5           \n\t" 
            "vxor.vv    v7, v7, v4           \n\t" 
            "vror.vi    v7, v7, 16           \n\t"

            "vadd.vv    v6, v6, v7           \n\t" 
            "vxor.vv    v5, v5, v6           \n\t" 
            "vror.vi    v5, v5, 12           \n\t"
        );
        // print_s("QUARTERROUND R\n");
        asm volatile (
            // 第二次 vrgather 重排序：顺序调整（顺序与第一次不同，根据算法要求）
            "vrgather.vv v0, v4, v8       \n\t"  
            "vrgather.vv v1, v5, v11      \n\t"
            "vrgather.vv v2, v6, v10      \n\t"
            "vrgather.vv v3, v7, v9       \n\t" 
            :
            : /* 无输入 */
            : "v0", "v1", "v2", "v3", "memory"
        );
        // print_s("gather R\n");
        asm volatile (
            // 第一组操作：计算、异或、轮转等
            "vadd.vv    v0, v0, v1           \n\t" 
            "vxor.vv    v3, v3, v0           \n\t" 
            "vror.vi    v3, v3, 16           \n\t"

            "vadd.vv    v2, v2, v3           \n\t" 
            "vxor.vv    v1, v1, v2           \n\t" 
            "vror.vi    v1, v1, 12           \n\t"
            
            "vadd.vv    v0, v0, v1           \n\t" 
            "vxor.vv    v3, v3, v0           \n\t" 
            "vror.vi    v3, v3, 8            \n\t"
            
            "vadd.vv    v2, v2, v3           \n\t" 
            "vxor.vv    v1, v1, v2           \n\t" 
            "vror.vi    v1, v1, 7            \n\t"
        );
        // PRINT_VREG(v0);
        // print_s("QUARTERROUND L\n");
        asm volatile (
            // 第一次 vrgather 重排序，使用索引调整顺序
            "vrgather.vv v4, v0, v8       \n\t"  
            "vrgather.vv v5, v1, v9       \n\t"  // 利用 v4 重排（左移1：{1,2,3,0}）
            "vrgather.vv v6, v2, v10       \n\t"  // 利用 v5 重排（移2：{2,3,0,1}）
            "vrgather.vv v7, v3, v11       \n\t"  // 利用 v6 重排（右移1：{3,0,1,2})
        );
        // print_s("gather L\n");
        asm volatile (
            // 第二组操作
            "vadd.vv    v4, v4, v5           \n\t" 
            "vxor.vv    v7, v7, v4           \n\t" 
            "vror.vi    v7, v7, 16           \n\t"

            "vadd.vv    v6, v6, v7           \n\t" 
            "vxor.vv    v5, v5, v6           \n\t" 
            "vror.vi    v5, v5, 12           \n\t"
            
            "vadd.vv    v4, v4, v5           \n\t" 
            "vxor.vv    v7, v7, v4           \n\t" 
            "vror.vi    v7, v7, 16           \n\t"

            "vadd.vv    v6, v6, v7           \n\t" 
            "vxor.vv    v5, v5, v6           \n\t" 
            "vror.vi    v5, v5, 12           \n\t"
        );
        // print_s("QUARTERROUND R\n");
        asm volatile (
            // 第二次 vrgather 重排序：顺序调整（顺序与第一次不同，根据算法要求）
            "vrgather.vv v0, v4, v8       \n\t"  
            "vrgather.vv v1, v5, v11      \n\t"
            "vrgather.vv v2, v6, v10      \n\t"
            "vrgather.vv v3, v7, v9       \n\t" 
            :
            : /* 无输入 */
            : "v0", "v1", "v2", "v3", "memory"
        );
        // print_s("gather R\n");
        asm volatile (
            // 第一组操作：计算、异或、轮转等
            "vadd.vv    v0, v0, v1           \n\t" 
            "vxor.vv    v3, v3, v0           \n\t" 
            "vror.vi    v3, v3, 16           \n\t"

            "vadd.vv    v2, v2, v3           \n\t" 
            "vxor.vv    v1, v1, v2           \n\t" 
            "vror.vi    v1, v1, 12           \n\t"
            
            "vadd.vv    v0, v0, v1           \n\t" 
            "vxor.vv    v3, v3, v0           \n\t" 
            "vror.vi    v3, v3, 8            \n\t"
            
            "vadd.vv    v2, v2, v3           \n\t" 
            "vxor.vv    v1, v1, v2           \n\t" 
            "vror.vi    v1, v1, 7            \n\t"
        );
        // PRINT_VREG(v0);
        // print_s("QUARTERROUND L\n");
        asm volatile (
            // 第一次 vrgather 重排序，使用索引调整顺序
            "vrgather.vv v4, v0, v8       \n\t"  
            "vrgather.vv v5, v1, v9       \n\t"  // 利用 v4 重排（左移1：{1,2,3,0}）
            "vrgather.vv v6, v2, v10       \n\t"  // 利用 v5 重排（移2：{2,3,0,1}）
            "vrgather.vv v7, v3, v11       \n\t"  // 利用 v6 重排（右移1：{3,0,1,2})
        );
        // print_s("gather L\n");
        asm volatile (
            // 第二组操作
            "vadd.vv    v4, v4, v5           \n\t" 
            "vxor.vv    v7, v7, v4           \n\t" 
            "vror.vi    v7, v7, 16           \n\t"

            "vadd.vv    v6, v6, v7           \n\t" 
            "vxor.vv    v5, v5, v6           \n\t" 
            "vror.vi    v5, v5, 12           \n\t"
            
            "vadd.vv    v4, v4, v5           \n\t" 
            "vxor.vv    v7, v7, v4           \n\t" 
            "vror.vi    v7, v7, 16           \n\t"

            "vadd.vv    v6, v6, v7           \n\t" 
            "vxor.vv    v5, v5, v6           \n\t" 
            "vror.vi    v5, v5, 12           \n\t"
        );
        // print_s("QUARTERROUND R\n");
        asm volatile (
            // 第二次 vrgather 重排序：顺序调整（顺序与第一次不同，根据算法要求）
            "vrgather.vv v0, v4, v8       \n\t"  
            "vrgather.vv v1, v5, v11      \n\t"
            "vrgather.vv v2, v6, v10      \n\t"
            "vrgather.vv v3, v7, v9       \n\t" 
            :
            : /* 无输入 */
            : "v0", "v1", "v2", "v3", "memory"
        );
        // print_s("gather R\n");
        asm volatile (
            // 第一组操作：计算、异或、轮转等
            "vadd.vv    v0, v0, v1           \n\t" 
            "vxor.vv    v3, v3, v0           \n\t" 
            "vror.vi    v3, v3, 16           \n\t"

            "vadd.vv    v2, v2, v3           \n\t" 
            "vxor.vv    v1, v1, v2           \n\t" 
            "vror.vi    v1, v1, 12           \n\t"
            
            "vadd.vv    v0, v0, v1           \n\t" 
            "vxor.vv    v3, v3, v0           \n\t" 
            "vror.vi    v3, v3, 8            \n\t"
            
            "vadd.vv    v2, v2, v3           \n\t" 
            "vxor.vv    v1, v1, v2           \n\t" 
            "vror.vi    v1, v1, 7            \n\t"
        );
        // PRINT_VREG(v0);
        // print_s("QUARTERROUND L\n");
        asm volatile (
            // 第一次 vrgather 重排序，使用索引调整顺序
            "vrgather.vv v4, v0, v8       \n\t"  
            "vrgather.vv v5, v1, v9       \n\t"  // 利用 v4 重排（左移1：{1,2,3,0}）
            "vrgather.vv v6, v2, v10       \n\t"  // 利用 v5 重排（移2：{2,3,0,1}）
            "vrgather.vv v7, v3, v11       \n\t"  // 利用 v6 重排（右移1：{3,0,1,2})
        );
        // print_s("gather L\n");
        asm volatile (
            // 第二组操作
            "vadd.vv    v4, v4, v5           \n\t" 
            "vxor.vv    v7, v7, v4           \n\t" 
            "vror.vi    v7, v7, 16           \n\t"

            "vadd.vv    v6, v6, v7           \n\t" 
            "vxor.vv    v5, v5, v6           \n\t" 
            "vror.vi    v5, v5, 12           \n\t"
            
            "vadd.vv    v4, v4, v5           \n\t" 
            "vxor.vv    v7, v7, v4           \n\t" 
            "vror.vi    v7, v7, 16           \n\t"

            "vadd.vv    v6, v6, v7           \n\t" 
            "vxor.vv    v5, v5, v6           \n\t" 
            "vror.vi    v5, v5, 12           \n\t"
        );
        // print_s("QUARTERROUND R\n");
        asm volatile (
            // 第二次 vrgather 重排序：顺序调整（顺序与第一次不同，根据算法要求）
            "vrgather.vv v0, v4, v8       \n\t"  
            "vrgather.vv v1, v5, v11      \n\t"
            "vrgather.vv v2, v6, v10      \n\t"
            "vrgather.vv v3, v7, v9       \n\t" 
            :
            : /* 无输入 */
            : "v0", "v1", "v2", "v3", "memory"
        );
        // print_s("gather R\n");
        asm volatile (
            // 第一组操作：计算、异或、轮转等
            "vadd.vv    v0, v0, v1           \n\t" 
            "vxor.vv    v3, v3, v0           \n\t" 
            "vror.vi    v3, v3, 16           \n\t"

            "vadd.vv    v2, v2, v3           \n\t" 
            "vxor.vv    v1, v1, v2           \n\t" 
            "vror.vi    v1, v1, 12           \n\t"
            
            "vadd.vv    v0, v0, v1           \n\t" 
            "vxor.vv    v3, v3, v0           \n\t" 
            "vror.vi    v3, v3, 8            \n\t"
            
            "vadd.vv    v2, v2, v3           \n\t" 
            "vxor.vv    v1, v1, v2           \n\t" 
            "vror.vi    v1, v1, 7            \n\t"
        );
        // PRINT_VREG(v0);
        // print_s("QUARTERROUND L\n");
        asm volatile (
            // 第一次 vrgather 重排序，使用索引调整顺序
            "vrgather.vv v4, v0, v8       \n\t"  
            "vrgather.vv v5, v1, v9       \n\t"  // 利用 v4 重排（左移1：{1,2,3,0}）
            "vrgather.vv v6, v2, v10       \n\t"  // 利用 v5 重排（移2：{2,3,0,1}）
            "vrgather.vv v7, v3, v11       \n\t"  // 利用 v6 重排（右移1：{3,0,1,2})
        );
        // print_s("gather L\n");
        asm volatile (
            // 第二组操作
            "vadd.vv    v4, v4, v5           \n\t" 
            "vxor.vv    v7, v7, v4           \n\t" 
            "vror.vi    v7, v7, 16           \n\t"

            "vadd.vv    v6, v6, v7           \n\t" 
            "vxor.vv    v5, v5, v6           \n\t" 
            "vror.vi    v5, v5, 12           \n\t"
            
            "vadd.vv    v4, v4, v5           \n\t" 
            "vxor.vv    v7, v7, v4           \n\t" 
            "vror.vi    v7, v7, 16           \n\t"

            "vadd.vv    v6, v6, v7           \n\t" 
            "vxor.vv    v5, v5, v6           \n\t" 
            "vror.vi    v5, v5, 12           \n\t"
        );
        // print_s("QUARTERROUND R\n");
        asm volatile (
            // 第二次 vrgather 重排序：顺序调整（顺序与第一次不同，根据算法要求）
            "vrgather.vv v0, v4, v8       \n\t"  
            "vrgather.vv v1, v5, v11      \n\t"
            "vrgather.vv v2, v6, v10      \n\t"
            "vrgather.vv v3, v7, v9       \n\t" 
            :
            : /* 无输入 */
            : "v0", "v1", "v2", "v3", "memory"
        );
        // print_s("gather R\n");
        asm volatile (
            // 第一组操作：计算、异或、轮转等
            "vadd.vv    v0, v0, v1           \n\t" 
            "vxor.vv    v3, v3, v0           \n\t" 
            "vror.vi    v3, v3, 16           \n\t"

            "vadd.vv    v2, v2, v3           \n\t" 
            "vxor.vv    v1, v1, v2           \n\t" 
            "vror.vi    v1, v1, 12           \n\t"
            
            "vadd.vv    v0, v0, v1           \n\t" 
            "vxor.vv    v3, v3, v0           \n\t" 
            "vror.vi    v3, v3, 8            \n\t"
            
            "vadd.vv    v2, v2, v3           \n\t" 
            "vxor.vv    v1, v1, v2           \n\t" 
            "vror.vi    v1, v1, 7            \n\t"
        );
        // PRINT_VREG(v0);
        // print_s("QUARTERROUND L\n");
        asm volatile (
            // 第一次 vrgather 重排序，使用索引调整顺序
            "vrgather.vv v4, v0, v8       \n\t"  
            "vrgather.vv v5, v1, v9       \n\t"  // 利用 v4 重排（左移1：{1,2,3,0}）
            "vrgather.vv v6, v2, v10       \n\t"  // 利用 v5 重排（移2：{2,3,0,1}）
            "vrgather.vv v7, v3, v11       \n\t"  // 利用 v6 重排（右移1：{3,0,1,2})
        );
        // print_s("gather L\n");
        asm volatile (
            // 第二组操作
            "vadd.vv    v4, v4, v5           \n\t" 
            "vxor.vv    v7, v7, v4           \n\t" 
            "vror.vi    v7, v7, 16           \n\t"

            "vadd.vv    v6, v6, v7           \n\t" 
            "vxor.vv    v5, v5, v6           \n\t" 
            "vror.vi    v5, v5, 12           \n\t"
            
            "vadd.vv    v4, v4, v5           \n\t" 
            "vxor.vv    v7, v7, v4           \n\t" 
            "vror.vi    v7, v7, 16           \n\t"

            "vadd.vv    v6, v6, v7           \n\t" 
            "vxor.vv    v5, v5, v6           \n\t" 
            "vror.vi    v5, v5, 12           \n\t"
        );
        // print_s("QUARTERROUND R\n");
        asm volatile (
            // 第二次 vrgather 重排序：顺序调整（顺序与第一次不同，根据算法要求）
            "vrgather.vv v0, v4, v8       \n\t"  
            "vrgather.vv v1, v5, v11      \n\t"
            "vrgather.vv v2, v6, v10      \n\t"
            "vrgather.vv v3, v7, v9       \n\t" 
            :
            : /* 无输入 */
            : "v0", "v1", "v2", "v3", "memory"
        );
        // print_s("gather R\n");
        asm volatile (
            // 第一组操作：计算、异或、轮转等
            "vadd.vv    v0, v0, v1           \n\t" 
            "vxor.vv    v3, v3, v0           \n\t" 
            "vror.vi    v3, v3, 16           \n\t"

            "vadd.vv    v2, v2, v3           \n\t" 
            "vxor.vv    v1, v1, v2           \n\t" 
            "vror.vi    v1, v1, 12           \n\t"
            
            "vadd.vv    v0, v0, v1           \n\t" 
            "vxor.vv    v3, v3, v0           \n\t" 
            "vror.vi    v3, v3, 8            \n\t"
            
            "vadd.vv    v2, v2, v3           \n\t" 
            "vxor.vv    v1, v1, v2           \n\t" 
            "vror.vi    v1, v1, 7            \n\t"
        );
        // PRINT_VREG(v0);
        // print_s("QUARTERROUND L\n");
        asm volatile (
            // 第一次 vrgather 重排序，使用索引调整顺序
            "vrgather.vv v4, v0, v8       \n\t"  
            "vrgather.vv v5, v1, v9       \n\t"  // 利用 v4 重排（左移1：{1,2,3,0}）
            "vrgather.vv v6, v2, v10       \n\t"  // 利用 v5 重排（移2：{2,3,0,1}）
            "vrgather.vv v7, v3, v11       \n\t"  // 利用 v6 重排（右移1：{3,0,1,2})
        );
        // print_s("gather L\n");
        asm volatile (
            // 第二组操作
            "vadd.vv    v4, v4, v5           \n\t" 
            "vxor.vv    v7, v7, v4           \n\t" 
            "vror.vi    v7, v7, 16           \n\t"

            "vadd.vv    v6, v6, v7           \n\t" 
            "vxor.vv    v5, v5, v6           \n\t" 
            "vror.vi    v5, v5, 12           \n\t"
            
            "vadd.vv    v4, v4, v5           \n\t" 
            "vxor.vv    v7, v7, v4           \n\t" 
            "vror.vi    v7, v7, 16           \n\t"

            "vadd.vv    v6, v6, v7           \n\t" 
            "vxor.vv    v5, v5, v6           \n\t" 
            "vror.vi    v5, v5, 12           \n\t"
        );
        // print_s("QUARTERROUND R\n");
        asm volatile (
            // 第二次 vrgather 重排序：顺序调整（顺序与第一次不同，根据算法要求）
            "vrgather.vv v0, v4, v8       \n\t"  
            "vrgather.vv v1, v5, v11      \n\t"
            "vrgather.vv v2, v6, v10      \n\t"
            "vrgather.vv v3, v7, v9       \n\t" 
            :
            : /* 无输入 */
            : "v0", "v1", "v2", "v3", "memory"
        );
        // print_s("gather R\n");
        asm volatile (
            // 第一组操作：计算、异或、轮转等
            "vadd.vv    v0, v0, v1           \n\t" 
            "vxor.vv    v3, v3, v0           \n\t" 
            "vror.vi    v3, v3, 16           \n\t"

            "vadd.vv    v2, v2, v3           \n\t" 
            "vxor.vv    v1, v1, v2           \n\t" 
            "vror.vi    v1, v1, 12           \n\t"
            
            "vadd.vv    v0, v0, v1           \n\t" 
            "vxor.vv    v3, v3, v0           \n\t" 
            "vror.vi    v3, v3, 8            \n\t"
            
            "vadd.vv    v2, v2, v3           \n\t" 
            "vxor.vv    v1, v1, v2           \n\t" 
            "vror.vi    v1, v1, 7            \n\t"
        );
        // PRINT_VREG(v0);
        // print_s("QUARTERROUND L\n");
        asm volatile (
            // 第一次 vrgather 重排序，使用索引调整顺序
            "vrgather.vv v4, v0, v8       \n\t"  
            "vrgather.vv v5, v1, v9       \n\t"  // 利用 v4 重排（左移1：{1,2,3,0}）
            "vrgather.vv v6, v2, v10       \n\t"  // 利用 v5 重排（移2：{2,3,0,1}）
            "vrgather.vv v7, v3, v11       \n\t"  // 利用 v6 重排（右移1：{3,0,1,2})
        );
        // print_s("gather L\n");
        asm volatile (
            // 第二组操作
            "vadd.vv    v4, v4, v5           \n\t" 
            "vxor.vv    v7, v7, v4           \n\t" 
            "vror.vi    v7, v7, 16           \n\t"

            "vadd.vv    v6, v6, v7           \n\t" 
            "vxor.vv    v5, v5, v6           \n\t" 
            "vror.vi    v5, v5, 12           \n\t"
            
            "vadd.vv    v4, v4, v5           \n\t" 
            "vxor.vv    v7, v7, v4           \n\t" 
            "vror.vi    v7, v7, 16           \n\t"

            "vadd.vv    v6, v6, v7           \n\t" 
            "vxor.vv    v5, v5, v6           \n\t" 
            "vror.vi    v5, v5, 12           \n\t"
        );
        // print_s("QUARTERROUND R\n");
        asm volatile (
            // 第二次 vrgather 重排序：顺序调整（顺序与第一次不同，根据算法要求）
            "vrgather.vv v0, v4, v8       \n\t"  
            "vrgather.vv v1, v5, v11      \n\t"
            "vrgather.vv v2, v6, v10      \n\t"
            "vrgather.vv v3, v7, v9       \n\t" 
            :
            : /* 无输入 */
            : "v0", "v1", "v2", "v3", "memory"
        );
        // print_s("gather R\n");
        asm volatile (
            // 第一组操作：计算、异或、轮转等
            "vadd.vv    v0, v0, v1           \n\t" 
            "vxor.vv    v3, v3, v0           \n\t" 
            "vror.vi    v3, v3, 16           \n\t"

            "vadd.vv    v2, v2, v3           \n\t" 
            "vxor.vv    v1, v1, v2           \n\t" 
            "vror.vi    v1, v1, 12           \n\t"
            
            "vadd.vv    v0, v0, v1           \n\t" 
            "vxor.vv    v3, v3, v0           \n\t" 
            "vror.vi    v3, v3, 8            \n\t"
            
            "vadd.vv    v2, v2, v3           \n\t" 
            "vxor.vv    v1, v1, v2           \n\t" 
            "vror.vi    v1, v1, 7            \n\t"
        );
        // PRINT_VREG(v0);
        // print_s("QUARTERROUND L\n");
        asm volatile (
            // 第一次 vrgather 重排序，使用索引调整顺序
            "vrgather.vv v4, v0, v8       \n\t"  
            "vrgather.vv v5, v1, v9       \n\t"  // 利用 v4 重排（左移1：{1,2,3,0}）
            "vrgather.vv v6, v2, v10       \n\t"  // 利用 v5 重排（移2：{2,3,0,1}）
            "vrgather.vv v7, v3, v11       \n\t"  // 利用 v6 重排（右移1：{3,0,1,2})
        );
        // print_s("gather L\n");
        asm volatile (
            // 第二组操作
            "vadd.vv    v4, v4, v5           \n\t" 
            "vxor.vv    v7, v7, v4           \n\t" 
            "vror.vi    v7, v7, 16           \n\t"

            "vadd.vv    v6, v6, v7           \n\t" 
            "vxor.vv    v5, v5, v6           \n\t" 
            "vror.vi    v5, v5, 12           \n\t"
            
            "vadd.vv    v4, v4, v5           \n\t" 
            "vxor.vv    v7, v7, v4           \n\t" 
            "vror.vi    v7, v7, 16           \n\t"

            "vadd.vv    v6, v6, v7           \n\t" 
            "vxor.vv    v5, v5, v6           \n\t" 
            "vror.vi    v5, v5, 12           \n\t"
        );
        // print_s("QUARTERROUND R\n");
        asm volatile (
            // 第二次 vrgather 重排序：顺序调整（顺序与第一次不同，根据算法要求）
            "vrgather.vv v0, v4, v8       \n\t"  
            "vrgather.vv v1, v5, v11      \n\t"
            "vrgather.vv v2, v6, v10      \n\t"
            "vrgather.vv v3, v7, v9       \n\t" 
            :
            : /* 无输入 */
            : "v0", "v1", "v2", "v3", "memory"
        );
        // print_s("gather R\n");
        asm volatile (
            // 第一组操作：计算、异或、轮转等
            "vadd.vv    v0, v0, v1           \n\t" 
            "vxor.vv    v3, v3, v0           \n\t" 
            "vror.vi    v3, v3, 16           \n\t"

            "vadd.vv    v2, v2, v3           \n\t" 
            "vxor.vv    v1, v1, v2           \n\t" 
            "vror.vi    v1, v1, 12           \n\t"
            
            "vadd.vv    v0, v0, v1           \n\t" 
            "vxor.vv    v3, v3, v0           \n\t" 
            "vror.vi    v3, v3, 8            \n\t"
            
            "vadd.vv    v2, v2, v3           \n\t" 
            "vxor.vv    v1, v1, v2           \n\t" 
            "vror.vi    v1, v1, 7            \n\t"
        );
        // PRINT_VREG(v0);
        // print_s("QUARTERROUND L\n");
        asm volatile (
            // 第一次 vrgather 重排序，使用索引调整顺序
            "vrgather.vv v4, v0, v8       \n\t"  
            "vrgather.vv v5, v1, v9       \n\t"  // 利用 v4 重排（左移1：{1,2,3,0}）
            "vrgather.vv v6, v2, v10       \n\t"  // 利用 v5 重排（移2：{2,3,0,1}）
            "vrgather.vv v7, v3, v11       \n\t"  // 利用 v6 重排（右移1：{3,0,1,2})
        );
        // print_s("gather L\n");
        asm volatile (
            // 第二组操作
            "vadd.vv    v4, v4, v5           \n\t" 
            "vxor.vv    v7, v7, v4           \n\t" 
            "vror.vi    v7, v7, 16           \n\t"

            "vadd.vv    v6, v6, v7           \n\t" 
            "vxor.vv    v5, v5, v6           \n\t" 
            "vror.vi    v5, v5, 12           \n\t"
            
            "vadd.vv    v4, v4, v5           \n\t" 
            "vxor.vv    v7, v7, v4           \n\t" 
            "vror.vi    v7, v7, 16           \n\t"

            "vadd.vv    v6, v6, v7           \n\t" 
            "vxor.vv    v5, v5, v6           \n\t" 
            "vror.vi    v5, v5, 12           \n\t"
        );
        // print_s("QUARTERROUND R\n");
        asm volatile (
            // 第二次 vrgather 重排序：顺序调整（顺序与第一次不同，根据算法要求）
            "vrgather.vv v0, v4, v8       \n\t"  
            "vrgather.vv v1, v5, v11      \n\t"
            "vrgather.vv v2, v6, v10      \n\t"
            "vrgather.vv v3, v7, v9       \n\t" 
            :
            : /* 无输入 */
            : "v0", "v1", "v2", "v3", "memory"
        );
        // print_s("gather R\n");
        asm volatile (
            // 第一组操作：计算、异或、轮转等
            "vadd.vv    v0, v0, v1           \n\t" 
            "vxor.vv    v3, v3, v0           \n\t" 
            "vror.vi    v3, v3, 16           \n\t"

            "vadd.vv    v2, v2, v3           \n\t" 
            "vxor.vv    v1, v1, v2           \n\t" 
            "vror.vi    v1, v1, 12           \n\t"
            
            "vadd.vv    v0, v0, v1           \n\t" 
            "vxor.vv    v3, v3, v0           \n\t" 
            "vror.vi    v3, v3, 8            \n\t"
            
            "vadd.vv    v2, v2, v3           \n\t" 
            "vxor.vv    v1, v1, v2           \n\t" 
            "vror.vi    v1, v1, 7            \n\t"
        );
        // PRINT_VREG(v0);
        // print_s("QUARTERROUND L\n");
        asm volatile (
            // 第一次 vrgather 重排序，使用索引调整顺序
            "vrgather.vv v4, v0, v8       \n\t"  
            "vrgather.vv v5, v1, v9       \n\t"  // 利用 v4 重排（左移1：{1,2,3,0}）
            "vrgather.vv v6, v2, v10       \n\t"  // 利用 v5 重排（移2：{2,3,0,1}）
            "vrgather.vv v7, v3, v11       \n\t"  // 利用 v6 重排（右移1：{3,0,1,2})
        );
        // print_s("gather L\n");
        asm volatile (
            // 第二组操作
            "vadd.vv    v4, v4, v5           \n\t" 
            "vxor.vv    v7, v7, v4           \n\t" 
            "vror.vi    v7, v7, 16           \n\t"

            "vadd.vv    v6, v6, v7           \n\t" 
            "vxor.vv    v5, v5, v6           \n\t" 
            "vror.vi    v5, v5, 12           \n\t"
            
            "vadd.vv    v4, v4, v5           \n\t" 
            "vxor.vv    v7, v7, v4           \n\t" 
            "vror.vi    v7, v7, 16           \n\t"

            "vadd.vv    v6, v6, v7           \n\t" 
            "vxor.vv    v5, v5, v6           \n\t" 
            "vror.vi    v5, v5, 12           \n\t"
        );
        // print_s("QUARTERROUND R\n");
        asm volatile (
            // 第二次 vrgather 重排序：顺序调整（顺序与第一次不同，根据算法要求）
            "vrgather.vv v0, v4, v8       \n\t"  
            "vrgather.vv v1, v5, v11      \n\t"
            "vrgather.vv v2, v6, v10      \n\t"
            "vrgather.vv v3, v7, v9       \n\t" 
            :
            : /* 无输入 */
            : "v0", "v1", "v2", "v3", "memory"
        );
        // print_s("gather R\n");
        asm volatile (
            // 第一组操作：计算、异或、轮转等
            "vadd.vv    v0, v0, v1           \n\t" 
            "vxor.vv    v3, v3, v0           \n\t" 
            "vror.vi    v3, v3, 16           \n\t"

            "vadd.vv    v2, v2, v3           \n\t" 
            "vxor.vv    v1, v1, v2           \n\t" 
            "vror.vi    v1, v1, 12           \n\t"
            
            "vadd.vv    v0, v0, v1           \n\t" 
            "vxor.vv    v3, v3, v0           \n\t" 
            "vror.vi    v3, v3, 8            \n\t"
            
            "vadd.vv    v2, v2, v3           \n\t" 
            "vxor.vv    v1, v1, v2           \n\t" 
            "vror.vi    v1, v1, 7            \n\t"
        );
        // PRINT_VREG(v0);
        // print_s("QUARTERROUND L\n");
        asm volatile (
            // 第一次 vrgather 重排序，使用索引调整顺序
            "vrgather.vv v4, v0, v8       \n\t"  
            "vrgather.vv v5, v1, v9       \n\t"  // 利用 v4 重排（左移1：{1,2,3,0}）
            "vrgather.vv v6, v2, v10       \n\t"  // 利用 v5 重排（移2：{2,3,0,1}）
            "vrgather.vv v7, v3, v11       \n\t"  // 利用 v6 重排（右移1：{3,0,1,2})
        );
        // print_s("gather L\n");
        asm volatile (
            // 第二组操作
            "vadd.vv    v4, v4, v5           \n\t" 
            "vxor.vv    v7, v7, v4           \n\t" 
            "vror.vi    v7, v7, 16           \n\t"

            "vadd.vv    v6, v6, v7           \n\t" 
            "vxor.vv    v5, v5, v6           \n\t" 
            "vror.vi    v5, v5, 12           \n\t"
            
            "vadd.vv    v4, v4, v5           \n\t" 
            "vxor.vv    v7, v7, v4           \n\t" 
            "vror.vi    v7, v7, 16           \n\t"

            "vadd.vv    v6, v6, v7           \n\t" 
            "vxor.vv    v5, v5, v6           \n\t" 
            "vror.vi    v5, v5, 12           \n\t"
        );
        // print_s("QUARTERROUND R\n");
        asm volatile (
            // 第二次 vrgather 重排序：顺序调整（顺序与第一次不同，根据算法要求）
            "vrgather.vv v0, v4, v8       \n\t"  
            "vrgather.vv v1, v5, v11      \n\t"
            "vrgather.vv v2, v6, v10      \n\t"
            "vrgather.vv v3, v7, v9       \n\t" 
            :
            : /* 无输入 */
            : "v0", "v1", "v2", "v3", "memory"
        );
        // print_s("gather R\n");
        asm volatile (
            // 第一组操作：计算、异或、轮转等
            "vadd.vv    v0, v0, v1           \n\t" 
            "vxor.vv    v3, v3, v0           \n\t" 
            "vror.vi    v3, v3, 16           \n\t"

            "vadd.vv    v2, v2, v3           \n\t" 
            "vxor.vv    v1, v1, v2           \n\t" 
            "vror.vi    v1, v1, 12           \n\t"
            
            "vadd.vv    v0, v0, v1           \n\t" 
            "vxor.vv    v3, v3, v0           \n\t" 
            "vror.vi    v3, v3, 8            \n\t"
            
            "vadd.vv    v2, v2, v3           \n\t" 
            "vxor.vv    v1, v1, v2           \n\t" 
            "vror.vi    v1, v1, 7            \n\t"
        );
        // PRINT_VREG(v0);
        // print_s("QUARTERROUND L\n");
        asm volatile (
            // 第一次 vrgather 重排序，使用索引调整顺序
            "vrgather.vv v4, v0, v8       \n\t"  
            "vrgather.vv v5, v1, v9       \n\t"  // 利用 v4 重排（左移1：{1,2,3,0}）
            "vrgather.vv v6, v2, v10       \n\t"  // 利用 v5 重排（移2：{2,3,0,1}）
            "vrgather.vv v7, v3, v11       \n\t"  // 利用 v6 重排（右移1：{3,0,1,2})
        );
        // print_s("gather L\n");
        asm volatile (
            // 第二组操作
            "vadd.vv    v4, v4, v5           \n\t" 
            "vxor.vv    v7, v7, v4           \n\t" 
            "vror.vi    v7, v7, 16           \n\t"

            "vadd.vv    v6, v6, v7           \n\t" 
            "vxor.vv    v5, v5, v6           \n\t" 
            "vror.vi    v5, v5, 12           \n\t"
            
            "vadd.vv    v4, v4, v5           \n\t" 
            "vxor.vv    v7, v7, v4           \n\t" 
            "vror.vi    v7, v7, 16           \n\t"

            "vadd.vv    v6, v6, v7           \n\t" 
            "vxor.vv    v5, v5, v6           \n\t" 
            "vror.vi    v5, v5, 12           \n\t"
        );
        // print_s("QUARTERROUND R\n");
        asm volatile (
            // 第二次 vrgather 重排序：顺序调整（顺序与第一次不同，根据算法要求）
            "vrgather.vv v0, v4, v8       \n\t"  
            "vrgather.vv v1, v5, v11      \n\t"
            "vrgather.vv v2, v6, v10      \n\t"
            "vrgather.vv v3, v7, v9       \n\t" 
            :
            : /* 无输入 */
            : "v0", "v1", "v2", "v3", "memory"
        );
        // print_s("gather R\n");
        asm volatile (
            // 第一组操作：计算、异或、轮转等
            "vadd.vv    v0, v0, v1           \n\t" 
            "vxor.vv    v3, v3, v0           \n\t" 
            "vror.vi    v3, v3, 16           \n\t"

            "vadd.vv    v2, v2, v3           \n\t" 
            "vxor.vv    v1, v1, v2           \n\t" 
            "vror.vi    v1, v1, 12           \n\t"
            
            "vadd.vv    v0, v0, v1           \n\t" 
            "vxor.vv    v3, v3, v0           \n\t" 
            "vror.vi    v3, v3, 8            \n\t"
            
            "vadd.vv    v2, v2, v3           \n\t" 
            "vxor.vv    v1, v1, v2           \n\t" 
            "vror.vi    v1, v1, 7            \n\t"
        );
        // PRINT_VREG(v0);
        // print_s("QUARTERROUND L\n");
        asm volatile (
            // 第一次 vrgather 重排序，使用索引调整顺序
            "vrgather.vv v4, v0, v8       \n\t"  
            "vrgather.vv v5, v1, v9       \n\t"  // 利用 v4 重排（左移1：{1,2,3,0}）
            "vrgather.vv v6, v2, v10       \n\t"  // 利用 v5 重排（移2：{2,3,0,1}）
            "vrgather.vv v7, v3, v11       \n\t"  // 利用 v6 重排（右移1：{3,0,1,2})
        );
        // print_s("gather L\n");
        asm volatile (
            // 第二组操作
            "vadd.vv    v4, v4, v5           \n\t" 
            "vxor.vv    v7, v7, v4           \n\t" 
            "vror.vi    v7, v7, 16           \n\t"

            "vadd.vv    v6, v6, v7           \n\t" 
            "vxor.vv    v5, v5, v6           \n\t" 
            "vror.vi    v5, v5, 12           \n\t"
            
            "vadd.vv    v4, v4, v5           \n\t" 
            "vxor.vv    v7, v7, v4           \n\t" 
            "vror.vi    v7, v7, 16           \n\t"

            "vadd.vv    v6, v6, v7           \n\t" 
            "vxor.vv    v5, v5, v6           \n\t" 
            "vror.vi    v5, v5, 12           \n\t"
        );
        // print_s("QUARTERROUND R\n");
        asm volatile (
            // 第二次 vrgather 重排序：顺序调整（顺序与第一次不同，根据算法要求）
            "vrgather.vv v0, v4, v8       \n\t"  
            "vrgather.vv v1, v5, v11      \n\t"
            "vrgather.vv v2, v6, v10      \n\t"
            "vrgather.vv v3, v7, v9       \n\t" 
            :
            : /* 无输入 */
            : "v0", "v1", "v2", "v3", "memory"
        );
        // print_s("gather R\n");

    }

    // print_s("chacha20 -1\n");

    // 最后阶段：将第一阶段复制保存在 v8 的 input 数据与最终结果相加，然后存回 output
    asm volatile (
        "vadd.vv    v0, v0, v12               \n\t"  
        "vadd.vv    v1, v1, v13               \n\t"  
        "vadd.vv    v2, v2, v14               \n\t"  
        "vadd.vv    v3, v3, v15               \n\t"  
        "vse32.v    v0, (%[s_out0])           \n\t"  // 将结果存回 output
        "vse32.v    v1, (%[s_out1])           \n\t"  // 将结果存回 output
        "vse32.v    v2, (%[s_out2])           \n\t"  // 将结果存回 output
        "vse32.v    v3, (%[s_out3])           \n\t"  // 将结果存回 output
        : 
        : [s_out0] "r" (output->u),
          [s_out1] "r" (&output->u[4]),
          [s_out2] "r" (&output->u[8]),
          [s_out3] "r" (&output->u[12])
        : "t0", "v0", "v8", "memory"
    );

    // print_s("chacha20 exit\n");
}
#endif