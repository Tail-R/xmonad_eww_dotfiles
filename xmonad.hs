----------------------------------------------------------------------
-- welcome to my XMonad configuration uwu*
----------------------------------------------------------------------

----------------------------------------------------------------------
-- pre require softwares
----------------------------------------------------------------------
{--
 - alacritty:        blazingly fast terminal emulator
 - picom:            basic compositor for Xorg
 - feh:              set a wallpaper and preview an images
 - maim:             take a screenshot
 - dmenu:            tiny application launcher
 - thunar:           popular file manager
 - brightnessctl:    increase and decrease the brightness
 - pamixer:          increase and decrease the volume
--}

----------------------------------------------------------------------
-- to-do
----------------------------------------------------------------------
{--
 - set the script path in more smart way
 - make full screen support
--}

----------------------------------------------------------------------
-- import modules
----------------------------------------------------------------------
import XMonad

{-- extended Window Manager Hints --}
import XMonad.Hooks.EwmhDesktops (ewmh)

{-- layouts --}
import XMonad.Layout.Gaps (gaps, Direction2D(D, L, R, U))
import XMonad.Layout.Spacing (spacingRaw, Border(Border))

-- import XMonad.Layout.ThreeColumns
import XMonad.Layout.Grid

{-- some funny layouts --}
-- import XMonad.Layout.Roledex
-- import XMonad.Layout.Circle

{-- launch process --}
import XMonad.Util.SpawnOnce (spawnOnce)

{-- for keybinds --}
import qualified XMonad.StackSet as W
import qualified Data.Map        as M
import Graphics.X11.ExtraTypes.XF86 (
                                        xF86XK_AudioLowerVolume, 
                                        xF86XK_AudioRaiseVolume, 
                                        xF86XK_AudioMute, 
                                        xF86XK_MonBrightnessUp, 
                                        xF86XK_MonBrightnessDown
                                    )

import XMonad.Util.Dmenu

----------------------------------------------------------------------
-- variables
----------------------------------------------------------------------
myTerminal              = "alacritty"    {-- default terminal --}
myModMask               = mod4Mask   {-- super --}
myFocusFollowsMouse     = True
myBorderWidth           = 1
myNormalBorderColor     = "#000000"
myFocusedBorderColor    = "#0000ff" 
myWorkspaces            = ["1", "2", "3", "4", "5"]
-- myWorkspaces          = ["零", "壱", "弐", "参", "肆", "伍"]

-- own custom variables
myHomeDir               = "/home/tailr"
myAppLauncher           = "dmenu_run"
myFileManager           = "thunar"
my_sh_ss_full           = myHomeDir ++ "/.config/xmonad/scripts/ss.sh -f"
my_sh_ss_select         = myHomeDir ++ "/.config/xmonad/scripts/ss.sh -s"
my_sh_rand_wall         = myHomeDir ++ "/.config/xmonad/scripts/rand_wall.sh"

----------------------------------------------------------------------
-- auto start programs
----------------------------------------------------------------------
myStartupHook = do
    spawnOnce "xrandr --output eDP-1 --brightness 1.0"
    spawnOnce "~/.fehbg" 
    
    {-- compositer --}
    spawnOnce "picom" 
    -- spawnOnce "picom --experimental-backend" {-- picom fork --}
    
    spawnOnce "xsetroot -cursor_name left_ptr" 
    spawnOnce "fcitx5"

    -- spawnOnce "dunst"

----------------------------------------------------------------------
-- keybinds
----------------------------------------------------------------------
myKeys conf@(XConfig {XMonad.modMask = super}) = M.fromList $
    [
        {-- launch a terminal --}
        ((super, xK_Return),
        spawn myTerminal),

        {-- launch an Application launcher --}
        ((super, xK_d),
        spawn myAppLauncher),

        {-- take a screenshot --}
        ((super , xK_s),
        spawn my_sh_ss_full),
        
        ((super .|. shiftMask, xK_s),
        spawn my_sh_ss_select),

        {-- set a wallpaper randomly --}
        ((super, xK_w),
        spawn my_sh_rand_wall),
 
        {-- kill a focused window --}
        ((super, xK_q),
        kill),

        {-- compile XMonad --}
        ((super, xK_r),
        spawn "xmonad --recompile; xmonad --restart"),

        {-- launch a filemanager --}
        ((super, xK_f),
        spawn "thunar"),

        {-- control brightness --}
        ((0, xF86XK_MonBrightnessUp),
        spawn "brightnessctl s +5%"),

        ((0, xF86XK_MonBrightnessDown),
        spawn "brightnessctl s 5-%"),

        {-- control volume --}
        ((0, xF86XK_AudioRaiseVolume),
        spawn "pamixer --increase 5"),

        ((0, xF86XK_AudioLowerVolume),
        spawn "pamixer --decrease 5"),
 
        ((0, xF86XK_AudioMute),
        spawn "pamixer --toggle-mute"),

        ((super, xK_space),
        sendMessage NextLayout),


        {-- move window focus --}
        ((super, xK_j),
        windows W.focusUp),

        ((super, xK_k),
        windows W.focusDown),

        {-- expand the master window --}
        ((super, xK_l),
        sendMessage Expand),

        {-- shrink the master window --}
        ((super, xK_h),
        sendMessage Shrink),

        {-- swap the focused window and master window --}
        ((super, xK_c),
        windows W.swapMaster),

        {-- back to tiling mode --}
        ((super, xK_t),
        withFocused $ windows . W.sink)
    ]

    ++

    [
        {-- move the workspace or send the window to the any workspaces --}
        ((m .|. super, k), windows $ f i)
            | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
            , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
    ]

----------------------------------------------------------------------
-- window rules
----------------------------------------------------------------------
myManageHook = composeAll
    [ 
        {-- ignore --}
        className =? "Bar"       --> doIgnore,
        -- className =? "Eww"       --> doIgnore,
        -- className =? "polybar"   --> doIgnore,

        {-- float --}
        className =? "XClock"     --> doFloat,
        className =? "XCalc"      --> doFloat,

        className =? "Gimp"       --> doFloat,
        className =? "feh"        --> doFloat,
        -- className =? "Thunar"     --> doFloat,
        -- className =? "vlc"        --> doFloat,
        -- className =? "discord"    --> doFloat,
        -- className =? "Spotify"    --> doFloat,

        className =? "Bar"        --> doFloat
        -- className =? "Eww"        --> doFloat,
        -- className =? "polybar"    --> doFloat
    ]

----------------------------------------------------------------------
-- window layouts 
----------------------------------------------------------------------
myLayoutHook =

    {-- gap size for the around the window --}
    {-- left Right Top Bottom --}
    -- gaps [(L, 32), (R, 32), (U, 120), (D, 130)]
    gaps [(L, 0), (R, 0), (U, 0), (D, 40)]

    {-- gap size for the each window --}
    $ spacingRaw True (Border gap gap gap gap)
                 True (Border gap gap gap gap)
                 True

    {-- three columns layout --}
    -- $ ThreeCol nmaster delta fraction
    -- ||| ThreeColMid nmaster delta fraction
    -- ||| Full

    {-- master layout --}
    -- $ Tall nmaster delta fraction
    -- ||| Full
    
    {-- custom layout --}
    $ Tall nmaster delta fraction
    ||| Grid
    ||| Full
    
        {-- local variables for the layouts --}
        where
            nmaster = 1
            delta = 3/100
            fraction = 1/2

            gap = 1


----------------------------------------------------------------------
-- main
----------------------------------------------------------------------
main = xmonad $ ewmh defaults

defaults = def
    {
        terminal            = myTerminal,
        modMask             = myModMask,
        focusFollowsMouse   = myFocusFollowsMouse,
        borderWidth         = myBorderWidth,
        normalBorderColor   = myNormalBorderColor,
        focusedBorderColor  = myFocusedBorderColor,
        workspaces          = myWorkspaces, 
        keys                = myKeys,
        manageHook          = myManageHook, 
        layoutHook          = myLayoutHook,
        startupHook         = myStartupHook
    } 
   



