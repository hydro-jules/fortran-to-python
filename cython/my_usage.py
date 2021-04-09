import numpy as np
import libtest


n = 3
m = 4

# add scalar
# (to test scalar/array as inputs and/or outputs)

a_scalar = 12.
an_array = np.ones((n, m), order='F', dtype=np.float32)
an_array[2, 1] = 5.

the_result = libtest.add_scalar(n, m, an_array, a_scalar)

print(the_result)

# add array
# (to test modifying array inplace, i.e. Fortran INOUT)

array_one = np.ones((n, m), order='F', dtype=np.float32)
array_two = np.ones((n, m), order='F', dtype=np.float32) * 12
array_one[2, 1] = 5.

libtest.add_array(n, m, array_one, array_two)

print(array_two)

# store array
# (to test allocatable arrays)

content_array = np.ones((n, m), order='F', dtype=np.float32) * 3
returned_array = np.zeros((n, m), order='F', dtype=np.float32)

libtest.allocate_internal_array(n, m)

libtest.store_array_content(n, m, content_array)

libtest.return_internal_array(n, m, returned_array)

print(returned_array)

content_array = np.ones((n, m), order='F', dtype=np.float32) * 3
returned_array = np.zeros((n, m), order='F', dtype=np.float32)

libtest.store_array_content(n, m, content_array)

libtest.return_internal_array(n, m, returned_array)

print(returned_array)
