source ~/.config/fish/env.fish

if status is-interactive
	~/.config/shellsv2/update.pl
	source ~/.config/shellsv2/export/path.fish
	source ~/.config/shellsv2/export/env.sh
	source ~/.config/shellsv2/export/alias.sh
	~/.config/shellsv2/startwm.pl

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

abbr ollama podman exec -it ollama ollama

alias ffmpeg 'ffmpeg -hide_banner'
alias ffprobe 'ffprobe -hide_banner'
alias ffplay 'ffplay -hide_banner'
