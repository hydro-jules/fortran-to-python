FC := /data/conda/hj-38-nompi/bin/x86_64-conda-linux-gnu-gfortran

.PHONY: all compile clean

all: clean compile

compile:
	python -m numpy.f2py -c my_source.f90 -m libtest --f90exec=$(FC)
    
clean:
	rm -f *.so
