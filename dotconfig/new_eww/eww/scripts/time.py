#!/usr/bin/python

import datetime
import time
import subprocess

while True:
    ctime = datetime.datetime.now().time().replace(microsecond=0)
    subprocess.run(f"echo '{ctime}'", shell=True)

    time.sleep(1)
