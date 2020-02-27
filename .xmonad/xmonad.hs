import qualified Data.Map as M

import XMonad
--import XMonad.Config.Kde
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
import XMonad.Layout.StackTile
import XMonad.Layout.BinarySpacePartition

import XMonad.Layout.Circle

import XMonad.Util.EZConfig            -- removeKeys, additionalKeys
import XMonad.Util.Run(spawnPipe)      -- spawnPipe, hPutStrLn
import XMonad.Util.Run

import Graphics.X11.ExtraTypes.XF86
import XMonad.Hooks.SetWMName
import qualified XMonad.StackSet as W
import XMonad.Hooks.EwmhDesktops
import Data.Ratio ((%))

myWorkspaces = [" 1 ", " 2 ", " 3 ", " 4 "," 5 "," 6 "," 7 "," 8 "," 9 "]

modm = mod1Mask

colorBlue      = "#857da9"
colorGreen     = "#00FF00"
colorGray      = "#676767"
colorWhite     = "#d3d7cf"
colorGrayAlt   = "#313131"
colorNormalbg  = "#55504E"

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
--  xmonad $  docks $ ewmh kdeConfig
--  xmonad $  docks $ ewmh def
  xmonad $  docks $ def
    { borderWidth = 1
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
    , ((modm , xK_m ), spawn "/usr/share/mailspring/mailspring")
    , ((modm , xK_b ), spawn "xfce4-screenshooter")
    , ((modm , xK_s ), spawn "slack")
    , ((modm , xK_i ), spawn "chromium --app=chrome-extension://ophjlpahpchlmihnnnihgmmeilfjmjjc/index.html")
    , ((modm , xK_n ), spawn "urxvt -e  nmtui ")
    , ((modm , xK_z ), spawn "/usr/local/bin/jdim ")
    , ((modm , xK_d), windows copyToAll)
    , ((modm , xK_c ), kill ) -- %! Close the focused window
    , ((modm , xK_p ), spawn "rofi -show run")
    , ((modm , xK_a ), spawn "rofi -show ssh")
    , ((modm , xK_Tab ), moveTo Next NonEmptyWS)
    , ((modm .|. shiftMask, xK_Tab ), moveTo Prev NonEmptyWS)
    , ((modm , xK_Up ), spawn "pactl set-sink-volume @DEFAULT_SINK@ +5% && volnoti-show $(amixer get Master | grep -Po \"[0-9]+(?=%)\" | tail -1)")
    , ((modm , xK_Down ), spawn "pactl set-sink-volume @DEFAULT_SINK@ -5% && volnoti-show $(amixer get Master | grep -Po \"[0-9]+(?=%)\" | tail -1)")
    , ((modm , xK_Left ), spawn "headphone")
    , ((modm , xK_Right ), spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle volnoti-show $(amixer get Master | grep -Po \"[0-9]+(?=%)\" | tail -1)")
    ]

myLayout = (spacing 0 $  emptyBSP  )
      |||  withIM (1/3) (ClassName "Slack")  (spacing 0 $ OneBig (2/3) (2/3))
      |||  Simplest
    where
      jdim = And (ClassName "Jdim") (Role "")

myStartupHook = do
  spawn "fcitx-autostart &"
  spawn "sleep 5; autorandr --load laptop; stalonetray --dockapp-mode simple &"
  spawn "volnoti"
  spawn "setxkbmap -layout jp"
  spawn "urxvtd -o -f"
  spawn "thunar --daemon &"
  spawn "picom --config ~/dotfiles/.config/picom.conf -b &"
--  spawn "geary "
--  spawn "xsetroot -cursor_name left_ptr"
  spawn "skypeforlinux"
  spawn "slack "
  spawn "killall nm-applet; nm-applet 2>&1 > /dev/null &"
  spawn "mailspring &"
  spawn "killall dunst; dunst &"
  --spawn "pulseaudio --kill; pulseaudio --start && sleep 1&& pasystray"
  spawn "pasystray"
  spawn "mate-power-manager  2>&1 > /dev/null &"
  spawn "urxvt -pe tabbed,kuake  &"
  spawn "libinput-gestures-setup start &"
  spawn "sleep 3 && xdotool key \"alt+c\" && xdotool key \"alt+c\""
  spawn "feh --bg-scale /usr/share/backgrounds/archlinux/archlinux-simplyblack.png"
--  spawn "xinput --set-prop \"SynPS/2 Synaptics TouchPad\" \"Device Enabled\" 0"

myManageHookShift = composeAll
  [ ]

myManageHookFloat = composeAll
  [ ]

myLogHook h = dynamicLogWithPP $ wsPP { ppOutput = hPutStrLn h }

myWsBar = "xmobar ~/.xmonad/xmobarrc"

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
