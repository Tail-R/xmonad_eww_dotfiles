#!/usr/bin/python

import os
import sys
import re
import json
import subprocess

import Xlib.X
import Xlib.display

import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk

imgPath = "/.config/eww/images/cat.png"
icon_size = 64

#---------------------------------------------------------------------
class AppIcon:
    def __init__(self, win_id, icon_path):
        self.win_id = win_id
        self.icon_path = icon_path

#---------------------------------------------------------------------
def get_gtk_icon(icon_name):
    icon_theme = Gtk.IconTheme.get_default()
    icon_info = icon_theme.lookup_icon(icon_name, icon_size, 0)
    
    return os.environ['HOME'] + imgPath if icon_info is None else icon_info.get_filename()

#---------------------------------------------------------------------
def main():
    # Open display
    disp = Xlib.display.Display()
    
    if (disp == None):
        print("Can't open display!", file=sys.stderr)
        sys.exit(1)

    # Get the root window
    root = disp.screen().root

    if (root == None):
        print("Can't get root window!", file=sys.stderr)
        sys.exit(1)

    # Get atom name
    NET_CLIENT_LIST = disp.intern_atom('_NET_CLIENT_LIST')
    WM_CLASS = disp.intern_atom('WM_CLASS')
    
    res = root.get_full_property(NET_CLIENT_LIST, Xlib.X.AnyPropertyType).value

    all_apps_icon = []

    for i in res:
        win = disp.create_resource_object("window", i)
        byte_name = win.get_full_property(WM_CLASS, Xlib.X.AnyPropertyType).value

        if byte_name:
            icon_name = byte_name.decode().split("\x00")[1]
            all_apps_icon.append(AppIcon(i, get_gtk_icon(icon_name)))

    buffered = ""

    for app_icon in all_apps_icon:
        buffered += json.dumps(app_icon.__dict__) + ","

    print ("[" + buffered[:-1] + "]")

if __name__ == "__main__":
    main()


