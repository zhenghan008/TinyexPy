ctypedef union te_expr_u:
    double value
    const double *bound
    const void *function

ctypedef  struct te_expr:
    int type
    te_expr_u u
    void *parameters[1]

ctypedef struct te_variable:
    const char *name
    const void *address
    int type
    void *context

cdef enum:
    TE_VARIABLE = 0,
    TE_FUNCTION0 = 8, TE_FUNCTION1, TE_FUNCTION2, TE_FUNCTION3,
    TE_FUNCTION4, TE_FUNCTION5, TE_FUNCTION6, TE_FUNCTION7,
    TE_CLOSURE0 = 16, TE_CLOSURE1, TE_CLOSURE2, TE_CLOSURE3,
    TE_CLOSURE4, TE_CLOSURE5, TE_CLOSURE6, TE_CLOSURE7,
    TE_FLAG_PURE = 32


cdef extern from "tinyexpr.h" nogil:


    double te_interp(const char *expression, int *error)

    te_expr *te_compile(const char *expression, const te_variable *variables, int var_count, int *error)

    double te_eval(const te_expr *n)

    void te_print(const te_expr *n)

    void te_free(te_expr *n)
