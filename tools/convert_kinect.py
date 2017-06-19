# this script is used to convert image to pgm format

from PIL import Image
from os import listdir
from os.path import isfile, join


# set the path of convert folder
myPath = "/home/xiyu/Downloads/06/image_2/"
targetPath = "/home/xiyu/Downloads/06/image_4/"

files = [f for f in listdir(myPath)]
for f in files:
	fullPath = myPath + f
	splitName = f.split(".")
	fullTargetPath = targetPath + splitName[0] + ".pgm"
	im = Image.open(fullPath)
	im.save(fullTargetPath)
