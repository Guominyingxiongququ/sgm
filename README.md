# sgm_stereo

# first build daisy libraries in daisy-1.8.1 (see usage)
cd daisy-1.8.1
make library

# then build this:
mkdir build
cd build
cmake .. -DDAISY=../daisy-1.8.1/lib/libdaisy.a
make
sgm
