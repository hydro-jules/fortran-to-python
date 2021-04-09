FC := /data/conda/hj-38-nompi/bin/x86_64-conda-linux-gnu-gfortran
FFLAGS := -shared -fPIC -O3

.PHONY: all clean compile build_ext

all: clean compile build_ext

compile:
	$(FC) $(FFLAGS) my_source.f90 -o my_source.o
    
build_ext:
	python setup.py build_ext --inplace

clean:
	rm -f -r ./build
	rm -f *.so *.o *.mod *.c
