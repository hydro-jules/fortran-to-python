FC := /data/conda/hj-38-nompi/bin/x86_64-conda-linux-gnu-gfortran
FFLAGS := -shared -fPIC

.PHONY: all clean compile

all: clean compile

compile:
	$(FC) $(FFLAGS) my_source.f90 -o libtest.so
    
clean:
	rm -f *.so *.mod
