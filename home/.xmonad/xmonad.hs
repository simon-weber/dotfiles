import XMonad

import qualified XMonad.StackSet as W
import qualified Data.Map as M

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Hooks.EwmhDesktops
import XMonad.Config.Desktop
import XMonad.Util.EZConfig
import XMonad.Layout.NoBorders
import XMonad.Hooks.ManageHelpers

dmenuOptions = "-b" 
              -- ++ " -fn " ++ myFont
              -- ++ " -nf " ++ myNormalFGColor 
              -- ++ " -nb " ++ myNormalBGColor 
              -- ++ " -sf " ++ myFocusedFGColor
              -- ++ " -sb " ++ myFocusedBGColor 

myTerminal = "gnome-terminal"

myDmenu = "exe=`dmenu_run " ++ dmenuOptions ++ "` && eval \"exec $exe\""

myWorkspaces = ["α", "β", "γ", "δ", "ε", "ζ", "η", "θ", "ι" ]

myKeys = [
     ((mod4Mask, xK_r), spawn myDmenu)
     --, ((mod4Mask, xK_l), spawn "xscreensaver-command -lock")
    ] ++
    [((m .|. mod1Mask, k), windows $ f i) --make M-# view, not swap
         | (i, k) <- zip myWorkspaces [xK_1 .. xK_9]
         , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


myManageHook = composeAll $
    [ isFullscreen --> (doF W.focusDown <+> doFullFloat)
    ]

main = do
    -- mapM spawnPipe [ "xscreensaver -no-splash"] 
    --                , "xbindkeys"
    --                , "parcellite"
    --                , "/home/simon/.dropbox-dist/dropboxd"
    --                , "nm-applet"
    --                , "xfce4-power-manager"
    --                , "volumeicon"
    --                , "gnome-do"
    --                , "feh --bg-center /home/simon/images/wallpapers/darkwood.jpg"
    --                ]

    xmonad $ ewmh desktopConfig
        { manageHook = manageDocks <+> myManageHook
                        <+> manageHook desktopConfig
        , terminal = myTerminal
        , layoutHook = avoidStruts  $  smartBorders $ layoutHook defaultConfig
        , borderWidth = 3
        , normalBorderColor = "black"
        , focusedBorderColor = "#63B8FF"
        , workspaces = myWorkspaces
        }`additionalKeys` myKeys
