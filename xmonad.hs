----------------------------------------------------------------------
-- Import modules
----------------------------------------------------------------------
import XMonad
import XMonad.Hooks.EwmhDesktops (ewmh)

{-- Layouts --}
import XMonad.Layout.Gaps (gaps, Direction2D(D, L, R, U))
import XMonad.Layout.Spacing (spacingRaw, Border(Border))
-- import XMonad.Layout.ThreeColumns
-- import XMonad.Layout.Grid

{-- Some funny layouts --}
-- import XMonad.Layout.Roledex
-- import XMonad.Layout.Circle


{-- Launch programs --}
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

----------------------------------------------------------------------
-- Variables
----------------------------------------------------------------------
myTerminal              = "kitty"    {-- Default terminal --}
myModMask               = mod4Mask   {-- Super --}
myFocusFollowsMouse     = True
myBorderWidth           = 4
myNormalBorderColor     = "#ece0ec"
myFocusedBorderColor    = "#a68bcf" 
myWorkspaces            = ["1", "2", "3", "4", "5", "6", "7"]
-- myWorkspaces          = ["零", "壱", "弐", "参", "肆", "伍"]

----------------------------------------------------------------------
-- Auto start programs
----------------------------------------------------------------------
myStartupHook = do
    spawnOnce "xrandr --output eDP-1 --brightness 1.0"
    -- spawnOnce "~/.fehbg" 
    spawnOnce "$HOME/Documents/scripts/set_random_wallpaper.sh"
    
    spawnOnce "eww daemon" 

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

        {-- Launch an app launcher --}
        ((super, xK_d),         spawn "rofi -show drun"),

        {-- Kill a focused window --}
        ((super, xK_q),         kill),

        {-- Take the screenshot --}
        ((super, xK_s),
            spawn "$HOME/Documents/scripts/screenshot.sh --full"),
       
        ((super .|. shiftMask, xK_s),
            spawn "$HOME/Documents/scripts/screenshot.sh --select"),

        {-- Compile XMonad --}
        ((super, xK_r),
            spawn "xmonad --recompile; xmonad --restart"),

        {-- Change the current wallpaper --}
        ((super, xK_w),
            spawn "$HOME/Documents/scripts/set_random_wallpaper.sh"),

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
        -- className =? "Eww"      --> doIgnore,
        -- className =? "polybar" --> doIgnore,

        {-- Float --}
        className =? "Gimp-2.10"    --> doFloat,
        -- className =? "Thunar"       --> doFloat,
        -- className =? "feh"          --> doFloat,
        -- className =? "vlc"          --> doFloat,
        -- className =? "discord"      --> doFloat,
        -- className =? "Spotify"      --> doFloat,

        className =? "Eww"       --> doFloat
    ]

----------------------------------------------------------------------
-- Window layouts 
----------------------------------------------------------------------
myLayoutHook =

    {-- Gap size for the around the window --}
    {-- Left Right Top Bottom --}
    gaps [(L, 32), (R, 32), (U, 140), (D, 32)]

    {-- Gap size for the single window --}
    $ spacingRaw True (Border gap gap gap gap)
                 True (Border gap gap gap gap)
                 True

    {-- Three columns layout --}
    -- $ ThreeCol nmaster delta fraction
    -- ||| ThreeColMid nmaster delta fraction
    -- ||| Full

    {-- Master layout --}
    $ Tall nmaster delta fraction
    ||| Full
    
    {-- Custom layout --}
    -- $ Tall nmaster delta fraction
    -- ||| Full
    -- ||| Circle
    -- ||| Roledex
    
        {-- Local variables for the layouts --}
        where
            nmaster  = 1
            delta    = 3/100
            fraction = 1/2

            gap      = 8


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
   



