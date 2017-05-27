from PIL import Image
from os import listdir
from os.path import isfile, join

# myPath = "./stereo_img_left/"
# targetPath = "./kinect_img_left/"

# myPath = "./stereo_gdepth/"
# # targetPath = "./kinect_gdepth/"
# myPath = "/home/xiyu/Documents/Realistic_rendering_model_1000_Hz/depth_kinect/"
# targetPath = "/home/xiyu/Documents/Realistic_rendering_model_1000_Hz/depth_kinect1/"

# myPath = "/home/xiyu/Downloads/06/image_2/"
# targetPath = "/home/xiyu/Desktop/sgm_stereo/kinect_kitti_rgb/"

# myPath = "/home/xiyu/Desktop/sgm_stereo/stereo_depth_kitti_06_1/"
# targetPath = "/home/xiyu/Desktop/sgm_stereo/kinect_kitti_depth_1/"

myPath = "/home/xiyu/Downloads/06/image_2/"
targetPath = "/home/xiyu/Downloads/06/image_4/"

files = [f for f in listdir(myPath)]
for f in files:
	fullPath = myPath + f
	splitName = f.split(".")
	fullTargetPath = targetPath + splitName[0] + ".pgm"
	im = Image.open(fullPath)
	im.save(fullTargetPath)
