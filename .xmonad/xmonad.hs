import qualified Data.Map as M

import XMonad
import qualified XMonad.StackSet as W  -- myManageHookShift

import XMonad.Actions.CopyWindow

import Control.Monad (liftM2)          -- myManageHookShift
import System.IO                       -- for xmobar

import XMonad.Actions.WindowGo (doShift)
import XMonad.Actions.CycleWS

import XMonad.Hooks.DynamicLog         -- for xmobar
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.FadeWindows
import XMonad.Hooks.ManageDocks        -- avoid xmobar area
import XMonad.Hooks.Place
import XMonad.Layout
import XMonad.Layout.OneBig
import XMonad.Layout.Spiral
import XMonad.Layout.Grid

import XMonad.Layout.Gaps
import XMonad.Layout.IM
import XMonad.Layout.Magnifier         -- this makes window bigger
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.Named
import XMonad.Layout.NoBorders         -- In Full mode, border is no use
import XMonad.Layout.ResizableTile     -- Resizable Horizontal border
import XMonad.Layout.Spacing           -- this makes smart space around windows
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns      -- for many windows
import XMonad.Layout.ToggleLayouts     -- Full window at any time
import XMonad.Layout.Simplest
import XMonad.Layout.SimplestFloat
import XMonad.Layout.DragPane

import XMonad.Layout.Circle

import XMonad.Util.EZConfig            -- removeKeys, additionalKeys
import XMonad.Util.Run(spawnPipe)      -- spawnPipe, hPutStrLn
import XMonad.Util.Run

import Graphics.X11.ExtraTypes.XF86
import XMonad.Hooks.SetWMName
import qualified XMonad.StackSet as W

import Data.Ratio ((%))

myWorkspaces = [" Main ", " Media ", " Side ", " 4 ", " 5 "]

modm = mod1Mask

colorBlue      = "#857da9"
colorGreen     = "#00FF00"
colorGray      = "#676767"
colorWhite     = "#d3d7cf"
colorGrayAlt   = "#313131"
colorNormalbg  = "#1a1e1b"

-- Define keys to remove
keysToRemove x =
  [
    -- Unused gmrun binding
    (modm .|. shiftMask, xK_p)
    -- Unused close window binding
    , (modm .|. shiftMask, xK_c)
    , (modm .|. shiftMask, xK_Return)
  ]

-- Delete the keys combinations we want to remove.
strippedKeys x = foldr M.delete (keys defaultConfig x) (keysToRemove x)

main :: IO ()

main = do
  wsbar <- spawnPipe myWsBar
  xmonad $ defaultConfig
    { borderWidth = 2
    , terminal = "urxvtc"
    , normalBorderColor = colorGray
    , focusedBorderColor = colorGreen
    , startupHook = myStartupHook
    , manageHook = placeHook myPlacement <+> myManageHookShift <+> myManageHookFloat <+> manageDocks
    -- any time Full mode, avoid xmobar area
    , layoutHook = toggleLayouts (noBorders Full) $ avoidStruts $ myLayout
    --, layoutHook = toggleLayouts (noBorders Full) $ avoidStruts $ myLayout
    -- xmobar setting
    , logHook = myLogHook wsbar
    , handleEventHook = fadeWindowsEventHook
    , workspaces = myWorkspaces
    , modMask = modm }

--       `additionalKeys`
--       [ ((modm              , xK_f     ), sendMessage ToggleLayout)
--       , ((modm              , xK_g     ), sendMessage ToggleGaps)
--       , ((modm              , xK_h     ), sendMessage MirrorExpand)
--       , ((modm              , xK_Right ), nextWS ) -- go to next workspace
--       , ((modm              , xK_Left  ), prevWS ) -- go to prev workspace
--       , ((modm .|. shiftMask, xK_Right ), shiftToNext)
--       , ((modm .|. shiftMask, xK_Left  ), shiftToPrev)
--      , ((modm              , xK_comma ), sendMessage MagnifyLess)   -- smaller window
--       , ((modm              , xK_period), sendMessage MagnifyMore)  -- bigger window
--       , ((modm              , xK_j     ), windows W.focusDown)
--       , ((modm              , xK_k     ), windows W.focusUp)
--       , ((modm .|. shiftMask, xK_j     ), windows W.swapDown)
--       , ((modm .|. shiftMask, xK_k     ), windows W.swapUp)
--       , ((modm              , xK_w     ), nextScreen) ]

--       `additionalKeys`
--       [ ((modm .|. m, k), windows $ f i)
--         | (i, k) <- zip myWorkspaces
--                     [ xK_exclam, xK_at, xK_numbersign
--                     , xK_dollar, xK_percent, xK_asciicircum
--                     , xK_ampersand, xK_asterisk, xK_parenleft
--                     , xK_parenright
--                     ]
--       , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
--       ]

    `additionalKeys`
    [ ((modm , xK_w ), spawn "google-chrome-stable")
    ---[ ((modm , xK_w ), spawn "firefox")
    ,((modm , xK_f ), spawn "nemo")
    ,((modm , xK_o ), spawn "obs")
    ,((modm , xK_b ), spawn "xfce4-screenshooter")
    ,((modm , xK_s ), spawn "skypeforlinux")
    --,((modm , xK_s ), spawn "chromium --app=https://web.skype.com/ ")
    ,((modm , xK_t ), spawn "chromium --app=https://tweetdeck.twitter.com/")
    ,((modm , xK_z ), spawn "/usr/local/bin/jd ")
    ,((modm , xK_d), windows copyToAll)
    --,((modm , xK_z ), spawn "chromium --app=chrome-extension://eaibgccboimjelecbmgfjhakekfdcpeh/view/index.html")
    ,((modm , xK_a ), spawn "qtwebflix")
    , ((modm , xK_c ), kill ) -- %! Close the focused window
    -- , ((modm , xK_p ), spawn "exe=`dmenu_run -nb '#1a1e1b' -nf '#d3d7cf' -sb '#88b986' -sf '#1a1e1b'` && exec $exe")
    , ((modm , xK_p ), spawn "gmrun")
    , ((modm , xK_Up ), spawn "pactl set-sink-volume @DEFAULT_SINK@ +5%")
    , ((modm , xK_Down ), spawn "pactl set-sink-volume @DEFAULT_SINK@ -5%")
    , ((modm , xK_Left ), spawn "headphone")
    , ((modm , xK_Right ), spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")
    ]

-- Handle Window behaveior
--myLayout = (spacing 18 $ ResizableTall 1 (3/100) (3/5) [])
--            |||  (spacing 2 $ (dragPane Horizontal (1/10) (1/2)))
--            |||  (dragPane Vertical   (1/10) (1/2))
myLayout = (spacing 18 $ OneBig (3/4) (3/4))
--            |||  spiral (6/7)
--            |||  GridRatio (4/3)
--            |||   (spacing 4 $ ResizableTall 1 (1/201) (116/201) [])
            |||  withIM (1/5) (ClassName "Skype")  (spacing 18 $ OneBig (3/4) (3/4))
            ||| (spacing 0 $ Simplest)
            ||| Circle  
    where
      jd = And (ClassName "Jd") (Role "")

-- Start up (at xmonad beggining), like "wallpaper" or so on
myStartupHook = do
  spawn "setxkbmap -layout jp"
  spawn "monitor"
  spawn "redshift"
  spawn "urxvtd -o -f"
  spawn "compton -b &"
  spawn "fcitx-autostart &"
  spawn "volnoti"
  spawn "xsetroot -cursor_name left_ptr"
  spawn "feh --bg-tile /home/naniwa/Pictures/bgImage/board.jpg"
  spawn "/usr/local/bin/jd"
  spawn "skypeforlinux"
  --spawn "discord"
  --spawn "google-chrome-stable --app=http://clock.szkmm.com/sora.html"
  --spawn "chromium --app=https://tweetdeck.twitter.com/"

-- some window must created there
myManageHookShift = composeAll
-- if you want to know className, type "$ xprop|grep CLASS" on shell
  [ ]
  --[ className =? "skypeforlinux"   --> doShift " home " ]
--    className =? "chromium"   --> doShift " home " ,
--    className =? "jd"   --> doShift " home " ,
--    className =? "corebird"   --> doShift " home ",
--    className =? "discord"   --> doShift " home " ]
--             where viewShift = doF . liftM2 (.) W.view W.shift

-- new window will created in Float mode
myManageHookFloat = composeAll
  [ ]
--className =? "mpv"          --> doFloat ]


myLogHook h = dynamicLogWithPP $ wsPP { ppOutput = hPutStrLn h }

myWsBar = "xmobar /home/naniwa/.xmonad/xmobarrc"

wsPP = xmobarPP { ppOrder               = \(ws:l:t:_)   -> [ws,t]
      , ppCurrent             = xmobarColor   colorGreen       colorNormalbg
      , ppUrgent              = xmobarColor   colorWhite       colorNormalbg
      , ppVisible             = xmobarColor   colorWhite       colorNormalbg
      , ppHidden              = xmobarColor   colorWhite       colorNormalbg
      , ppHiddenNoWindows     = xmobarColor   colorGray        colorNormalbg
      , ppTitle               = xmobarColor   colorWhite       colorNormalbg
      , ppWsSep               = ""
      , ppSep                 = "  ::: "
}

myPlacement = fixed (0.5, 0.5)
