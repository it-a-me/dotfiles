alias v "nvim -p"
alias dotman "git --git-dir $HOME/.dotfiles --work-tree $HOME"

alias ffmpeg 'ffmpeg -hide_banner'
alias ffprobe 'ffprobe -hide_banner'
alias ffplay 'ffplay -hide_banner'
alias codium 'codium --ozone-platform-hint=auto'
alias code 'code --ozone-platform-hint=auto'
alias vscode 'vscode --ozone-platform-hint=auto'

abbr ollama podman exec -it ollama ollama
abbr userctl systemctl --user
abbr ujournal journalctl --user
abbr g git 
abbr tmpman podman run -it --rm --workdir /mnt --mount type=bind,destination=/mnt,src=.
