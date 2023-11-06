#!/usr/bin/python

import os
import sys
import json
import subprocess

workDir = "/.config/eww/scripts/rice_changer"
jsonPath = "./json/riceset.json"

#---------------------------------------------------------------------
class RiceManager:
    def __init__(self, rice_name, wall_path, scss_name):
        self.rice_name = rice_name
        self.wall_path = wall_path
        self.scss_name = scss_name
    
    def add_rice(self):
        # Read the json file
        with open(jsonPath, 'r') as f:
            rice_list = json.load(f)
            
        rice = dict(rice_name=self.rice_name,
                    wall_path=self.wall_path,
                    scss_name=self.scss_name)

        # Add a new rice
        rice_list.append(rice)

        # Overwrite the json file
        with open(jsonPath, 'w') as f:
            json.dump(rice_list, f, indent=4)

#---------------------------------------------------------------------
def del_rice(rice_name):
    # Read the json file
    with open(jsonPath, 'r') as f:
        rice_list = json.load(f)
    
    # Delete the specified rice
    for rice in rice_list:
        if rice["rice_name"] == rice_name:
            pass

    # Overwrite the json file
    with open(jsonPath, 'w') as f:
        json.dump(rice_list, f, indent=4)

def set_rice(rice_name):
    # Read the json file
    with open(jsonPath, 'r') as f:
        rice_list = json.load(f)

    for rice in rice_list:
        if rice["rice_name"] == rice_name:
            subprocess.run(os.getcwd() + "/./wallpaper.sh --set " + rice["wall_path"], shell=True)
            subprocess.run(os.getcwd() + "/./chcolor.sh " + rice["scss_name"], shell=True)


#---------------------------------------------------------------------
def main():
    os.chdir(os.environ["HOME"] + workDir)
    args = sys.argv

    # Create files
    if not os.path.isdir("./json"):
        subprocess.run("mkdir ./json", shell=True)

    if not os.path.isfile(jsonPath):
        subprocess.run("touch " + jsonPath, shell=True)
        subprocess.run("echo '[]' > " + jsonPath, shell=True)

    if args[1] == "--add":
        rice_manager = RiceManager(args[2], args[3], args[4])
        rice_manager.add_rice()

    elif args[1] == "--del":
        del_rice(args[2])
    
    elif args[1] == "--set":
        set_rice(args[2])
    

if __name__ == "__main__":
    main()

