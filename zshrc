export ZSH=$HOME/.oh-my-zsh

CASE_SENSITIVE="false"

plugins=(colored-man-pages archlinux catimg sudo git systemd wd docker kubectl fzf)

source $ZSH/oh-my-zsh.sh

alias ls=lsd
alias l="lsd -l"
alias la="lsd -la"
alias lt="lsd --tree"
alias cat="bat"
alias ip="ip -c=auto"
alias -g vim=nvim
alias k="kubectl --insecure-skip-tls-verify=true"
alias gdb="gdb -q"
alias ncmpcpp="ncmpcpp -c ~/.config/ncmpcpp/config"
alias scp='rsync --archive --xattrs --acls --progress --rsh="ssh"'

function ydl() {
    format=$(
        youtube-dl --list-formats "$1" |
        grep -v '^\[' |
        fzf --header-lines=1 |
        cut -d ' ' -f1
    )
    [[ -n "$format" ]] && youtube-dl -f $format "$1"
}

function pacs() {
    package=$(
        pacman -Ssq |
        fzf --preview 'pacman --color=always -Ss ^{}$'
    )
    [[ -n "$package" ]] && sudo pacman -S "$package"
}

# Movement with Alt+Arrow key
bindkey "\e[1;3D" backward-word
bindkey "\e[1;3C" forward-word

compinit
