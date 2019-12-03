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

keysToRemove x =
  [
    (modm .|. shiftMask, xK_p)
    , (modm .|. shiftMask, xK_c)
    , (modm .|. shiftMask, xK_Return)
  ]

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
    , layoutHook = toggleLayouts (noBorders Full) $ avoidStruts $ myLayout
    , logHook = myLogHook wsbar
    , handleEventHook = fadeWindowsEventHook
    , workspaces = myWorkspaces
    , modMask = modm }

    `additionalKeys`
    [ ((modm , xK_w ), spawn "google-chrome-stable")
    , ((modm , xK_f ), spawn "thunar")
    , ((modm , xK_o ), spawn "obs")
    , ((modm , xK_b ), spawn "xfce4-screenshooter")
    , ((modm , xK_s ), spawn "skypeforlinux")
    , ((modm , xK_i ), spawn "chromium --app=chrome-extension://ophjlpahpchlmihnnnihgmmeilfjmjjc/index.html")
    , ((modm , xK_t ), spawn "chromium --app=https://tweetdeck.twitter.com/")
    , ((modm , xK_z ), spawn "/usr/local/bin/jd ")
    , ((modm , xK_d), windows copyToAll)
    , ((modm , xK_a ), spawn "qtwebflix")
    , ((modm , xK_c ), kill ) -- %! Close the focused window
    , ((modm , xK_p ), spawn "gmrun")
    , ((modm , xK_Up ), spawn "pactl set-sink-volume @DEFAULT_SINK@ +5%")
    , ((modm , xK_Down ), spawn "pactl set-sink-volume @DEFAULT_SINK@ -5%")
    , ((modm , xK_Left ), spawn "headphone")
    , ((modm , xK_Right ), spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")
    ]

myLayout = (spacing 18 $ OneBig (3/4) (3/4))
      ||| (spacing 18 $ ResizableTall 1 (3/100) (3/5) [])
      |||  withIM (1/5) (ClassName "Skype")  (spacing 18 $ OneBig (3/4) (3/4))
      ||| (spacing 0 $ Simplest)
      ||| Circle
    where
      jd = And (ClassName "Jd") (Role "")

myStartupHook = do
  spawn "setxkbmap -layout jp"
  spawn "monitor"
  spawn "redshift -l 35.69935:139.76957 &"
  spawn "urxvtd -o -f"
  spawn "thunar --daemon &"
  spawn "compton -b &"
  spawn "fcitx-autostart &"
  spawn "volnoti"
  spawn "xsetroot -cursor_name left_ptr"
  spawn "feh --bg-tile /home/naniwa/Pictures/bgImage/board.jpg"
  spawn "/usr/local/bin/jd"
  spawn "skypeforlinux"

myManageHookShift = composeAll
  [ ]

myManageHookFloat = composeAll
  [ ]

myLogHook h = dynamicLogWithPP $ wsPP { ppOutput = hPutStrLn h }

myWsBar = "xmobar /home/naniwa/.xmonad/xmobarrc"

wsPP = xmobarPP { ppOrder = \(ws:l:t:_)   -> [ws,t]
      , ppCurrent = xmobarColor colorGreen colorNormalbg
      , ppUrgent = xmobarColor colorWhite colorNormalbg
      , ppVisible = xmobarColor colorWhite colorNormalbg
      , ppHidden = xmobarColor colorWhite colorNormalbg
      , ppHiddenNoWindows = xmobarColor colorGray colorNormalbg
      , ppTitle = xmobarColor colorWhite  colorNormalbg
      , ppWsSep = ""
      , ppSep = "  ::: "
}

myPlacement = fixed (0.5, 0.5)
