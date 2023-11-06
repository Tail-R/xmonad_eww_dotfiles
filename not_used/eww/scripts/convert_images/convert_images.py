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
tHold = 200
inc_val = 50

def make_blurrrrrrr(path, opt_path):
    img = cv2.imread(path)

    if img is None:
        print("invalid path!", file=sys.stderr)
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
    img = cv2.imread(path)

    if img is None:
        print("invalid path!", file=sys.stderr)
        sys.exit(1)

    start_h = img.shape[0] / 2.5
    start_v = img.shape[1] / 2.5
    end_v = img.shape[0] / 2
    end_h = img.shape[1] / 2

    small_area = img[int(start_v): int(end_v),
                     int(start_h): int(end_h)]

    # # Show img
    # cv2.imshow("Image", small_area)
    # cv2.waitKey()

    b = int(small_area.T[0].flatten().mean())
    g = int(small_area.T[1].flatten().mean())
    r = int(small_area.T[2].flatten().mean())

    if (b < tHold or g < tHold or r < tHold):
        if (b + inc_val < 255 and
            g + inc_val < 255 and
            r + inc_val < 255):
            
            b += inc_val
            g += inc_val
            r += inc_val

    hex_b = hex(b)[2:] 
    hex_g = hex(g)[2:]
    hex_r = hex(r)[2:]
 
    # Output color
    cmd = "echo " + hex_r + hex_g + hex_b
    subprocess.run(cmd, shell=True)

#---------------------------------------------------------------------
def main():
    os.chdir(os.environ["HOME"] + workDir)
    # print(os.getcwd())
   
    args = sys.argv

    try:
        if (args[1] == "-b"):
            make_blurrrrrrr(args[2], args[3])
        elif (args[1] == "-c"):
            get_one_color(args[2])
    except IndexError:
        print("invalid args!", file=sys.stderr)
        sys.exit(1)
        


if __name__ == '__main__':
    main()



