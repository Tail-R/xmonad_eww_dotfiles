----------------------------------------------------------------------
-- Welcome to my XMonad configuration uwu*
----------------------------------------------------------------------

----------------------------------------------------------------------
-- Pre reauire softwares
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
-- To-Do
----------------------------------------------------------------------
{--
 - set the script path in more smart way
 - make full screen support
--}

----------------------------------------------------------------------
-- Import modules
----------------------------------------------------------------------
import XMonad

{-- Extended Window Manager Hints --}
import XMonad.Hooks.EwmhDesktops (ewmh)

{-- Layouts --}
import XMonad.Layout.Gaps (gaps, Direction2D(D, L, R, U))
import XMonad.Layout.Spacing (spacingRaw, Border(Border))

-- import XMonad.Layout.ThreeColumns
import XMonad.Layout.Grid

{-- Some funny layouts --}
-- import XMonad.Layout.Roledex
-- import XMonad.Layout.Circle

{-- Launch process --}
import XMonad.Util.SpawnOnce (spawnOnce)

{-- For keybinds --}
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
-- Variables
----------------------------------------------------------------------
myTerminal              = "alacritty"    {-- Default terminal --}
myModMask               = mod4Mask   {-- Super --}
myFocusFollowsMouse     = True
myBorderWidth           = 1
myNormalBorderColor     = "#000000"
myFocusedBorderColor    = "#0000ff" 
myWorkspaces            = ["1", "2", "3", "4", "5"]
-- myWorkspaces          = ["零", "壱", "弐", "参", "肆", "伍"]

-- Own custom variables
myHomeDir               = "/home/tailr"
myAppLauncher           = "dmenu_run"
myFileManager           = "thunar"
my_sh_ss_full           = myHomeDir ++ "/.config/xmonad/scripts/ss.sh -f"
my_sh_ss_select         = myHomeDir ++ "/.config/xmonad/scripts/ss.sh -s"
my_sh_rand_wall         = myHomeDir ++ "/.config/xmonad/scripts/rand_wall.sh"

----------------------------------------------------------------------
-- Auto start programs
----------------------------------------------------------------------
myStartupHook = do
    spawnOnce "xrandr --output eDP-1 --brightness 1.0"
    spawnOnce "~/.fehbg" 
    
    {-- Compositer --}
    spawnOnce "picom" 
    -- spawnOnce "picom --experimental-backend" {-- for picom fork --}
    
    spawnOnce "xsetroot -cursor_name left_ptr" 
    spawnOnce "fcitx5"

    -- spawnOnce "dunst"

----------------------------------------------------------------------
-- Keybinds
----------------------------------------------------------------------
myKeys conf@(XConfig {XMonad.modMask = super}) = M.fromList $
    [
        {-- Launch a terminal --}
        ((super, xK_Return),
        spawn myTerminal),

        {-- Launch an Application launcher --}
        ((super, xK_d),
        spawn myAppLauncher),

        {-- Take a screenshot --}
        ((super , xK_s),
        spawn my_sh_ss_full),
        
        ((super .|. shiftMask, xK_s),
        spawn my_sh_ss_select),

        {-- Set a wallpaper randomly --}
        ((super, xK_w),
        spawn my_sh_rand_wall),
 
        {-- Kill a focused window --}
        ((super, xK_q),
        kill),

        {-- Compile XMonad --}
        ((super, xK_r),
        spawn "xmonad --recompile; xmonad --restart"),

        {-- Launch a filemanager --}
        ((super, xK_f),
        spawn "thunar"),

        {-- Control brightness --}
        ((0, xF86XK_MonBrightnessUp),
        spawn "brightnessctl s +5%"),

        ((0, xF86XK_MonBrightnessDown),
        spawn "brightnessctl s 5-%"),

        {-- Control volume --}
        ((0, xF86XK_AudioRaiseVolume),
        spawn "pamixer --increase 5"),

        ((0, xF86XK_AudioLowerVolume),
        spawn "pamixer --decrease 5"),
 
        ((0, xF86XK_AudioMute),
        spawn "pamixer --toggle-mute"),

        ((super, xK_space),
        sendMessage NextLayout),


        {-- Move window focus --}
        ((super, xK_j),
        windows W.focusUp),

        ((super, xK_k),
        windows W.focusDown),

        {-- Expand the master window --}
        ((super, xK_l),
        sendMessage Expand),

        {-- Shrink the master window --}
        ((super, xK_h),
        sendMessage Shrink),

        {-- Swap the focused window and master window --}
        ((super, xK_c),
        windows W.swapMaster),

        {-- Back to tiling mode --}
        ((super, xK_t),
        withFocused $ windows . W.sink)
    ]

    ++

    [
        {-- Move the workspace or send the window to the any workspaces --}
        ((m .|. super, k), windows $ f i)
            | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
            , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
    ]

----------------------------------------------------------------------
-- Window rules
----------------------------------------------------------------------
myManageHook = composeAll
    [ 
        {-- Ignore --}
        className =? "Bar"       --> doIgnore,
        -- className =? "Eww"       --> doIgnore,
        -- className =? "polybar"   --> doIgnore,

        {-- Float --}
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
-- Window layouts 
----------------------------------------------------------------------
myLayoutHook =

    {-- Gap size for the around the window --}
    {-- Left Right Top Bottom --}
    -- gaps [(L, 32), (R, 32), (U, 120), (D, 130)]
    gaps [(L, 0), (R, 0), (U, 0), (D, 40)]

    {-- Gap size for the single window --}
    $ spacingRaw True (Border gap gap gap gap)
                 True (Border gap gap gap gap)
                 True

    {-- Three columns layout --}
    -- $ ThreeCol nmaster delta fraction
    -- ||| ThreeColMid nmaster delta fraction
    -- ||| Full

    {-- Master layout --}
    -- $ Tall nmaster delta fraction
    -- ||| Full
    
    {-- Custom layout --}
    $ Tall nmaster delta fraction
    ||| Grid
    ||| Full
    
        {-- Local variables for the layouts --}
        where
            nmaster = 1
            delta = 3/100
            fraction = 1/2

            gap = 1


----------------------------------------------------------------------
-- Main
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
   



