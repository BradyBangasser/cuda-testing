cuda: out cuda-array-sum.out
fort: out fort-array-sum.out
c: out c-array-sum.out

out: 
	mkdir out

cuda-array-sum.out: out/array-sum.cu.o
	nvcc !$ -o $@ -O3

fort-array-sum.out: out/array-sum.f90.o
	gfort $^ -o $@ -O3

c-array-sum.out: out/array-sum.c.o
	clang $^ -o $@ -O3

out/%.cu.o: %.cu
	nvcc -c $^ -o $@ -O3

out/%.f90.o: %.f90
	gfort -c $^ -o $@ -O3

out/%.o: %
	clang -c $^ -o $@ -O3
out/test.c.o: test.c
	clang -c $^ -o $@ -O3
