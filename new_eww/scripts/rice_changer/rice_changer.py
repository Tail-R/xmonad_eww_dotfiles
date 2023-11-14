#!/usr/bin/python

import os
import sys
import json
import subprocess

workDir = "/.config/eww/scripts/rice_changer"
jsonPath = "./json/riceset.json"
converterPath = "/.config/eww/scripts/convert_images/convert_images.py"
imgDir = "/.config/eww/scripts/convert_images/images"

ewwLauncher0 = "/.config/eww/scripts/launcher/launch_top_bar.sh"
ewwLauncher1 = "/.config/eww/scripts/launcher/launch_left_widget_v2.sh"
ewwLauncher2 = "/.config/eww/scripts/launcher/launch_right_mplayer.sh"
ewwLauncher3 = "/.config/eww/scripts/launcher/launch_bottom_bar.sh"
ewwLauncher4 = "/.config/eww/scripts/launcher/launch_center_dashboard.sh"

#---------------------------------------------------------------------
class RiceManager:
    def __init__(self, rice_name, wall_path, scss_name):
        self.rice_name = rice_name
        self.wall_path = wall_path
        self.scss_name = scss_name
    
    def add_rice(self):
        HOME=os.environ["HOME"]
        
        # Read the json file
        with open(jsonPath, 'r') as f:
            rice_list = json.load(f)

        # Check the name collision
        if (rice_list != []):
            for rice in rice_list:
                if (rice["rice_name"] == self.rice_name):
                    print("The name is already used.")
                    return

        rice = dict(rice_name=self.rice_name,
                    wall_path=self.wall_path,
                    scss_name=self.scss_name)

        # Add a new rice
        rice_list.append(rice)
            
        # It's absolutely IDIOT. but im lazy uwu*
        # Save blurred wall
        subprocess.run(HOME + converterPath + " -b " +
                       HOME + "/Pictures/wallpapers/" + rice["wall_path"] +
                       " " + "/images/wall_blur/" + rice["wall_path"], shell=True)

        # Save ziped wall
        subprocess.run(HOME + converterPath + " -z " +
                       HOME + "/Pictures/wallpapers/" + rice["wall_path"] +
                       " " + "/images/zip_imgs/" + rice["wall_path"], shell=True)
        
        # Overwrite the json file
        with open(jsonPath, 'w') as f:
            json.dump(rice_list, f, indent=4)

#---------------------------------------------------------------------
def del_rice(rice_name):
    # Read the json file
    with open(jsonPath, 'r') as f:
        rice_list = json.load(f)
   
    # Remove the blurred wall
    # Remove the ziped wall
    for rice in rice_list:
        if rice["rice_name"] == rice_name:
            cmd = "rm -f " + os.environ["HOME"] + imgDir + "/wall_blur/" + rice["wall_path"]            
            subprocess.run(cmd, shell=True) 
            
            cmd = "rm -f " + os.environ["HOME"] + imgDir + "/zip_imgs/" + rice["wall_path"]
            subprocess.run(cmd, shell=True)

    # Delete the specified rice
    rice_list = [rice for rice in rice_list if (rice_name != rice["rice_name"])]

    # Overwrite the json file
    with open(jsonPath, 'w') as f:
        json.dump(rice_list, f, indent=4)

def del_all():
    # Read the json file
    # Remove the images
    with open(jsonPath, 'r') as f:
        rice_list = json.load(f)
        
        for rice in rice_list:
            cmd = "rm -f " + os.environ["HOME"] + imgDir + "/wall_blur/" + rice["wall_path"]            
            subprocess.run(cmd, shell=True) 
            
            cmd = "rm -f " + os.environ["HOME"] + imgDir + "/zip_imgs/" + rice["wall_path"]
            subprocess.run(cmd, shell=True)
        
    # Delete everything
    with open(jsonPath, 'w') as f:
        json.dump([], f, indent=4)


def set_rice(rice_name):
    HOME=os.environ["HOME"]
    CDIR=os.getcwd()
    
    # Read the json file
    with open(jsonPath, 'r') as f:
        rice_list = json.load(f)

    for rice in rice_list:
        if rice["rice_name"] == rice_name:
            
            subprocess.run(HOME + ewwLauncher0 + " --close", shell=True)
            subprocess.run(HOME + ewwLauncher1 + " --close", shell=True)
            subprocess.run(HOME + ewwLauncher2 + " --close", shell=True)
            subprocess.run(HOME + ewwLauncher3 + " --close", shell=True)
            
            subprocess.run(CDIR + "/./wallpaper.sh --set " + rice["wall_path"], shell=True)
            subprocess.run(CDIR + "/./chcolor.sh " + rice["scss_name"], shell=True)
            
            subprocess.run(HOME + ewwLauncher4 + " --close", shell=True) 
            
            subprocess.run(HOME + ewwLauncher0 + " --open", shell=True)
            subprocess.run(HOME + ewwLauncher1 + " --open", shell=True)
            subprocess.run(HOME + ewwLauncher2 + " --open", shell=True)
            subprocess.run(HOME + ewwLauncher3 + " --open", shell=True)
            
def sort_by(rice_name):
    with open(jsonPath, 'r') as f:
        rice_list = json.load(f)
    
    sorted_rice_list = [rice for rice in rice_list if (rice_name == rice["rice_name"])] + [rice for rice in rice_list if (rice_name != rice["rice_name"])]
    
    with open(jsonPath, 'w') as f:
        json.dump(sorted_rice_list, f, indent=4)

#---------------------------------------------------------------------
def main():
    os.chdir(os.environ["HOME"] + workDir)
    args = sys.argv
    HOME=os.environ["HOME"]

    # Create img dir
    if not os.path.isdir(HOME + imgDir):
        subprocess.run("mkdir " + HOME + imgDir, shell=True)

    # Create json dir
    if not os.path.isdir("./json"):
        subprocess.run("mkdir ./json", shell=True)

    # Create json file
    if not os.path.isfile(jsonPath):
        subprocess.run("touch " + jsonPath, shell=True)
        subprocess.run("echo '[]' > " + jsonPath, shell=True)

    # Check the args
    try:
        if args[1] == "--add":
            rice_manager = RiceManager(args[2], args[3], args[4])
            rice_manager.add_rice()

        elif args[1] == "--del":
            if args[2] == "-a":
                del_all()
            else:
                del_rice(args[2])
 
        elif args[1] == "--set":
            set_rice(args[2])

        elif args[1] == "--sort_by":
            sort_by(args[2])
    except IndexError:
        print("Invalid args!", file=sys.stderr)
        sys.exit(1)

if __name__ == "__main__":
    main()

