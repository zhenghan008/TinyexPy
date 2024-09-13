from distutils.core import setup, Extension
from Cython.Build import cythonize


ext = [Extension("tinyexpy",
                 sources=["tinyexpy.pyx", "../tinyexpr.c"],
                 include_dirs=['../'],
                 depends=["../tinyexpr.h"],
                 )]

setup(name="tinyexpy", ext_modules=cythonize(ext, language_level=3))
