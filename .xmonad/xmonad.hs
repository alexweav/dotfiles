import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.Util.Cursor
import XMonad.Util.EZConfig
import XMonad.Util.Run

main = do
    spawn "compton"
    xmobarPipe <- spawnPipe "xmobar"
    xmonad $ ewmh $ defaultConfig {
        manageHook = myManageHook,
        layoutHook = myLayoutHook,
        handleEventHook = myHandleEventHook,
        startupHook = myStartupHook,
        logHook = myLogHook xmobarPipe,
        terminal = myTerminal,
        modMask = myModMask,
        borderWidth = myBorderWidth
    } `additionalKeys` [
        ((0, xK_Print), spawn "scrot")
        ]

myTerminal = "urxvt"
myBorderWidth = 2

-- Windows key for xmonad actions
myModMask = mod4Mask

myStartupHook = do {
    -- Use a normal mouse cursor
    setDefaultCursor xC_left_ptr
}

myManageHook = manageDocks <+> manageHook defaultConfig

-- Spacing around the edge of the screen
screenSpacing = (Border 10 10 10 10)
-- Spacing around the edge of each window
windowSpacing = (Border 10 10 10 10)

mySpacing = spacingRaw True screenSpacing True windowSpacing True

myLayoutHook = avoidStruts $ mySpacing $ smartBorders $ layoutHook defaultConfig

myHandleEventHook = handleEventHook defaultConfig <+> docksEventHook <+> fullscreenEventHook

-- Uses a pipe to send info to xmobar
myLogHook xmobarPipe = do {
    dynamicLogWithPP xmobarPP {
        ppOutput = hPutStrLn xmobarPipe,
        ppTitle = xmobarColor "green" "" . shorten 50
    }
}

