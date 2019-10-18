export ZSH=$HOME/.oh-my-zsh

CASE_SENSITIVE="false"

plugins=(colored-man-pages archlinux catimg sudo git systemd wd docker kubectl)

source $ZSH/oh-my-zsh.sh

alias ls=lsd
alias l="lsd -l"
alias la="lsd -la"
alias lt="lsd --tree"
alias cat="bat"
alias ip="ip -c=auto"
alias vim=nvim
alias k="kubectl --insecure-skip-tls-verify=true"
alias gdb="gdb -q"
alias ncmpcpp="ncmpcpp -c ~/.config/ncmpcpp/config"
alias scp='rsync --archive --xattrs --acls --progress --rsh="ssh"'

# Movement with Alt+Arrow key
bindkey "\e[1;3D" backward-word
bindkey "\e[1;3C" forward-word

compinit
