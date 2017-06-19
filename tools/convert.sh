#this script is used to convert png format to klg format, a tool of png_to_klg should be installed 
cp ./depth_autoVision/*.png /home/xiyu/Desktop/project/png_to_klg/AutoVision/depth
cp /home/xiyu/Downloads/LeftStereo_rectfiedPinhole/left/*.png /home/xiyu/Desktop/project/png_to_klg/AutoVision/rgb
cd /home/xiyu/Desktop/project/png_to_klg/build/
./pngtoklg -w ../AutoVision -o autoVision.klg
cd ../AutoVision/
cp autoVision.klg /home/xiyu/Desktop/project/ElasticFusion/GUI/build






