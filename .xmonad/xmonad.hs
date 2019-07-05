import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Cursor
import XMonad.Util.Run

main = do
    xmobarPipe <- spawnPipe "xmobar"
    xmonad $ defaultConfig {
        manageHook = myManageHook,
        layoutHook = myLayoutHook,
        handleEventHook = myHandleEventHook,
        startupHook = myStartupHook,
        logHook = myLogHook xmobarPipe,
        terminal = myTerminal,
        modMask = myModMask,
        borderWidth = myBorderWidth
    }

myTerminal = "urxvt"
myBorderWidth = 3

-- Windows key for xmonad actions
myModMask = mod4Mask

myStartupHook = do {
    -- Use a normal mouse cursor
    setDefaultCursor xC_left_ptr
}

myManageHook = manageDocks <+> manageHook defaultConfig

myLayoutHook = avoidStruts $ layoutHook defaultConfig

myHandleEventHook = handleEventHook defaultConfig <+> docksEventHook

-- Uses a pipe to send info to xmobar
myLogHook xmobarPipe = do {
    dynamicLogWithPP xmobarPP {
        ppOutput = hPutStrLn xmobarPipe,
        ppTitle = xmobarColor "green" "" . shorten 50
    }
}

