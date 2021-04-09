import numpy as np
cimport numpy as cnp


cdef extern:
    void c_add_scalar(int n, int m, float *an_array, float a_scalar, float *the_result)
    void c_add_array(int n, int m, float *array_one, float *array_two)
    void c_store_array_content(int n, int m, float *content_array)
    void c_allocate_internal_array(int n, int m)
    void c_return_internal_array(int n, int m, float *an_array)
    
    
def add_scalar(int n, int m, cnp.ndarray[cnp.npy_float32, mode='fortran', ndim=2] an_array, float a_scalar):
    
    cdef cnp.ndarray[cnp.npy_float32, mode='fortran', ndim=2] the_result = np.zeros((n, m), order='F', dtype=np.float32)
    
    c_add_scalar(n, m, &an_array[0, 0], a_scalar, &the_result[0, 0])

    return the_result


def add_array(int n, int m, cnp.ndarray[cnp.npy_float32, mode='fortran', ndim=2] array_one, cnp.ndarray[cnp.npy_float32, mode='fortran', ndim=2] array_two):
    
    c_add_array(n, m, &array_one[0, 0], &array_two[0, 0])
 
    
def store_array_content(int n, int m, cnp.ndarray[cnp.npy_float32, mode='fortran', ndim=2] content_array):
    
    c_store_array_content(n, m, &content_array[0, 0])

        
def allocate_internal_array(int n, int m):
    
    c_allocate_internal_array(n, m)
    
    
def return_internal_array(int n, int m, cnp.ndarray[cnp.npy_float32, mode='fortran', ndim=2] an_array):
    
    c_return_internal_array(n, m, &an_array[0, 0])
    
    return an_array
