#!/bin/bash

# Adapted from: https://github.com/betterlockscreen/betterlockscreen

display=0

date_time_color=000000ff
fg_color=fefefe00
bg_color=5f5f5f33
inside_color=00000000
separator_color=00000000
highlight_color=393939ff
verif_color=0fcc20ff
verif_inner_color=5f5f5f66
wrong_color=f82a11aa
login_box=00000066
login_shadow=00000000
layout_color=ffffffff
modif_color=d23c3dff

bg_images=(
    "/usr/share/backgrounds/nordic-wallpapers/cpu_city.png"
    "/usr/share/backgrounds/nordic-wallpapers/cpu_city.png"
    "/usr/share/backgrounds/nordic-wallpapers/cpu_city_rotated.png"
)

font_lg=32
font_md=16
font_sm=12

CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/lockscreen"
CUR_DIR="$CACHE_DIR/current"

lock() {
    i3lock -n \
    --color=$bg_color \
    --screen=$display \
    --ind-pos="x+310:y+h-80" \
    --radius=25 \
    --ring-width=5 \
    --inside-color=$inside_color \
    --ring-color=$fg_color \
    --separator-color=$separator_color \
    --insidever-color=$verif_inner_color \
    --insidewrong-color=$wrong_color \
    --ringver-color=$verif_color \
    --ringwrong-color=$wrong_color \
    --line-uses-inside \
    --keyhl-color=$highlight_color \
    --bshl-color=$highlight_color \
    --force-clock \
    --clock \
    --time-pos="ix-265:iy-10" \
    --time-align=1 \
    --time-str="%-I:%M:%S %p" \
    --time-color=$date_time_color \
    --time-size=$font_lg \
    --date-str="" \
    --greeter-pos="ix-265:iy+12" \
    --greeter-align=1 \
    --greeter-text="Type password..." \
    --greeter-color=$date_time_color \
    --greeter-size=$font_md \
    --layout-pos="ix-265:iy+32" \
    --layout-align=1 \
    --layout-color=$layout_color \
    --layout-size=$font_sm \
    --keylayout "${keylayout:-0}" \
    --indicator \
    --verif-pos="ix+45:iy-35" \
    --verif-align=2 \
    --verif-text="Verifying..." \
    --verif-color=$verif_color \
    --verif-size=$font_sm \
    --wrong-pos="ix+45:iy-35" \
    --wrong-align=2 \
    --wrong-text="Failure!" \
    --wrong-color=$wrong_color \
    --wrong-size=$font_sm \
    --modif-pos="ix+45:iy+43" \
    --modif-align=2 \
    --modif-size=$font_sm \
    --modif-color=$modif_color \
    --noinput-text="" \
    --pass-media-keys \
    --pass-screen-keys \
    --pass-volume-keys \
    --pass-power-keys \

}

init() {
    get_display_info
    FEH_INSTALLED=false && [[ -e "$(command -v feh)" ]] && FEH_INSTALLED=true
    mkdir -p "$CACHE_DIR" &> /dev/null
    mkdir -p "$CUR_DIR" &> /dev/null

    get_wall_list ${bg_images[@]}
    echo "Original image(s): ${WALL_LIST[*]##*/}"

    create_login_box

    for ((i=0; i<${#DISPLAY_LIST[@]}; i++)); do
        display=${DISPLAY_LIST[$i]}
        wall=${WALL_LIST[$i]}
        if echo "$wall" | grep -E -q "[[:space:]]"; then
            wall="${wall// /\\ }"
        fi

        IFS=' ' read -r -a dinfo <<< $display
        local id=${dinfo[0]}
        local device=${dinfo[1]}
        local geometry=${dinfo[2]}

        read -r -a cols <<< ${geometry//[x+-]/ }
        local position="${geometry#*"${cols[1]}"}"
        local resolution="${geometry%"${position}"*}"

    done
}

escape_spaces() {
    local raw=$1
    if echo "$raw" | grep -E -q "[[:space:]]"; then
        return "${raw// /\\ }"
    fi
}

get_display_info() {
    local count=0
    mapfile -t displays < <(xrandr --listactivemonitors)
    for display in "${displays[@]:1}"; do
        ((count++))
        display="$(echo "$display" | sed -r 's/\/[0-9]*//g')"
        IFS=' ' read -r -a info <<< "$display"
        DISPLAY_LIST+=("$count ${info[3]} ${info[2]}")
    done
    echo "Detected $count displays..."
    echo $DISPLAY_LIST
}

get_wall_list() {
    local paths=("$@")
    declare -ga WALL_LIST

    if [ ${#paths[@]} -lt ${#DISPLAY_LIST[@]} ]; then
        echo "${#paths[@]} images provided for ${#DISPLAY_LIST[@]} displays. An image must be provided for each display."
    fi

    for ((i=0; i<${#DISPLAY_LIST[@]}; i++)); do
        get_image ${paths[$i]}
    done
}

get_image() {
    local path="$1"

    if [ -f "$path" ]; then
        WALL_LIST+=("$path")
        return
    elif [ -d "$path" ]; then
        dir=("$path"/*)
        rdir=${dir[RANDOM % ${#dir[@]}]}
        get_image $rdir
    else
        echo "invalid path: $path"
        exit 1
    fi
}

create_login_box() {
    RECTANGLE="$CUR_DIR/rectangle.png"
    local shadow="$CUR_DIR/shadow.png"
    local width=340
    local height=100
    convert -size "$width"x"$height" xc:\#"$login_box" -fill none "$RECTANGLE"
    convert "$RECTANGLE" \
        \( -clone 0 -background \#"$login_shadow" -shadow 100x5+0+0 \) +swap \
        -background none -layers merge +repage "$shadow"
    composite -compose Dst_Out -gravity center \
        "$RECTANGLE" "$shadow" -alpha Set "$shadow"
    convert "$shadow" "$RECTANGLE" -geometry +10+10 -composite "$RECTANGLE"
    [[ "$shadow" ]] && rm "$shadow"
}

init

lock

exit 0

