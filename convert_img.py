from PIL import Image
from os import listdir
from os.path import isfile, join
targetpath = "/home/xiyu/Desktop/sgm_stereo/kitti_rgb" 
mypath = "/home/xiyu/Desktop/sgm_stereo/kinect_kitti_rgb"
onlyfiles = [f for f in listdir(mypath) if isfile(join(mypath, f))]
for f in onlyfiles:
	nameList = f.split('.')
	newfile = join(targetpath, nameList[0])
	newfile = newfile+'.png'
	print newfile
	im = Image.open(join(mypath,f))
	im.save(newfile) 
