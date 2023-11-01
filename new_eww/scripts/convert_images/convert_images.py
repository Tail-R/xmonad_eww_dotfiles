#!/usr/bin/python

######################################################################
## you need to install opencv, numpy
######################################################################

import os
import sys
import subprocess
import numpy as np # sudo pacman -S python-numpy
import cv2 # sudo pacman -S python-opencv

workDir = "/.config/eww/scripts/convert_images"
out_name = "/res.png"

def make_blurrrrrrr(path, opt_path):
    try:
        img = cv2.imread(path)
    except:
        print("invalid args!", file=sys.stderr)
        sys.exit(1)

    beta = 70      # must be 0 ~ 255
    height, width = img.shape[:2]
    
    # Blurrrrrrr
    blur_res = cv2.GaussianBlur(img, (15, 15), 5)
    dark_res = cv2.subtract(blur_res, np.full((height, width, 3), beta, np.uint8))

    cv2.imwrite(os.getcwd() + opt_path + out_name, dark_res)
    
    cmd = "echo " + os.getcwd() + opt_path + out_name
    subprocess.run(cmd, shell=True)

def get_one_color(path):
    try:
        img = cv2.imread(path)
    except:
        print("invalid args!", file=sys.stderr)
        sys.exit(1)
    
    print("hehehe")

#---------------------------------------------------------------------
def main():
    os.chdir(os.environ["HOME"] + workDir)
    # print(os.getcwd())
   
    args = sys.argv

    if (args[1] == "-b"):
        make_blurrrrrrr(args[2], args[3])
    elif (args[1] == "-c"):
        get_one_color(args[2])

if __name__ == '__main__':
    main()

