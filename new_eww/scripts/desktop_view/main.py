#!/usr/bin/python

import os
import subprocess
# import time
import json
import Xlib.X
import Xlib.display
import Xlib.error

#---------------------------------------------------------------------
workDir = "/.config/eww/scripts/desktop_view"
ewwPath = "$HOME/.config/eww"
logFile = "./log.txt"
scripts = "$HOME/.config/eww/scripts/desktop_view/manage_images.sh"
cmd0 = "sleep 0.1 && maim -i "
cmd1 = " -u ./images/"
fmt = ".jpg"

#---------------------------------------------------------------------
class Thumbnail:
    def __init__(self, desk_num):
        self.desk_num = desk_num
        self.img_path_array = []

#---------------------------------------------------------------------
def output_json(vdesk_array, nod):
    buffered = ""
    
    for i in range(nod):
        buffered += json.dumps(vdesk_array[i].__dict__) + ","

    res = json.dumps("[" + buffered[:-1] + "]")
     
    cmd = "eww -c " + ewwPath + " update JSON_VDESK_IMG=" + res
    subprocess.Popen(cmd,
          shell=True,
          stdin=None,
          stdout=None,
          stderr=None,
          close_fds=True)

def output_img_add(vdesk_array, wid, desktop, nod):
    # add window id to the json
    if (str(wid) + fmt not in vdesk_array[desktop].img_path_array):
        vdesk_array[desktop].img_path_array.append(str(wid) + fmt)
    
    output_json(vdesk_array, nod)
   
    # take the image
    # cmd = scripts + " --add " + str(wid)
    cmd = cmd0 + str(wid) + cmd1 + str(wid) + fmt
    subprocess.Popen(cmd,
          shell=True,
          stdin=None,
          stdout=None,
          stderr=None,
          close_fds=True)

def output_img_del(vdesk_array, wid, nod):
    # delete wid from the json
    for i in range(nod):
        if (str(wid) + fmt in vdesk_array[i].img_path_array):
            vdesk_array[i].img_path_array.remove(str(wid) + fmt)

    output_json(vdesk_array, nod)

    # remove the image
    cmd = scripts + " --del " + str(wid)
    subprocess.Popen(cmd,
          shell=True,
          stdin=None,
          stdout=None,
          stderr=None,
          close_fds=True)

def output_log(any_date):
    try:
        f = open(logFile, "a")
        f.write(str(any_date) + "\n")
        f.close()
    
    except FileNotFoundError:
        sys.exit(1)    

#---- Main -----------------------------------------------------------
os.chdir(os.environ["HOME"] + workDir)
output_log(os.getcwd())

disp = Xlib.display.Display()
if (disp is None):
    output_log("Can't open display!")
    sys.exit(1)

root = disp.screen().root
root.change_attributes(event_mask=Xlib.X.SubstructureNotifyMask)

if (root is None):
    output_log("Can't connect to the root window!")
    sys.exit(1)

# get number of the desktops
nod = root.get_full_property(disp.intern_atom('_NET_NUMBER_OF_DESKTOPS'),
                                Xlib.X.AnyPropertyType).value[0]

# init array
vdesk_array = []

for i in range(nod):
    desk = Thumbnail(i)
    vdesk_array.append(desk)

# Output rezults of the initialize
output_log(disp)
output_log(root)
output_log(nod)
output_log(vdesk_array)

#---------------------------------------------------------------------
while True:
    # read new event
    event = disp.next_event()
 
    try:
        win = event.window
        wid = win.id
    
    except:
        continue

    if (win is None or wid is None):
        continue
    
    NET_WM_DESKTOP = disp.intern_atom('_NET_WM_DESKTOP')

    # mapped
    if (event.type == Xlib.X.MapNotify):
        try:
            NET_WM_DESKTOP = win.get_full_property(NET_WM_DESKTOP, Xlib.X.AnyPropertyType).value
            desktop = NET_WM_DESKTOP.tolist()[0]

            # output
            if (0 <= desktop < nod):
                output_log("mapped" + str(wid))
                output_img_add(vdesk_array, wid, desktop, nod)

        except:
            continue

    # unmapped
    if (event.type == Xlib.X.UnmapNotify):
        try:
            NET_WM_DESKTOP = win.get_full_property(NET_WM_DESKTOP, Xlib.X.AnyPropertyType).value
            output_log("unmapped" + str(wid))
            desktop = NET_WM_DESKTOP.tolist()[0]

        # the window does not exists
        except:
            output_log("destroyed" + str(wid))
            output_img_del(vdesk_array, wid, nod)

