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

# demo
run test_kitti.m for a pair of images
run test.m for images in two different folders and change disparity to depth
 