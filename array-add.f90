program hello
    integer :: array0(5)
    integer :: sum, j, i

    array0 = [(i, i = 16,20)]
    sum = 0

    do j = 1, size(array0)
        i = array0(j)
        sum = sum + i
    end do
    print *, sum
end program hello
