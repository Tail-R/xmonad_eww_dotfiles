#include <stdio.h>
#include <string.h>
#include <X11/Xlib.h>

enum states {
    Maped,
    Unmaped
};

int main(void) {
    Display *disp;
    Window win;
    XEvent event;
    FILE *fp;
    unsigned char cmd[1024];
    // unsigned char res[1024];

    disp = XOpenDisplay(NULL);
    if (!disp) {
        fprintf(stderr, "Can't open display!");
        return 1; 
    }

    win = DefaultRootWindow(disp);
    XSelectInput(disp, win, SubstructureNotifyMask);

    for (;;) {
        XNextEvent(disp, &event);
        
        if (event.xmap.type == MapNotify) {
            printf("%s %d\n", "Maped", event.xmap.window);

            // sprintf(cmd, "./manage_windowthumb.sh %d %d",
            //         Maped, event.xmap.window);
            
            // fp = popen(cmd, "r");
            // if (fp == NULL) return 1;

            // while (fgets(res, sizeof(res), fp) != NULL) {
            //     printf("%s\n", res); 
            // }

            // pclose(fp);
        }

        if (event.xunmap.type == UnmapNotify) {
            printf("%s %d\n", "Unmaped", event.xunmap.window);

            // sprintf(cmd, "./manage_windowthumb.sh %d %d",
            //         Unmaped, event.xunmap.window);

            // fp = popen(cmd, "r");
            // if (fp == NULL) return 1;
            
            // while (fgets(res, sizeof(res), fp) != NULL) {
            //     printf("%s\n", res); 
            // }
            // 
            // pclose(fp);
        }
    }

    return 0;
}
