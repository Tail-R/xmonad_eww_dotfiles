#!/usr/bin/python

######################################################################
## you need to install opencv for python
######################################################################

import os
import sys
import subprocess
import cv2 # sudo pacman -S python-opencv

out_path = "/images/res.png"

def make_blurrrrrrr(path):
    try:
        img = cv2.imread(path)
    except:
        print("invalid args!", file=sys.stderr)
        sys.exit(1)
    
    # Blurrrrrrr
    res = cv2.GaussianBlur(img, (15, 15), 3)
    cv2.imwrite(os.getcwd() + out_path, res)
    
    cmd = "echo " + os.getcwd() + out_path
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
    os.chdir(os.environ["HOME"] + "/.config/eww/scripts/convert_images")
    # print(os.getcwd())
   
    args = sys.argv

    if (args[1] == "-b"):
        make_blurrrrrrr(args[2])
    elif (args[1] == "-c"):
        get_one_color(args[2])

if __name__ == '__main__':
    main()

