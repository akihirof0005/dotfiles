import XMonad
--import XMonad.Config.Kde
import qualified Data.Map.Strict
import qualified XMonad.StackSet as W  -- myManageHookShift

import XMonad.Actions.CopyWindow

import Control.Monad (liftM2)          -- myManageHookShift
import System.IO                       -- for xmobar

import XMonad.Actions.WindowGo (doShift)
import XMonad.Actions.CycleWS

import XMonad.Hooks.DynamicLog         -- for xmobar
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

import XMonad.Hooks.EwmhDesktops
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

strippedKeys x = foldr Data.Map.Strict.delete (keys defaultConfig x) (keysToRemove x)

main :: IO ()
main = xmonad =<< xmobar defaults
defaults = defaultConfig
      {
        borderWidth = 1,
        terminal = "alacritty",
        normalBorderColor = colorGray,
        focusedBorderColor = colorGreen,
        startupHook = myStartupHook,
        manageHook = placeHook myPlacement <+> myManageHookShift <+> myManageHookFloat <+> manageDocks,
        layoutHook = toggleLayouts (noBorders Full) $ avoidStruts $ myLayout,
   -- , logHook = myLogHook wsbar,
        handleEventHook = fadeWindowsEventHook,
        workspaces = myWorkspaces,
        modMask = modm
      }
      `additionalKeys`
      [ ((modm , xK_w ), spawn "firefox")
      , ((modm , xK_0x5a ), spawn "thunar")
      , ((modm , xK_f ), spawn "thunar")
      , ((modm , xK_b ), spawn "xfce4-screenshooter")
      , ((modm , xK_s ), spawn "slack")
      , ((modm , xK_i ), spawn "google-chrome-stable --app=chrome-extension://ophjlpahpchlmihnnnihgmmeilfjmjjc/index.html")
--    , ((modm , xK_n ), spawn "alacritty -e  nmtui ")
--    , ((modm , xK_t ), spawn "alacritty -e tw")
      , ((modm , xK_t ), spawn "tv")
      , ((modm , xK_z ), spawn "jd")
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

myLayout = withIM (1/5) (ClassName "Pragli") (spacing 3 $  emptyBSP  )
      ||| noBorders Full
      ||| OneBig (3/4) (3/4)

myStartupHook = do
  spawn "bash ~/dotfiles/.bin/autostart > /tmp/start.log &"

myManageHookShift = composeAll
  [ ]

myManageHookFloat = composeAll
  [ ]

--myLogHook h = dynamicLogWithPP $ wsPP { ppOutput = hPutStrLn h }

--myWsBar = "xmobar ~/.xmonad/xmobarrc"

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
