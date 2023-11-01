#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <X11/Xlib.h>
#include <X11/Xatom.h>

unsigned short get_number_of_desktops(
        Display *disp,
        Window root
        ) {
    
    // Results 
    Atom type_return;
    int format_return;
    unsigned long nitems_return;
    unsigned long bytes_left;
    unsigned char *data;

    Atom prop = XInternAtom(disp, "_NET_NUMBER_OF_DESKTOPS", False);
    
    XGetWindowProperty(
            disp,
            root,
            prop,
            0,
            1,
            False,
            AnyPropertyType,
            &type_return,
            &format_return,
            &nitems_return,
            &bytes_left,
            &data
        );

    unsigned short res = *((unsigned short*)data);
    XFree(data);
    return res;
}

//********************************************************************
int main (void) {
    Display *disp;
    Window root;
    Atom property;
    XEvent event;
    
    FILE *fp;
    unsigned char cmd[1024];

    // Open default display
    disp = XOpenDisplay(NULL);
    if (!disp) return 1;

    // Get default root window
    root = DefaultRootWindow(disp);

    // Get number of the desktops
    unsigned short nod = get_number_of_desktops(disp, root);
    printf("Number of the desktops: %d\n", nod);

    // Request send notifycations
    XSelectInput(disp, root, SubstructureNotifyMask); 
    
    for (;;) {
        XNextEvent(disp, &event);
        
        if (event.xmap.type == MapNotify) {
            // printf("Mapped: %d\n", event.xmap.window);
            sprintf(cmd, "echo %s %d", "Mapped:", event.xmap.window);
            system(cmd);
        }

        if (event.xunmap.type == UnmapNotify) {
            // printf("Unmapped: %d\n", event.xunmap.window);
            sprintf(cmd, "echo %s %d", "Unmapped:", event.xmap.window);
            system(cmd);
        }
    }

    return 0;
}




