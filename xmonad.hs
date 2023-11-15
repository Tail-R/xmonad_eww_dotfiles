----------------------------------------------------------------------
-- Import modules
----------------------------------------------------------------------
import XMonad
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
myTerminal              = "xterm"    {-- Default terminal --}
myModMask               = mod4Mask   {-- Super --}
myFocusFollowsMouse     = True
myBorderWidth           = 1
myNormalBorderColor     = "#000000"
myFocusedBorderColor    = "#ffffff" 
myWorkspaces            = ["1", "2", "3", "4", "5"]
-- myWorkspaces          = ["零", "壱", "弐", "参", "肆", "伍"]

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
        ((super, xK_Return),    spawn myTerminal),

        {-- Launch a Applications launcher --}
        ((super, xK_d),         spawn "dmenu_run"),
        

        {-- Kill a focused window --}
        ((super, xK_q),         kill),

        {-- Compile XMonad --}
        ((super, xK_r),
            spawn "xmonad --recompile; xmonad --restart"),

        {-- Launch a filemanager --}
        ((super, xK_f),         spawn "thunar"),

        {-- Control brightness --}
        ((0,    xF86XK_MonBrightnessUp),
                spawn "brightnessctl s +5%"),

        ((0,    xF86XK_MonBrightnessDown),
                spawn "brightnessctl s 5-%"),

        {-- Control volume --}
        ((0,    xF86XK_AudioRaiseVolume),
                spawn "pamixer --increase 5"),

        ((0,    xF86XK_AudioLowerVolume),
                spawn "pamixer --decrease 5"),
 
        ((0,    xF86XK_AudioMute),
                spawn "pamixer --toggle-mute"),

        ((super, xK_space),    sendMessage NextLayout),


        {-- Move focus --}
        ((super, xK_j),        windows W.focusUp),

        ((super, xK_k),        windows W.focusDown),

        {-- Expand the master window --}
        ((super, xK_l),        sendMessage Expand),

        {-- Shrink the master window --}
        ((super, xK_h),        sendMessage Shrink),

        {-- Swap the focused window and master window --}
        ((super, xK_c),        windows W.swapMaster),

        {-- Back to tiling mode --}
        ((super, xK_t),        withFocused $ windows . W.sink)
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
        className =? "Bar" --> doIgnore,
        -- className =? "Eww" --> doIgnore,
        -- className =? "polybar" --> doIgnore,

        {-- Float --}
        className =? "Gimp-2.10" --> doFloat,
        className =? "XClock" --> doFloat,
        className =? "XCalc" --> doFloat,
        -- className =? "Thunar" --> doFloat,
        className =? "feh" --> doFloat,
        -- className =? "vlc" --> doFloat,
        -- className =? "discord" --> doFloat,
        -- className =? "Spotify" --> doFloat,

        className =? "Bar" --> doFloat
        -- className =? "Eww" --> doFloat,
        -- className =? "polybar" --> doFloat
    ]

----------------------------------------------------------------------
-- Window layouts 
----------------------------------------------------------------------
myLayoutHook =

    {-- Gap size for the around the window --}
    {-- Left Right Top Bottom --}
    -- gaps [(L, 32), (R, 32), (U, 120), (D, 130)]
    gaps [(L, 0), (R, 0), (U, 32), (D, 0)]

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
   



