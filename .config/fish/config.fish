source ~/.config/fish/env.fish

if status is-interactive
	source ~/.config/fish/abbr.fish
	set fish_greeting
end

if command -v 'nvim' > /dev/null
	set MANPAGER 'nvim +Man!'
	export MANPAGER
end

function no_hist -S
	builtin history clear-session
	set -x fish_history ''
end

function fish_command_not_found
    __fish_default_command_not_found_handler $argv
end

if test -f "~/.config/fish/$(hostname).fish"
	source "~/.config/fish/$(hostname).fish"
end

for file in ~/.config/fish/functions/*.fish
	source "$file"
end


