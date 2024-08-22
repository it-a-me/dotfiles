function dotman-setup
	if test ! -d "$HOME/.dotfiles"
		git clone --bare https://github.com/it-a-me/dotfiles "$HOME/.dotfile"
	end
	git --git-dir "$HOME/.dotfiles" --work-tree "$HOME" config status.showUntrackedFiles no
end
