import XMonad
import XMonad.Config.Desktop

main = xmonad def
    {
        terminal = "urxvt",
        modMask = mod4Mask,
        borderWidth = 3
    }

