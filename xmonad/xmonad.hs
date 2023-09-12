----------------------------------------------------------------------
-- Import modules
----------------------------------------------------------------------
import XMonad
import XMonad.Hooks.EwmhDesktops (ewmh)

-- Layouts
import XMonad.Layout.Gaps (gaps, Direction2D(D, L, R, U))
import XMonad.Layout.Spacing (spacingRaw, Border(Border))
import XMonad.Layout.Grid
import XMonad.Layout.ThreeColumns

-- Launch programs
import XMonad.Util.SpawnOnce (spawnOnce)

-- Keybinds
import qualified XMonad.StackSet as W
import qualified Data.Map        as M
import Graphics.X11.ExtraTypes.XF86 (
                                        xF86XK_AudioLowerVolume, 
                                        xF86XK_AudioRaiseVolume, 
                                        xF86XK_AudioMute, 
                                        xF86XK_MonBrightnessUp, 
                                        xF86XK_MonBrightnessDown
                                    )

----------------------------------------------------------------------
-- Variables
----------------------------------------------------------------------
myTerminal            = "kitty"    -- Default terminal
myModMask             = mod4Mask   -- mean super
myBorderWidth         = 3
myNormalBorderColor   = "#545454"
myFocusedBorderColor  = "#c6c8d1"
myWorkspaces          = ["1", "2", "3", "4", "5", "6", "7"]
-- myWorkspaces          = ["零", "壱", "弐", "参", "肆", "伍"]

----------------------------------------------------------------------
-- Auto start programs
----------------------------------------------------------------------
myStartupHook = do
    spawnOnce "xrandr --output eDP-1 --brightness 1.0"
    -- spawnOnce "~/.fehbg" 
    spawnOnce "$HOME/Documents/scripts/set_random_wallpaper.sh"
    
    -- eww
    spawnOnce "eww daemon"
    spawnOnce "$HOME/.config/eww/bar/launch.sh --open-all"
    spawnOnce "eww -c $HOME/.config/eww/popup open-many window_powermenu window_ssmenu" 
    -- spawnOnce "$HOME/.config/eww/minimal-bar/launch.sh --open-all" 

    -- Picom 
    spawnOnce "picom" 
    -- spawnOnce "picom --experimental-backend" -- for picom fork 
    
    spawnOnce "xsetroot -cursor_name left_ptr" 
    spawnOnce "fcitx5"

    -- Monadock

----------------------------------------------------------------------
-- Keybinds
----------------------------------------------------------------------
myKeys conf@(XConfig {XMonad.modMask = super}) = M.fromList $
    [ 
        -- Launch terminal
        ((super, xK_Return),    spawn myTerminal),

        -- Launch app launcher
        ((super, xK_d),         spawn "rofi -show drun"),

        -- Kill focused window
        ((super, xK_q),         kill),

        -- Take screenshot
        ((super, xK_s),
            spawn "$HOME/Documents/scripts/screenshot.sh --full"),
       
        -- Take selected area 
        ((super .|. shiftMask, xK_s),
            spawn "$HOME/Documents/scripts/screenshot.sh --select"),

        -- Compile XMonad
        ((super, xK_r),
            spawn "xmonad --recompile; xmonad --restart"),

        -- Change current wallpaper
        ((super, xK_w),
            spawn "$HOME/Documents/scripts/set_random_wallpaper.sh"),

        -- launch filemanager
        ((super, xK_f),         spawn "thunar"),

        -- Control brightness
        ((0,    xF86XK_MonBrightnessUp),
                spawn "brightnessctl s +5%"),

        ((0,    xF86XK_MonBrightnessDown),
                spawn "brightnessctl s 5-%"),

        -- Control volume
        ((0,    xF86XK_AudioRaiseVolume),
                spawn "pamixer --increase 5"),

        ((0,    xF86XK_AudioLowerVolume),
                spawn "pamixer --decrease 5"),
 
        ((0,    xF86XK_AudioMute),
                spawn "pamixer --toggle-mute"),

        ((super, xK_space),    sendMessage NextLayout),


        -- Move focus
        ((super, xK_j),        windows W.focusUp),

        ((super, xK_k),        windows W.focusDown),

        -- Expand the master window
        ((super, xK_l),        sendMessage Expand),

        -- Shrink the master window
        ((super, xK_h),        sendMessage Shrink),

        -- Swap the focused window and master window
        ((super, xK_c),        windows W.swapMaster),

        -- Back to tiling
        ((super, xK_t),        withFocused $ windows . W.sink)
    ]

    ++

    [
        -- Move workspace or send window to any workspaces
        ((m .|. super, k), windows $ f i)
            | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
            , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
    ]

----------------------------------------------------------------------
-- Window rules
----------------------------------------------------------------------
myManageHook = composeAll
    [
        -- You can use xprop command to make sure the window class 
        
        -- Ignore
        -- className =? "polybar" --> doIgnore,

        -- Float
        className =? "Gimp-2.10"    --> doFloat,
        -- className =? "Thunar"       --> doFloat,
        -- className =? "feh"          --> doFloat,
        -- className =? "vlc"          --> doFloat,
        -- className =? "discord"      --> doFloat,
        -- className =? "Spotify"      --> doFloat,

        className =? "Sample"       --> doFloat
    ]

----------------------------------------------------------------------
-- Window layouts 
----------------------------------------------------------------------
myLayoutHook =

    -- Gap size for the around the window
    gaps [(L, 8), (R, 8), (U, 74), (D, 90)]

    -- Gap size for the single window
    $ spacingRaw True (Border gap gap gap gap)
                 True (Border gap gap gap gap)
                 True

    -- Three columns layout
    -- $ ThreeCol nmaster delta fraction
    -- ||| ThreeColMid nmaster delta fraction
    -- ||| Full

    -- Master layout
    -- $ Tall nmaster delta fraction
    -- ||| Mirror (Tall nmaster delta fraction)
    -- ||| Full

    -- My favorit layout
    $ Tall nmaster delta fraction 
    ||| ThreeColMid nmaster delta fraction 
    ||| Full

    -- Local variables for the layouts
        where
            nmaster  = 1
            delta    = 3/100
            fraction = 1/2

            gap      = 2


----------------------------------------------------------------------
-- Main
----------------------------------------------------------------------
main = xmonad $ ewmh defaults

defaults = def
    {
        -- Basic variables
        terminal            = myTerminal,
        modMask             = myModMask,
        borderWidth         = myBorderWidth,
        normalBorderColor   = myNormalBorderColor,
        focusedBorderColor  = myFocusedBorderColor,
        workspaces          = myWorkspaces, 
   
        -- Extends variables
        keys          = myKeys,
        manageHook    = myManageHook, 
        layoutHook    = myLayoutHook,
        startupHook   = myStartupHook
    } 
   



