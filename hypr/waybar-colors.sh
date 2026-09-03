#!/usr/bin/env bash

wallpaper=$(sed -n 's/^[[:space:]]*path[[:space:]]*=[[:space:]]*//p' \
    "$HOME/.config/hypr/hyprpaper.conf" | head -n 1)
[[ -f "$wallpaper" ]] || exit 0

magick_bin=$(command -v magick 2>/dev/null || true)
if [[ -z "$magick_bin" ]]; then
    magick_bin="$(nix eval --raw nixpkgs#imagemagick.outPath)/bin/magick"
fi

darkest="10121B"
lightest="C0CAF5"
muted="7F849C"
accent="7AA2F7"
secondary="BB9AF7"
darkest_luma=999
lightest_luma=0
muted_delta=999
accent_score=-1

mapfile -t palette < <(
    "$magick_bin" "$wallpaper" -resize 160x160 -colors 32 -unique-colors txt:- |
        sed -n 's/.*#\([0-9A-Fa-f]\{6\}\).*/\1/p'
)

for color in "${palette[@]}"; do
    r=$((16#${color:0:2})); g=$((16#${color:2:2})); b=$((16#${color:4:2}))
    max=$r; (( g > max )) && max=$g; (( b > max )) && max=$b
    min=$r; (( g < min )) && min=$g; (( b < min )) && min=$b
    brightness=$(( (299*r + 587*g + 114*b) / 1000 ))

    (( brightness < darkest_luma )) && darkest_luma=$brightness && darkest=$color
    (( brightness > lightest_luma )) && lightest_luma=$brightness && lightest=$color

    delta=$(( brightness > 145 ? brightness - 145 : 145 - brightness ))
    (( delta < muted_delta )) && muted_delta=$delta && muted=$color

    score=$(( (max - min) * 2 - (brightness > 175 ? brightness - 175 : 0) ))
    if (( brightness >= 95 && score > accent_score )); then
        accent_score=$score
        accent=$color
    fi
done

bg_r=$((16#${darkest:0:2})); bg_g=$((16#${darkest:2:2})); bg_b=$((16#${darkest:4:2}))
accent_r=$((16#${accent:0:2})); accent_g=$((16#${accent:2:2})); accent_b=$((16#${accent:4:2}))

secondary_score=-1
for color in "${palette[@]}"; do
    r=$((16#${color:0:2})); g=$((16#${color:2:2})); b=$((16#${color:4:2}))
    max=$r; (( g > max )) && max=$g; (( b > max )) && max=$b
    min=$r; (( g < min )) && min=$g; (( b < min )) && min=$b
    brightness=$(( (299*r + 587*g + 114*b) / 1000 ))
    distance=$(( r > accent_r ? r - accent_r : accent_r - r ))
    distance=$(( distance + (g > accent_g ? g - accent_g : accent_g - g) ))
    distance=$(( distance + (b > accent_b ? b - accent_b : accent_b - b) ))
    score=$((distance + max - min))
    if (( brightness >= 105 && brightness <= 195 && score > secondary_score )); then
        secondary_score=$score
        secondary=$color
    fi
done

sed \
    -e "s/@BG@/$bg_r, $bg_g, $bg_b/" \
    -e "s/@SURFACE@/$accent_r, $accent_g, $accent_b/" \
    -e "s/@TEXT@/#$lightest/" \
    -e "s/@MUTED@/#$muted/" \
    -e "s/@ACCENT@/#$accent/g" \
    -e "s/@SECONDARY@/#$secondary/g" \
    "$HOME/.config/waybar/colors.css.template" > "$HOME/.config/waybar/colors.css"

sed \
    -e "s/@DARKEST@/$darkest/g" \
    -e "s/@TEXT@/$lightest/g" \
    -e "s/@MUTED@/$muted/g" \
    -e "s/@ACCENT@/$accent/g" \
    -e "s/@SECONDARY@/$secondary/g" \
    "$HOME/.config/hypr/hyprtoolkit.conf.template" > "$HOME/.config/hypr/hyprtoolkit.conf"

pkill -USR2 -x waybar 2>/dev/null || true
