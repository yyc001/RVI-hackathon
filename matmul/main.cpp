#include <iostream>
#include <vector>
#include <chrono>
#include <algorithm>
#include <cmath>
const float EPSILON = 1e-8;
void matrix_multiply_optimize(const std::vector<float>& A, const
std::vector<float>& B, std::vector<float>& C, int M, int N, int P);
void generate_random_matrix(std::vector<float>& matrix, int rows, int cols) {
        for (int i = 0; i < rows * cols; ++i) {
        matrix[i] = static_cast<float>(rand()) / RAND_MAX;
        }
}
 void matrix_multiply(const std::vector<float>& A, const std::vector<float>&
        B, std::vector<float>& C, int M, int N, int P) {
        for (int i = 0; i < M; ++i) {
                for (int j = 0; j < P; ++j) {
                        C[i * P + j] = 0.0f;
                for (int k = 0; k < N; ++k) {
                        C[i * P + j] += A[i * N + k] * B[k * P + j];
        }
                //if(std::abs(C[i*P+j]) > EPSILON) std::cerr << ".";
}
}
}
bool validate_results(const std::vector<float>& C1, const std::vector<float>&
C2, int M, int P) {
        float aberr = 0;
        for (int i = 0; i < M * P; ++i) {
                aberr += std::fabs(C1[i]-C2[i]);
        if (std::fabs(C1[i] - C2[i])/std::max(std::abs(C1[i]),std::abs(C2[i]))> EPSILON) {
        std::cout << "Mismatch at index " << i << ": " << C1[i] << " vs "
        << C2[i] << std::endl;
        return false;
}
}
return true;
}
void benchmark(int M, int N, int P) {
        std::vector<float> A(M * N), B(N * P), C1(M * P), C2(M * P);
        generate_random_matrix(A, M, N);
        generate_random_matrix(B, N, P);
        auto start = std::chrono::high_resolution_clock::now();
        matrix_multiply(A, B, C1, M, N, P);
        auto end = std::chrono::high_resolution_clock::now();
        std::chrono::duration<double> duration = end - start;
        std::cout << "Matrix multiplication (scalar) took " << duration.count()
<< " seconds.\n";
        double scalar_time = duration.count();
        start = std::chrono::high_resolution_clock::now();
        matrix_multiply_optimize(A, B, C2, M, N, P);
        end = std::chrono::high_resolution_clock::now();
        duration = end - start;
        std::cout << "Matrix multiplication (optimized) took " <<
        duration.count() << " seconds.\n";
        double optimized_time = duration.count();
        std::cout << "Speedup ratio: " << scalar_time / optimized_time << "x\n";
        if (!validate_results(C1, C2, M, P)) {
        std::cout << "Validation failed: Results are different!\n";
        }
}
int main() {
        int NN = 1024;
       int M = NN;  //⾏

       int N = NN;  //列

       int P = NN;  //列

       benchmark(M, N, P);
       return 0;
}