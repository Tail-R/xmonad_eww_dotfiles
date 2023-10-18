#!/usr/bin/python

import Xlib.X
import Xlib.display
import json
import Xlib.error
import subprocess

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
    subprocess.run(f'echo "{res}"', shell=True)

def output_img_add(vdesk_array, wid, desktop, nod):
    # add window id to the json
    if (str(wid) + ".jpg" not in vdesk_array[desktop].img_path_array):
        vdesk_array[desktop].img_path_array.append(str(wid) + ".jpg")
    
    output_json(vdesk_array, nod)
   
    # take thumbnail
    cmd = "./manage_images.sh --add " + str(wid)
    subprocess.Popen(cmd,
          shell=True,
          stdin=None,
          stdout=None,
          stderr=None,
          close_fds=True)

def output_img_del(vdesk_array, wid, nod):
    # delete wid from the json
    for i in range(nod):
        if (str(wid) + ".jpg" in vdesk_array[i].img_path_array):
            vdesk_array[i].img_path_array.remove(str(wid) + ".jpg")

    output_json(vdesk_array, nod)

    # remove thumbnails
    cmd = "./manage_images.sh --del " + str(wid)
    subprocess.Popen(cmd,
          shell=True,
          stdin=None,
          stdout=None,
          stderr=None,
          close_fds=True)

#---------------------------------------------------------------------
def main():
    disp = Xlib.display.Display()
    root = disp.screen().root
    
    # request for the notifications
    root.change_attributes(event_mask=Xlib.X.SubstructureNotifyMask)

    # get number of the desktops
    nod = root.get_full_property(disp.intern_atom('_NET_NUMBER_OF_DESKTOPS'),
                                 Xlib.X.AnyPropertyType).value[0]

    # init array
    vdesk_array = []

    for i in range(nod):
        desk = Thumbnail(i)
        vdesk_array.append(desk)

    subprocess.run(f"rm ./thumbnails/*", shell=True)
    output_json(vdesk_array, nod)

#---------------------------------------------------------------------
    while True:
        # read new event
        event = disp.next_event()        
        win = event.window
        wid = win.id
    
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

            except (AttributeError, Xlib.error.BadWindow):
                pass

        # unmapped
        if (event.type == Xlib.X.UnmapNotify):
            try:
                NET_WM_DESKTOP = win.get_full_property(NET_WM_DESKTOP, Xlib.X.AnyPropertyType).value
                desktop = NET_WM_DESKTOP.tolist()[0]
                
                # # output
                # if (0 <= desktop < nod):
                #     output_img_add(vdesk_array, wid, desktop, nod)

            # the window does not exists
            except (AttributeError, Xlib.error.BadWindow):
                output_img_del(vdesk_array, wid, nod)

if __name__ == '__main__':
    main()

