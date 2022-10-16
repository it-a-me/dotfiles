if [[ -n "$1" ]]; then
    hyprctl dispatch workspace "$1"
fi
