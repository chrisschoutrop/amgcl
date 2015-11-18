module amgcl
    use iso_c_binding

    type, bind(C) :: conv_info
        integer (c_int)    :: iterations
        real    (c_double) :: residual
    end type

    interface
        integer(c_size_t) &
        function amgcl_params_create() bind (C, name="amgcl_params_create")
            use iso_c_binding
        end function

        subroutine amgcl_params_seti(prm, name, val) bind (C, name="amgcl_params_seti")
            use iso_c_binding
            integer   (c_size_t), intent(in), value :: prm
            character (c_char),   intent(in)        :: name(*)
            integer   (c_int),    intent(in), value :: val
        end subroutine

        subroutine amgcl_params_setf(prm, name, val) bind (C, name="amgcl_params_setf")
            use iso_c_binding
            integer   (c_size_t), intent(in), value :: prm
            character (c_char),   intent(in)        :: name(*)
            real      (c_float),  intent(in), value :: val
        end subroutine

        subroutine amgcl_params_sets(prm, name, val) bind (C, name="amgcl_params_sets")
            use iso_c_binding
            integer   (c_size_t), intent(in), value :: prm
            character (c_char),   intent(in)        :: name(*)
            character (c_char),   intent(in)        :: val(*)
        end subroutine

        subroutine amgcl_params_destroy(prm) bind(C, name="amgcl_params_destroy")
            use iso_c_binding
            integer (c_size_t), intent(in), value :: prm
        end subroutine

        integer(c_size_t) &
        function amgcl_solver_create (n, ptr, col, val, prm) bind (C, name="amgcl_solver_create_f")
            use iso_c_binding
            integer (c_int),    intent(in), value :: n
            integer (c_int),    intent(in)        :: ptr(*)
            integer (c_int),    intent(in)        :: col(*)
            real    (c_double), intent(in)        :: val(*)
            integer (c_size_t), intent(in), value :: prm
        end function

        type(conv_info) &
        function amgcl_solver_solve(solver, rhs, x) bind (C, name="amgcl_solver_solve")
            use iso_c_binding
            integer (c_size_t), intent(in), value :: solver
            real    (c_double), intent(in)        :: rhs(*)
            real    (c_double), intent(inout)     :: x(*)

            type, bind(C) :: conv_info
                integer (c_int)    :: iterations;
                real    (c_double) :: residual
            end type
        end function

        subroutine amgcl_solver_report(solver) bind(C, name="amgcl_solver_report")
            use iso_c_binding
            integer (c_size_t), intent(in), value :: solver
        end subroutine

        subroutine amgcl_solver_destroy(solver) bind(C, name="amgcl_solver_destroy")
            use iso_c_binding
            integer (c_size_t), intent(in), value :: solver
        end subroutine
    end interface
end module