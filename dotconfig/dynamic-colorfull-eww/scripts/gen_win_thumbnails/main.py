#!/usr/bin/python

import Xlib.X
import Xlib.display
import json
import subprocess

from ewmh import EWMH # sudo pacman -S python-ewmh
ewmh = EWMH()

class Thumbnail:
    def __init__(self, desktop_num, image_path):
        self.desktop_num = desktop_num
        self.image_path = image_path

def main():
    disp = Xlib.display.Display()
    window = disp.screen().root
    
    # Request for notifications
    window.change_attributes(event_mask=Xlib.X.SubstructureNotifyMask)

    nod = ewmh.getNumberOfDesktops() 
    vdesk_array = [Thumbnail * nod]

    for desk in ewmh.getNumberOfDesktops():
        vdesk_array.append(Thumbnail(desk, "no image"))
    
    print(vdesk_array)
    
    while True:
        event = disp.next_event()

        # mapped
        if (event.type == Xlib.X.MapNotify):
            win = event.window
            desk_num = ewmh.getCurrentDesktop()
            
            print("Mapped",win.id, "in", desk_num)

        # unmapped
        if (event.type == Xlib.X.UnmapNotify):
            win = event.window
            
            try:
                print("Unmapped", win.id, "in",
                      ewmh.getWmDesktop(win))
            
            except:
                print("Deleted", win.id)
    
if __name__ == '__main__':
    main()


