#!/usr/bin/python

import os
import sys
import json
import subprocess

# import gi
# gi.reauire_version("Gtk", "3.0")
# from gi.repository import Gtk
from gi.repository import GLib

import dbus
import dbus.service
from dbus.mainloop.glib import DBusGMainLoop


# Main
def main():
    DBusGMainLoop(set_as_default=True)
    bus = SessionBus()
    bus_name = "org.freedesktop.Notifications"

    bus.publish(bus_name, Example())

    loop = GLib.MainLoop()
    loop.run()

if __name__ == '__main__':
    main()


