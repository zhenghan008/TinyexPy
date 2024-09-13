cimport tinyexpy
from libc cimport stdlib
from typing import List, Callable, Any





cdef class Tinyexpy:

    @staticmethod
    cdef double add(double a, double b):
        return a + b


    def py_te_interp(self, expression: str, error: int) -> float:
        py_expression = expression.encode("utf8")
        cdef int c_error = error
        cdef char *c_expression = py_expression
        cdef double res = te_interp(c_expression, &c_error)
        print(f"Evaluating:\n\t{c_expression.decode('utf8')}\nResult:\n\t{res}\n")
        return res


    def  py_te_interp_customize(self, expression: str, py_vars: List[dict]):
        cdef char *te_variable_name
        cdef char *c_expression
        cdef int var_count = len(py_vars)
        cdef int c_err
        cdef te_expr *n
        cdef double[100] x
        cdef double r
        cdef te_variable c_te_variable
        cdef te_variable[100] vars
        py_expression = expression.encode("utf8")
        c_expression = py_expression
        for i, each_py_vars in enumerate(py_vars):
            each_value = each_py_vars.get("value")
            if isinstance(each_value, float) or  isinstance(each_value, int):
                each_name = each_py_vars.get("name").encode("utf8")
                te_variable_name = each_name
                x[i] = float(each_value)
                c_te_variable = te_variable(te_variable_name, &x[i])
                vars[i] = c_te_variable
        n = te_compile(c_expression, vars, var_count, &c_err)
        if n != NULL:
            # te_print(n)
            r = te_eval(n)
            te_free(n)
            print(f"Evaluating:\n\t{c_expression.decode('utf8')}\nResult:\n\t{r}\n")
            return r



    def  py_te_interp_my_func(self, func_name: str, expression: str):
         cdef te_variable[1] vars
         cdef char *c_expression
         cdef char *myfunc
         cdef int c_err
         cdef te_expr *n
         cdef double r
         py_expression = expression.encode("utf8")
         py_func_name = func_name.encode("utf8")
         c_expression = py_expression
         myfunc = py_func_name
         vars[0] = te_variable(name=myfunc, address=<double (*)(double, double)>self.add, type=TE_FUNCTION2)
         n = te_compile(c_expression, vars, 1, &c_err)
         if n != NULL:
             # te_print(n)
             r = te_eval(n)
             te_free(n)
             print(f"Evaluating:\n\t{c_expression.decode('utf8')}\nResult:\n\t{r}\n")
             return r
          
