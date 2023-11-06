#!/usr/bin/python

######################################################################
## You need to install python-ewmh
######################################################################

import time
import json
import subprocess
from ewmh import EWMH # sudo pacman -S python-ewmh
ewmh = EWMH()

# Main
while True:
    wsList = ["󰧞"] * ewmh.getNumberOfDesktops()
    cList = ewmh.getClientList()

    for client in cList:
        wsList[ewmh.getWmDesktop(client)] = "󰊠"
    
    wsList[ewmh.getCurrentDesktop()] = "󰮯"

    res = json.dumps(wsList)
    # print(res)
    subprocess.run(f"echo '{res}'", shell=True)
    time.sleep(0.2)

