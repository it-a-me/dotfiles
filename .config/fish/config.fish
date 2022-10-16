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
end

set -a MANPATH ~/.local/share/man
