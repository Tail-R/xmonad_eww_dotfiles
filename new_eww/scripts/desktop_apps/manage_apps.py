#!/usr/bin/python

import os
import sys
import subprocess
import json

import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk
from gi.repository import Gio

workDir = "/.config/eww/scripts/desktop_apps"
ewwPath = "$HOME/.config/eww"
iconSize = 100

#---------------------------------------------------------------------
class DesktopApp:
    def __init__(self, disp_name, exec_name, icon_path):
        self.disp_name = disp_name
        self.exec_name = exec_name
        self.icon_path = icon_path

#---------------------------------------------------------------------
# return Json array of the all desktop apps objects
def get_json_all_apps():
    icon_theme = Gtk.IconTheme.get_default() 
    all_apps_obj = Gio.AppInfo.get_all()
    
    all_apps = []

    # create object array
    for app in all_apps_obj:
        icon_obj = app.get_icon()
        icon_path = ""

        if (icon_obj is not None):
            icon_name = icon_obj.get_names()[0]
            icon_info = icon_theme.lookup_icon(icon_name, iconSize, 0)
            icon_path = "" if icon_info is None else icon_info.get_filename()
        else:
            icon_path = ""

        all_apps.append(DesktopApp(app.get_display_name(),
                                   app.get_executable(),
                                   icon_path))
 
    buffered = ""
    
    # convert an array to the json format
    for app in all_apps:
        buffered += json.dumps(app.__dict__) + ","

    return "[" + buffered[:-1] + "]"

def update_eww(): 
    json_all_apps = get_json_all_apps()

    # formating
    cmd = "eww -c " + ewwPath + " update " + "JSON_DESKTOP_APPS=" + "'" + json_all_apps + "'"
    
    # update an eww variable
    subprocess.run(cmd, shell=True)

def exec_app(app):
    pass

#---------------------------------------------------------------------
def main():
    os.chdir(os.environ["HOME"] + workDir) 
    args = sys.argv

    try:
        if (args[1] == "--update_eww"):
            update_eww()

    except IndexError:
        print("Invalid args!", file=sys.stderr)
        sys.exit(1)

if __name__ == '__main__':
    main()



