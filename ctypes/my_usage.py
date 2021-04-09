from ctypes import CDLL, POINTER, c_int, c_float
import numpy as np


lib = CDLL("./libtest.so")

n = 3
m = 4

# add scalar
# (to test scalar/array as inputs and/or outputs)

a_scalar = 12.
an_array = np.ones((n, m), order='F', dtype=np.float32)
an_array[2, 1] = 5
the_result = np.ones((n, m), order='F', dtype=np.float32)

lib.c_add_scalar(c_int(n), 
                 c_int(m), 
                 an_array.ctypes.data_as(POINTER(c_float)), 
                 c_float(a_scalar), 
                 the_result.ctypes.data_as(POINTER(c_float)))

print(the_result)

# add array
# (to test modifying array inplace, i.e. Fortran INOUT)

array_one = np.ones((n, m), order='F', dtype=np.float32)
array_two = np.ones((n, m), order='F', dtype=np.float32) * 12
array_one[2, 1] = 5

lib.c_add_array(c_int(n), 
                c_int(m), 
                array_one.ctypes.data_as(POINTER(c_float)),  
                array_two.ctypes.data_as(POINTER(c_float)))

print(array_two)

# store array
# (to test allocatable arrays)

content_array = np.ones((n, m), order='F', dtype=np.float32) * 3
returned_array = np.zeros((n, m), order='F', dtype=np.float32)

lib.c_allocate_internal_array(c_int(n), c_int(m))

lib.c_store_array_content(c_int(n), 
                          c_int(m), 
                          content_array.ctypes.data_as(POINTER(c_float)))

lib.c_return_internal_array(c_int(n), 
                            c_int(m),
                            returned_array.ctypes.data_as(POINTER(c_float)))

print(returned_array)

content_array = np.ones((n, m), order='F', dtype=np.float32) * 3
returned_array = np.zeros((n, m), order='F', dtype=np.float32)

lib.c_store_array_content(c_int(n), 
                          c_int(m), 
                          content_array.ctypes.data_as(POINTER(c_float)))

lib.c_return_internal_array(c_int(n), 
                            c_int(m),
                            returned_array.ctypes.data_as(POINTER(c_float)))

print(returned_array)
