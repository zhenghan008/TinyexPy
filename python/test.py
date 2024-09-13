from tinyexpy import Tinyexpy


def test_py_te_interp():
    T = Tinyexpy()
    return T.py_te_interp(expression="3+3", error=0)


def test_py_te_interp_customize():
    T = Tinyexpy()
    return T.py_te_interp_customize(expression="x+1+z",
                                    py_vars=[{"name": "x", "value": 2.0}, {"name": "y", "value": 5},
                                             {"name": "z", "value": 7}])


def test_te_interp_my_func():
    T = Tinyexpy()
    return T.py_te_interp_my_func("my_add", "my_add(5, 10)")


if __name__ == '__main__':
    for i in dir():
        if i.startswith('test'):
            globals()[i]()

