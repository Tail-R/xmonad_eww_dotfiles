#!/bin/python

import json     # x = '{ "name":"Yuuki", "age":19, "city":"Tokyo"}'
                # 
                # y = json.loads(x)
                #
                # print(y["age"])

# import time                 # time.sleep(1)
# import subprocess as sp     #sp.run(["eww", "-c", ewwPath, "update", 
                            #               "NOTIFY_ARRAY=" + "[" + + "]"])

# import os                   # os.path.exists(path)
import sys                  # sys.argv[n]

ewwJsonPath = "/home/tailr/.config/eww/popup/json"

def json_add(timeStamp):
    with open(ewwJsonPath + "/notify_array.json", 'r+') as f1:
        f2 = open(ewwJsonPath + "/notify_message" + timeStamp + ".json")

        notify_array = json.load(f1)
        message = json.load(f2)         # json.loads(string that formated json)

        # add new message
        message.append(int(timeStamp))  # use the timestamp as an ID
        notify_array.append(message)
        
        # print (notify_array)
        
        f1.truncate(0)
        f1.seek(0)      # up cursor for overwrite
        json.dump(notify_array, f1) # update

def json_remove(Id):
    with open(ewwJsonPath + "/notify_array.json", 'r+') as f1:
        
        notify_array = json.load(f1)

        # remove specified message
        i = 0
        for entry in notify_array:
            if (entry[2] == int(Id)):
                notify_array.pop(i)
                break
            i += 1
        
        # print (notify_array)

        f1.truncate(0)
        f1.seek(0)      # up cursor for overwrite
        json.dump(notify_array, f1) # update 

# Main
if (sys.argv[1] == "--add" and sys.argv[2] is not None):
    json_add(sys.argv[2])
    


elif (sys.argv[1] == "--remove" and sys.argv[2] is not None): 
    json_remove(sys.argv[2])
    



