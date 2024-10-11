#include <stdio.h>
#include <cuda.h>
#include <cuda_runtime.h>

__global__ void cuda_hello() {
    printf("Hello World\n");
}

__global__ void cuda_add(int *a, int *b, int *c) {
    *c += *a + *b;
    printf("%d %d %ul\n", threadIdx.x, blockIdx.x, (uint64_t) c);
}

int main() {
    int a = 7, b = 10, c;
    // cuda_hello<<<1024, 1024>>>();

    int *d_a, *d_b, *d_c;

    cudaMalloc((void **) &d_a, 3 * sizeof(int));
    d_b = d_a + 1;
    d_c = d_a + 2;

    cudaMemcpy(d_a, &a, sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, &b, sizeof(int), cudaMemcpyHostToDevice);

    cuda_add<<<3, 64>>>(d_a, d_b, d_c);

    cudaMemcpy(&c, d_c, sizeof(int), cudaMemcpyDeviceToHost);
    cudaDeviceSynchronize();
    printf("%d\n", c);
    return 0;
}
