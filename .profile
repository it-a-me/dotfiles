export ENV=$HOME/.config/init.sh
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/SSH_AUTH_SOCK"
export PATH="${PATH}:${HOME}/.local/bin"

if test "$(tty)" = '/dev/tty1' && [ -z "$WAYLAND_DISPLAY" ]; then
	XDG_CURRENT_DESKTOP=sway sway 2>"${HOME}/.cache/sway.log"
	#PATH="${HOME}/.local/sway/bin:${PATH}" LD_LIBRARY_PATH=${HOME}/.local/sway/lib64 XDG_CURRENT_DESKTOP=sway ~/.local/sway/bin/sway 2>"${HOME}/.cache/sway.log"
fi
