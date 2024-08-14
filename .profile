export ENV=$HOME/.config/init.sh
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/SSH_AUTH_SOCK"

if test "$(tty)" = '/dev/tty1'; then
	XDG_CURRENT_DESKTOP=sway sway
fi
