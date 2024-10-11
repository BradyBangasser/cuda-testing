program hello
    integer :: array0(10)
    array0 = [(i, i = 1,10)]
    print *, array0(1:)
end program hello
