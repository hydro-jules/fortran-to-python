from distutils.core import setup
from distutils.extension import Extension

from Cython.Distutils import build_ext
from Cython.Build import cythonize

import numpy as np


ext_modules = [
    Extension(
        name='libtest',
        sources=['./my_wrapper.pyx'],
        include_dirs=[np.get_include()],
        extra_objects=['./my_source.o']
    )
]

setup(
    name='libtest',
    cmdclass={'build_ext': build_ext},
    include_dirs=[np.get_include()],
    ext_modules=cythonize(ext_modules)
)
