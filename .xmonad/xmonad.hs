import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.ManageDocks

main = do
    xmonad $ defaultConfig {
        manageHook = manageDocks <+> manageHook defaultConfig,
        layoutHook = avoidStruts $ layoutHook defaultConfig,
        terminal = myTerminal,
        modMask = mod4Mask,
        borderWidth = 3
    }

myTerminal = "urxvt"

