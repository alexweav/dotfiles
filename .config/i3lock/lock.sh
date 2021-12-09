#!/bin/bash

date_time_color=000000ff
fg_color=fefefe00
bg_color=5f5f5f33
highlight_color=393939ff
verif_color=0fcc20ff
verif_inner_color=5f5f5f66
wrong_color=f82a11aa

i3lock -n \
--force-clock \
--clock \
--time-pos="w/2:h/4-5" \
--time-size=120 \
--time-str="%-I:%M:%S %p" \
--time-color=$date_time_color \
--date-pos="w/2:h/4+55" \
--date-size=35 \
--date-str="%A, %B %-d, %Y" \
--date-color=$date_time_color \
--greeter-pos="w/2:h/2" \
--greeter-size=25 \
--indicator \
--ind-pos="w/2:h/2+158" \
--ring-width 5 \
--radius 115 \
--ring-color=$fg_color \
--inside-color=5f5f5f33 \
--line-uses-inside \
--verif-text="" \
--ringver-color=$verif_color \
--insidever-color=$verif_inner_color \
--wrong-text="" \
--ringwrong-color=$wrong_color \
--insidewrong-color=$wrong_color \
--keyhl-color=$highlight_color \
--bshl-color=$highlight_color \
--noinput-text="" \
--pass-media-keys

