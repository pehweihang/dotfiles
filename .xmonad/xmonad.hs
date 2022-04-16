import XMonad
import XMonad.Actions.CycleWS (Direction1D(..), nextScreen, prevScreen)
import XMonad.Actions.MouseResize
import XMonad.Hooks.DynamicLog (dynamicLogWithPP, wrap, xmobarPP, xmobarColor, shorten, PP(..))
import XMonad.Hooks.DynamicProperty
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks (avoidStruts, manageDocks, docksEventHook, ToggleStruts(..))
import XMonad.Hooks.ManageHelpers (isFullscreen, doFullFloat, doCenterFloat)

import XMonad.Layout.GridVariants (Grid(Grid))
import XMonad.Layout.LimitWindows (limitWindows)
import XMonad.Layout.LayoutModifier
import XMonad.Layout.Magnifier
import XMonad.Layout.MultiToggle (mkToggle, single, EOT(EOT), (??))
import XMonad.Layout.MultiToggle.Instances (StdTransformers(NBFULL, MIRROR, NOBORDERS))
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.ResizableTile
import XMonad.Layout.ShowWName
import XMonad.Layout.Simplest
import XMonad.Layout.SimplestFloat
import XMonad.Layout.Spacing
import XMonad.Layout.SubLayouts
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns
import XMonad.Layout.WindowArranger (windowArrange, WindowArrangerMsg(..)) 
import XMonad.Layout.WindowNavigation 

import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.SpawnOnce (spawnOnce)
import XMonad.Util.Run (spawnPipe)

import Data.Maybe (fromJust)
import Data.Monoid

import System.Exit (exitSuccess)
import System.IO (hPutStrLn)

import qualified XMonad.StackSet as W
import qualified Data.Map        as M
import qualified XMonad.Layout.ToggleLayouts as T (toggleLayouts, ToggleLayout(Toggle))
import qualified XMonad.Layout.MultiToggle as MT (Toggle(..))


colorBack = "#2E3440"
colorFore = "#ECEFF4"

color01 = "#3B4252"
color02 = "#434C5E"
color03 = "#4C556A"
color04 = "#D8DEE9"
color05 = "#E5E9F0"
color06 = "#ECEFF4"
color07 = "#8FBCBB"
color08 = "#88C0D0"
color09 = "#81A1C1"
color10 = "#5E81AC"
color11 = "#BF616A"
color12 = "#D08770"
color13 = "#EBCB8B"
color14 = "#A3BE8C"
color15 = "#B48EAD"


myFont          = "xft:SauceCodePro Nerd Font Mono:regular:size=9:antialias=true:hinting=true"

myTerminal      = "kitty"

myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False

myClickJustFocuses :: Bool
myClickJustFocuses = True

myBorderWidth   = 2

myModMask       = mod4Mask

myWorkspaces    = [" \xe795 ", " \xe743 ", " \xf868 ", " \xf02d ", " \xf49c ", " \xf001 ", " \xf308 ", " \xfcc1 ", " \xfcc2 "]

-- Theme for showWName which prints current workspace when you change workspaces.
myShowWNameTheme :: SWNConfig
myShowWNameTheme = def
    { swn_font              = "xft:SauceCodePro Nerd Font Mono:regular:size=60" 
    , swn_fade              = 0.15
    , swn_bgcolor           = colorBack
    , swn_color             = colorFore
    }

myWorkspaceIndices = M.fromList $ zipWith (,) myWorkspaces [1..] -- (,) == \x y -> (x,y)
clickable ws = "<action=xdotool key super+"++show i++">"++ws++"</action>"
  where i = fromJust $ M.lookup ws myWorkspaceIndices

myNormalBorderColor  = colorBack
myFocusedBorderColor = colorFore


myKeys :: [(String, X ())]
myKeys = 
  -- launch a terminal
  [ ("M-S-<Return>",                  spawn (myTerminal ++ " -e zsh"))

    -- launch rofi
  , ("M-d",                           spawn "rofi -show drun")

    -- close focused window
  , ("M-q",                           kill)

    -- Rotate through the available layout algorithms
  , ("M-<Tab>",                       sendMessage NextLayout)
    -- Toggles noborder/full
  , ("M-<Space>",                     sendMessage (MT.Toggle NBFULL) >> sendMessage ToggleStruts)

    --  Reset the layouts on the current workspace to default
  , ("M-S-<Space>",                   sendMessage (T.Toggle "tall"))

    -- Resize viewed windows to the correct size
  , ("M-n",                           refresh)

    -- Move to windows
  , ("M-j",                           sendMessage $ Go D)
  , ("M-k",                           sendMessage $ Go U)
  , ("M-h",                           sendMessage $ Go L)
  , ("M-l",                           sendMessage $ Go R)

    -- Swap windows
  , ("M-S-j",                         sendMessage $ Swap D)
  , ("M-S-k",                         sendMessage $ Swap U)
  , ("M-S-h",                         sendMessage $ Swap L)
  , ("M-S-l",                         sendMessage $ Swap R)

    -- change screen
  , ("M-'",                           prevScreen)
  , ("M-,",                           nextScreen)

    -- sublayouts
  , ("M-C-h", sendMessage $ pullGroup L)
  , ("M-C-l", sendMessage $ pullGroup R)
  , ("M-C-k", sendMessage $ pullGroup U)
  , ("M-C-j", sendMessage $ pullGroup D)
  , ("M-C-m", withFocused (sendMessage . MergeAll))
  -- , ("M-C-u", withFocused (sendMessage . UnMerge))
  , ("M-C-/", withFocused (sendMessage . UnMergeAll))
  , ("M-C-'", onGroup W.focusDown')  -- Switch focus to prev tab
  , ("M-C-,", onGroup W.focusUp')    -- Switch focus to next tab

    -- Push window back into tiling
  , ("M-t",                           withFocused $ windows . W.sink)

    -- Quit xmonad
  , ("M-S-q",                         io exitSuccess)

  -- Restart xmonad
  , ("M-r",                           spawn "xmonad --recompile; xmonad --restart")


  -- Audio keys
  , ("<XF86AudioPlay>", spawn "playerctl play-pause")
  , ("<XF86AudioPrev>", spawn "playerctl previous")
  , ("<XF86AudioNext>", spawn "playerctl next")
  , ("<XF86AudioRaiseVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ +5%")
  , ("<XF86AudioLowerVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ -5%")
  , ("<XF86AudioMute>", spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")

  -- 
  , ("<XF86MonBrightnessUp>", spawn "brightnessctl -d acpi_video0 s +10%")
  , ("<XF86MonBrightnessDown>", spawn "brightnessctl -d acpi_video0 s 10-%")
  , ("<XF86KbdBrightnessUp>", spawn "brightnessctl -d apple::kbd_backlight s +10%")
  , ("<XF86KbdBrightnessDown>", spawn "brightnessctl -d apple::kbd_backlight s 10-%")
  ]


  ------------------------------------------------------------------------
  -- Layouts:

  -- You can specify and transform your layouts by modifying these values.
  -- If you change layout bindings be sure to use 'mod-shift-space' after
  -- restarting (with 'mod-q') to reset your layout state to the new
  -- defaults, as xmonad preserves your old layout settings by default.
  --
  -- The available layouts.  Note that each layout is separated by |||,
  -- which denotes layout choice.
  --
mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw False (Border i i i i) True (Border i i i i) True

-- Layouts
tall     = renamed [Replace "tall"]
           $ smartBorders
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ limitWindows 12
           $ mySpacing 8
           $ ResizableTall 1 (3/100) (1/2) []
magnify  = renamed [Replace "magnify"]
           $ smartBorders
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ magnifier
           $ limitWindows 12
           $ mySpacing 8
           $ ResizableTall 1 (3/100) (1/2) []
floats   = renamed [Replace "floats"]
           $ smartBorders
           $ limitWindows 20 simplestFloat
grid     = renamed [Replace "grid"]
           $ smartBorders
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ limitWindows 12
           $ mySpacing 8
           $ mkToggle (single MIRROR)
           $ Grid (16/10)
threeCol = renamed [Replace "threeCol"]
           $ smartBorders
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ limitWindows 7
           $ ThreeCol 1 (3/100) (1/2)

-- The layout hook
myLayoutHook = avoidStruts $ mouseResize $ windowArrange $ T.toggleLayouts floats
               $ mkToggle (NBFULL ?? NOBORDERS ?? EOT) myDefaultLayout
             where
               myDefaultLayout =     withBorder myBorderWidth tall
                                 ||| magnify
                                 ||| floats
                                 ||| grid
                                 ||| threeCol

-- setting colors for tabs layout and tabs sublayout.
myTabTheme = def { fontName            = myFont
                 , activeColor         = color03
                 , inactiveColor       = colorBack
                 , activeBorderColor   = color03
                 , inactiveBorderColor = colorBack
                 , activeTextColor     = colorFore
                 , inactiveTextColor   = color03
                 }
------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--

manageZoomHook =
  composeAll $
    [ (className =? zoomClassName) <&&> shouldFloat <$> title --> doFloat
    , (className =? zoomClassName) <&&> shouldSink <$> title --> doSink
    ]
  where
    zoomClassName = "zoom"
    tileTitles =
      [ "Zoom - Free Account"
      , "Zoom - Licensed Account"
      , "Zoom"
      , "Zoom Meeting"
      ]
    shouldFloat title = title `notElem` tileTitles
    shouldSink title = title `elem` tileTitles
    doSink = (ask >>= doF . W.sink) <+> doF W.swapDown

myManageHook = composeAll
    [ className =? "confirm"         --> doFloat
    , className =? "file_progress"   --> doFloat
    , className =? "dialog"          --> doFloat
    , className =? "download"        --> doFloat
    , className =? "error"           --> doFloat
    , className =? "Gimp"            --> doFloat
    , className =? "notification"    --> doFloat
    , className =? "splash"          --> doFloat
    , className =? "toolbar"         --> doFloat 
    , className =? "Nm-connection-editor" --> doCenterFloat
    , className =? "Pavucontrol" --> doCenterFloat
    , className =? "TelegramDesktop"  --> doShift (myWorkspaces !! 2)
    , className =? "BitWarden"        --> doShift (myWorkspaces !! 4)
    , className =? "zoom"             --> doShift (myWorkspaces !! 3)
    , isFullscreen --> doFullFloat
    ] <+> manageZoomHook

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = mconcat
              [ --dynamicTitle manageZoomHook
               docksEventHook
              ]


------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--

spawnToWorkspace :: String -> String -> X ()
spawnToWorkspace program workspace = do
                                      spawn program     
                                      windows $ W.greedyView workspace
-- spawnApps = composeAll
--       [ spawnToWorkspace "google-chrome-stable" (myWorkspaces!!1)
--       , spawnToWorkspace "telegram-desktop"     (myWorkspaces!!2)
--       , spawnToWorkspace myTerminal             (myWorkspaces!!0)
--       ]

myStartupHook :: X()
myStartupHook = composeAll
      [ spawnOnce "picom --config $HOME/.config/picom/picom.conf --experimental-backends"
      , spawnOnce "feh --bg-scale ~/.config/wallpapers/wallpaper.png"
      ]

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
main :: IO ()
main = do
  xmproc <- spawnPipe "xmobar $HOME/.config/xmobar/xmobarrc"
  xmonad $ ewmh def 
    { manageHook            = myManageHook <+> manageDocks
    , terminal           = myTerminal
    , focusFollowsMouse  = myFocusFollowsMouse
    , clickJustFocuses   = myClickJustFocuses
    , borderWidth        = myBorderWidth
    , handleEventHook    = myEventHook
    , layoutHook         = showWName' myShowWNameTheme $ myLayoutHook
    , modMask            = myModMask
    , startupHook        = myStartupHook -- <+> spawnApps
    , workspaces         = myWorkspaces
    , normalBorderColor  = myNormalBorderColor
    , focusedBorderColor = myFocusedBorderColor
    , logHook            = dynamicLogWithPP $ xmobarPP
            -- xmobar settings
            { ppOutput = \x -> hPutStrLn xmproc x
              , ppCurrent = xmobarColor (colorFore++","++color01) "" . wrap
                            "<fn=1><box type=HBoth width=2, color=#282828>" "</box></fn>"

                -- Visible but not current workspace
              , ppVisible = xmobarColor (color09++","++color01) "" . wrap 
                            "<fn=1><box type=HBoth width=2, color=#282828>" "</box></fn>"   . clickable

                -- Hidden workspace
              , ppHidden = xmobarColor color09 "" . wrap
                           "<fn=1>" "</fn>" . clickable

                -- Hidden workspaces (no windows)
              , ppHiddenNoWindows = xmobarColor color02 ""  . wrap
                            "<fn=1>" "</fn>"   . clickable

                -- Title of active window
              , ppTitle = xmobarColor colorFore "" . shorten 60

                -- Separator character
              , ppSep =  ("<fc="++color03++"> | </fc>")

                -- Urgent workspace
              , ppUrgent = xmobarColor color11 "" 

                -- Adding # of windows on current workspace to the bar
              -- , ppExtras  = [windowCount]

                -- order of things in xmobar
              , ppOrder  = \(ws:l:t:ex) -> [ws,l]++ex++[t]
            } 

    } `additionalKeysP` myKeys
