import numpy as np
import libtest


n = 3
m = 4

# add scalar
# (to test scalar/array as inputs and/or outputs)

a_scalar = 12.
an_array = np.ones((n, m), order='F', dtype=np.float32)
an_array[2, 1] = 5

the_result = libtest.test.add_scalar(an_array, a_scalar, n=n, m=m)

print(the_result)

# add array
# (to test modifying array inplace, i.e. Fortran INOUT)

array_one = np.ones((n, m), order='F', dtype=np.float32)
array_two = np.ones((n, m), order='F', dtype=np.float32) * 12
array_one[2, 1] = 5

libtest.test.add_array(array_one, array_two, n=n, m=m)

print(array_two)

# store array
# (to test allocatable arrays)

content_array = np.ones((n, m), order='F', dtype=np.float32) * 3

libtest.test.allocate_internal_array(n, m)

libtest.test.store_array_content(content_array, n=n, m=m)

returned_array = libtest.test.return_internal_array(n, m)

print(returned_array)
print(libtest.test.internal_array)

content_array = np.ones((n, m), order='F', dtype=np.float32) * 3

libtest.test.store_array_content(content_array, n=n, m=m)

returned_array = libtest.test.return_internal_array(n, m)

print(returned_array)
print(libtest.test.internal_array)
