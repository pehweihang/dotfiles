import XMonad
import XMonad.Hooks.DynamicLog (dynamicLogWithPP, wrap, xmobarPP, xmobarColor, shorten, PP(..))
import XMonad.Hooks.ManageDocks (avoidStruts, manageDocks, docksEventHook)
import XMonad.Layout.Gaps (gaps)
import XMonad.Layout.Spacing (spacing)
import XMonad.Layout.WindowNavigation 
import XMonad.Util.SpawnOnce (spawnOnce)
import XMonad.Util.Run (spawnPipe)

import Graphics.X11.ExtraTypes.XF86 
  ( xF86XK_AudioLowerVolume, 
    xF86XK_AudioRaiseVolume, 
    xF86XK_AudioMute, 
    xF86XK_MonBrightnessDown, 
    xF86XK_MonBrightnessUp, 
    xF86XK_AudioPlay, 
    xF86XK_AudioPrev, 
    xF86XK_AudioNext  )

import Data.Maybe (fromJust)
import Data.Monoid

import System.Exit (exitSuccess)
import System.IO (hPutStrLn)

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

colorTrayer :: String
colorTrayer = "--tint 0x282828"
-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal      = "kitty"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = True

-- Width of the window border in pixels.
--
myBorderWidth   = 2

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask       = mod4Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces    = [" \xe795 ", " \xe743 ", " \xf868 ", " \xf02d ", " \xf49c ", " \xf001 ", " \xf308 ", " \xfcc1 ", " \xfcc2 "]

myWorkspaceIndices = M.fromList $ zipWith (,) myWorkspaces [1..] -- (,) == \x y -> (x,y)
clickable ws = "<action=xdotool key super+"++show i++">"++ws++"</action>"
    where i = fromJust $ M.lookup ws myWorkspaceIndices
-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "#2e3440"
myFocusedBorderColor = "#81a1c1"

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn (myTerminal ++ " -e zsh"))

    -- launch dmenu
    , ((modm,               xK_d     ), spawn "rofi -show drun")

    -- close focused window
    , ((modm,               xK_q     ), kill)

     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Move to windows
    , ((modm,               xK_j     ), sendMessage $ Go D)

    , ((modm,               xK_k     ), sendMessage $ Go U)

    , ((modm,               xK_h     ), sendMessage $ Go L)

    , ((modm,               xK_l     ), sendMessage $ Go R)

    -- Swap windows
    , ((modm .|. shiftMask, xK_j     ), sendMessage $ Swap D)

    , ((modm .|. shiftMask, xK_k     ), sendMessage $ Swap U)

    , ((modm .|. shiftMask, xK_h     ), sendMessage $ Swap L)

    , ((modm .|. shiftMask, xK_l     ), sendMessage $ Swap R)

    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modm,               xK_Return), windows W.swapMaster)

    -- -- Shrink the master area
    -- , ((modm,               xK_h     ), sendMessage Shrink)
    --
    -- -- Expand the master area
    -- , ((modm,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    -- -- Increment the number of windows in the master area
    -- , ((modm              , xK_comma ), sendMessage (IncMasterN 1))
    --
    -- -- Deincrement the number of windows in the master area
    -- , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    -- , ((modm              , xK_b     ), sendMessage ToggleStruts)

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q     ), io exitSuccess)

    -- Restart xmonad
    , ((modm              , xK_r     ), spawn "xmonad --recompile; xmonad --restart")

    -- Run xmessage with a summary of the default keybindings (useful for beginners)
    , ((modm .|. shiftMask, xK_slash ), spawn ("echo \"" ++ help ++ "\" | xmessage -file -"))

    
    -- Audio keys
    , ((0,                    xF86XK_AudioPlay), spawn "playerctl play-pause")
    , ((0,                    xF86XK_AudioPrev), spawn "playerctl previous")
    , ((0,                    xF86XK_AudioNext), spawn "playerctl next")
    , ((0,                    xF86XK_AudioRaiseVolume), spawn "pactl set-sink-volume @DEFAULT_SINK@ +5%")
    , ((0,                    xF86XK_AudioLowerVolume), spawn "pactl set-sink-volume @DEFAULT_SINK@ -5%")
    , ((0,                    xF86XK_AudioMute), spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")

    -- Brightness keys
    , ((0,                    xF86XK_MonBrightnessUp), spawn "brightnessctl s +10%")
    , ((0,                    xF86XK_MonBrightnessDown), spawn "brightnessctl s 10-%")
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++
    --
    -- --
    -- -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    -- --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_apostrophe, xK_comma, xK_period] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
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
myLayout = avoidStruts ( windowNavigation (tiled ||| Mirror tiled ) ||| Full)
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = gaps [(U,10), (D,10), (L,10), (R,10)] $ Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

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
myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore 
    , className =? "TelegramDesktop" --> doShift (myWorkspaces !! 2)
    , className =? "BitWarden"      --> doShift (myWorkspaces !! 4)
    ]

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = mempty

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
myLogHook = return ()

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
  xmonad $ defaults 
    { manageHook            = myManageHook <+> manageDocks
    , handleEventHook       = docksEventHook
    , modMask               = myModMask
    , terminal              = myTerminal
    , startupHook           = myStartupHook -- <+> spawnApps
    , workspaces            = myWorkspaces
    , normalBorderColor     = myNormalBorderColor
    , focusedBorderColor    = myFocusedBorderColor
    , logHook               = dynamicLogWithPP $ xmobarPP
            -- xmobar settings
            { ppOutput = \x -> hPutStrLn xmproc x
              , ppCurrent = xmobarColor "#d8dee9,#3b4252" "" . wrap
                            "<fn=1><box type=HBoth width=2, color=#282828>" "</box></fn>"

                -- Visible but not current workspace
              , ppVisible = xmobarColor "#81a1c1,#3b4252" "" . wrap 
                            "<fn=1><box type=HBoth width=2, color=#282828>" "</box></fn>"   . clickable

                -- Hidden workspace
              , ppHidden = xmobarColor "#81a1c1" "" . wrap
                           ("<fn=1>") "</fn>" . clickable

                -- Hidden workspaces (no windows)
              , ppHiddenNoWindows = xmobarColor "#434c5e" ""  . wrap
                            "<fn=1>" "</fn>"   . clickable

                -- Title of active window
              , ppTitle = xmobarColor "#d8dee9" "" . shorten 60

                -- Separator character
              , ppSep =  "<fc=#4c566a> | </fc>"

                -- Urgent workspace
              , ppUrgent = xmobarColor "#bf616a" "" 

                -- Adding # of windows on current workspace to the bar
              -- , ppExtras  = [windowCount]

                -- order of things in xmobar
              , ppOrder  = \(ws:l:t:ex) -> [ws,t]
            } 

    }

-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
defaults = def {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = spacing 20 $ myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook
    }

-- | Finally, a copy of the default bindings in simple textual tabular format.
help :: String
help = unlines ["The default modifier key is 'alt'. Default keybindings:",
    "",
    "-- launching and killing programs",
    "mod-Shift-Enter  Launch xterminal",
    "mod-p            Launch dmenu",
    "mod-Shift-p      Launch gmrun",
    "mod-Shift-c      Close/kill the focused window",
    "mod-Space        Rotate through the available layout algorithms",
    "mod-Shift-Space  Reset the layouts on the current workSpace to default",
    "mod-n            Resize/refresh viewed windows to the correct size",
    "",
    "-- move focus up or down the window stack",
    "mod-Tab        Move focus to the next window",
    "mod-Shift-Tab  Move focus to the previous window",
    "mod-j          Move focus to the next window",
    "mod-k          Move focus to the previous window",
    "mod-m          Move focus to the master window",
    "",
    "-- modifying the window order",
    "mod-Return   Swap the focused window and the master window",
    "mod-Shift-j  Swap the focused window with the next window",
    "mod-Shift-k  Swap the focused window with the previous window",
    "",
    "-- resizing the master/slave ratio",
    "mod-h  Shrink the master area",
    "mod-l  Expand the master area",
    "",
    "-- floating layer support",
    "mod-t  Push window back into tiling; unfloat and re-tile it",
    "",
    "-- increase or decrease number of windows in the master area",
    "mod-comma  (mod-,)   Increment the number of windows in the master area",
    "mod-period (mod-.)   Deincrement the number of windows in the master area",
    "",
    "-- quit, or restart",
    "mod-Shift-q  Quit xmonad",
    "mod-q        Restart xmonad",
    "mod-[1..9]   Switch to workSpace N",
    "",
    "-- Workspaces & screens",
    "mod-Shift-[1..9]   Move client to workspace N",
    "mod-{w,e,r}        Switch to physical/Xinerama screens 1, 2, or 3",
    "mod-Shift-{w,e,r}  Move client to screen 1, 2, or 3",
    "",
    "-- Mouse bindings: default actions bound to mouse events",
    "mod-button1  Set the window to floating mode and move by dragging",
    "mod-button2  Raise the window to the top of the stack",
    "mod-button3  Set the window to floating mode and resize by dragging"]
