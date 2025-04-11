#include <vector>
#include <cmath>
#include <omp.h>
#include <riscv_vector.h>
#include <iostream>

// #define use_vec

#ifdef use_vec
void vectorized_kernel(int j_block, int j_end, float *C, const float *B, float a, int i, int k, int P) {
    size_t remaining = j_end - j_block;
    const float *B_ptr = &B[k * P + j_block];
    float *C_ptr = &C[i * P + j_block];

    while (remaining > 0) {
        // 动态设置向量长度
        size_t vl = __riscv_vsetvl_e32m1(remaining);
        
        // 加载B向量
        vfloat32m1_t b_vec = __riscv_vle32_v_f32m1(B_ptr, vl);
        
        // 加载C的当前值
        vfloat32m1_t c_vec = __riscv_vle32_v_f32m1(C_ptr, vl);
        
        // 计算乘加: C = C + a * B
        c_vec = __riscv_vfmacc_vf_f32m1(c_vec, a, b_vec, vl);
        
        // 存储结果回C
        __riscv_vse32_v_f32m1(C_ptr, c_vec, vl);
        
        // 更新指针和剩余元素计数
        B_ptr += vl;
        C_ptr += vl;
        remaining -= vl;
    }
}
#endif
void matrix_multiply_optimize(const std::vector<float>& A,
    const std::vector<float>& B,
    std::vector<float>& C,
    int M, int N, int P)
{
    constexpr int BLOCK_SIZE = 64;
    constexpr float THRESHOLD = 1e-4;

    #pragma omp parallel for collapse(2)
    for (int i_block = 0; i_block < M; i_block += BLOCK_SIZE) {
        for (int j_block = 0; j_block < P; j_block += BLOCK_SIZE) {
            const int i_end = std::min(i_block + BLOCK_SIZE, M);
            const int j_end = std::min(j_block + BLOCK_SIZE, P);

            for (int i = i_block; i < i_end; ++i) {
                for (int j = j_block; j < j_end; ++j) {
                    C[i*P + j] = 0.0f;
                }
            }

            for (int k_block = 0; k_block < N; k_block += BLOCK_SIZE) {
                const int k_end = std::min(k_block + BLOCK_SIZE, N);

                for (int i = i_block; i < i_end; ++i) {
                    for (int k = k_block; k < k_end; ++k) {
                        const float a = A[i*N + k];
                        // if (std::abs(a) < THRESHOLD) continue;
                        #ifdef use_vec
                        vectorized_kernel(j_block, j_end, &C[0], &B[0], a, i, k, P);
                        #else
                        for (int j = j_block; j < j_end; ++j) {
                            C[i*P + j] += a * B[k*P + j];
                        }
                        #endif
                    }
                }
            }
        }
    }
}