#include <cuda.h>
#include <stdio.h>
#include <stdlib.h>

__global__ void sum_array(int *sum, int *array, int blks, int len) {
    uint32_t s = 0;
    uint32_t start = (len / blks) * blockIdx.x;
    uint32_t end = start + (len / blks);

    for (int i = start; i < end; i++) {
        s += array[i];
    }

    sum[blockIdx.x] = s; 
}

int main() {
    int al = 5e6, nb = 999, i;
    int *array, *result;
    int *d_array, *d_result;
    cudaError_t err;

    result = (int *) malloc(sizeof(int) * (1 + nb * al));
    array = result + nb;

    if (result == NULL) {
        printf("Failed to malloc data\n");
        return 1;
    }

    for (i = 0; i < al; i++) {
        array[i] = 16 + i;
    }

    if ((err = cudaMalloc((void **) &d_result, sizeof(int) * (1 + nb * al))) != cudaSuccess) {
        printf("Failed to malloc data: %s\n", cudaGetErrorString(err));
        return 1;
    }
    // cudaMalloc((void **) &d_array, sizeof(int) * nb * al);
    d_array = d_result + nb;

    err = cudaMemcpy(d_array, array, al * sizeof(int), cudaMemcpyHostToDevice);

    if (err != cudaSuccess) {
        printf("err: %s\n", cudaGetErrorString(err));
        return 1;
    }

    sum_array<<<nb, 1>>>(d_result, d_array, nb, al);
    cudaDeviceSynchronize();
    cudaMemcpy(result, d_result, nb * sizeof(int), cudaMemcpyDeviceToHost);

    int sum = 0;

    for (i = 0; i < nb; i++) {
        sum += result[i];
    }

    printf("Sum: %d\n", sum);
}
