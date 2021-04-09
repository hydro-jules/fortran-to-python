module test_mod

    use iso_c_binding, only: c_float, c_int

    implicit none 
    
    real, allocatable :: internal_array(:, :)

    contains

    subroutine add_scalar(n, m, an_array, a_scalar, the_result)

        implicit none

        integer, intent(in) :: n, m
        real, intent(in) :: an_array(n, m)
        real, intent(in) :: a_scalar
        real, intent(out) :: the_result(n, m)

        the_result(:, :) = an_array(:, :) + a_scalar
        the_result(n-1, m-1) = -9

    end subroutine add_scalar    

    subroutine add_array(n, m, array_one, array_two)

        implicit none

        integer, intent(in) :: n, m
        real, intent(in) :: array_one(n, m)
        real, intent(inout) :: array_two(n, m)

        array_two(:, :) = array_one(:, :) + array_two(:, :)
        array_two(n-1, m-1) = -9

    end subroutine add_array
    
    subroutine store_array_content(n, m, content_array)

        implicit none

        integer, intent(in) :: n, m
        real, intent(in) :: content_array(n, m)

        internal_array(:, :) = internal_array(:, :) + content_array(:, :)
        internal_array(n-1, m-1) = internal_array(n-1, m-1) + 1

    end subroutine store_array_content

    subroutine allocate_internal_array(n, m)

        implicit none

        integer, intent(in) :: n, m

        if (.not. allocated(internal_array)) allocate(internal_array(n, m))
        
        internal_array(:, :) = 0.0

    end subroutine allocate_internal_array

    subroutine return_internal_array(n, m, an_array)

        implicit none

        integer, intent(in) :: n
        integer, intent(in) :: m
        real, intent(out) :: an_array(n, m)

        an_array(:, :) = internal_array(:, :)

    end subroutine return_internal_array

    ! C wrapper functions
    
    subroutine c_add_scalar(n, m, an_array, a_scalar, the_result) bind(c, name='c_add_scalar')
    
        use iso_c_binding, only: c_float, c_int
    
        implicit none
        
        ! by default, arguments are passed by reference in fortran (i.e. using pointers), 
        ! "value" is used if argument passed by value. If a pointer was given on the Python side,
        ! the "value" should be dropped
        integer(c_int), intent(in), value :: n
        integer(c_int), intent(in), value :: m
        real(c_float), intent(in) :: an_array(n, m)
        real(c_float), intent(in), value :: a_scalar
        real(c_float), intent(out) :: the_result(n, m)
        
        call add_scalar(n, m, an_array, a_scalar, the_result)

    end subroutine c_add_scalar
    
    subroutine c_add_array(n, m, array_one, array_two) bind(c, name='c_add_array')
    
        implicit none
        
        integer(c_int), intent(in), value :: n
        integer(c_int), intent(in), value :: m
        real(c_float), intent(in) :: array_one(n, m)
        real(c_float), intent(inout) :: array_two(n, m)
        
        call add_array(n, m, array_one, array_two)

    end subroutine c_add_array
    
    subroutine c_store_array_content(n, m, content_array) bind(c, name='c_store_array_content')

        implicit none

        integer(c_int), intent(in), value :: n
        integer(c_int), intent(in), value :: m
        real(c_float), intent(in) :: content_array(n, m)

        call store_array_content(n, m, content_array)

    end subroutine c_store_array_content

    subroutine c_allocate_internal_array(n, m) bind(c, name='c_allocate_internal_array')

        implicit none

        integer(c_int), intent(in), value :: n
        integer(c_int), intent(in), value :: m

        call allocate_internal_array(n, m)

    end subroutine c_allocate_internal_array

    subroutine c_return_internal_array(n, m, an_array) bind(c, name='c_return_internal_array')

        implicit none

        integer(c_int), intent(in), value :: n
        integer(c_int), intent(in), value :: m
        real(c_float), intent(out) :: an_array(n, m)

        call return_internal_array(n, m, an_array)

    end subroutine c_return_internal_array
    
end module test_mod
