#!/usr/bin/python

import os
import subprocess
# import time
import json
import Xlib.X
import Xlib.display
import Xlib.error

#---------------------------------------------------------------------
workDir = "/.config/eww/scripts/vdesk_viewer"
ewwPath = "$HOME/.config/eww"
logFile = "./log.txt"
scripts = "$HOME/.config/eww/scripts/vdesk_viewer/manage_images.sh"
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
   
    # take thumbnail
    cmd = scripts + " --add " + str(wid)
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

    # remove thumbnails
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

# request for the notifications
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
output_log(vdesk_array)
output_log("nod = " + str(nod))

#---------------------------------------------------------------------
while True:
    # read new event
    event = disp.next_event()
    if (event is None):
        output_log("Invalid event!")
        continue
    
    output_log("---------- Event ----------")

    try:
        win = event.window
        wid = win.id
    
    except:
        continue

    if (win is None or wid is None):
        continue
    
    output_log("from" + str(win))
    output_log("name" + str(wid))

    # i have no idea but it's working uwu
    NET_WM_DESKTOP = disp.intern_atom('_NET_WM_DESKTOP')
 
    # mapped
    if (event.type == Xlib.X.MapNotify):
        try:
            NET_WM_DESKTOP = win.get_full_property(NET_WM_DESKTOP, Xlib.X.AnyPropertyType).value
            desktop = NET_WM_DESKTOP.tolist()[0]

            # output
            if (0 <= desktop < nod):
                output_img_add(vdesk_array, wid, desktop, nod)
                output_log("mapped " + str(wid))

        except:
            continue

    # unmapped
    if (event.type == Xlib.X.UnmapNotify):
        try:
            NET_WM_DESKTOP = win.get_full_property(NET_WM_DESKTOP, Xlib.X.AnyPropertyType).value
            desktop = NET_WM_DESKTOP.tolist()[0]
            output_log("unmapped " + str(wid))

        # the window does not exists
        except:
            output_img_del(vdesk_array, wid, nod)
            output_log("destroyed " + str(wid))



