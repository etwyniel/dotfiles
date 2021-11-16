export ZSH=$HOME/.oh-my-zsh

CASE_SENSITIVE="false"

plugins=(colored-man-pages archlinux catimg sudo git systemd wd docker kubectl fzf cargo rustup rust pip battery)

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
alias mv="mv --no-clobber"

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
    packages=($(
        pacman -Ssq |
        fzf -m --preview 'pacman --color=always -Ss ^{}$; echo; pacman --color=always -Si {}'
    ))
    if [[ -n "$packages" ]]; then
        if [ -n "$WIDGET" ]; then
            echo -n "sudo pacman -S $packages"
        else
            sudo pacman -S $packages
        fi
    fi
}

function unzipc() {
    filename="$(basename "$1")"
    dirname="${filename%.*}"
    mkdir "$dirname"
    unzip "$1" -d "$dirname"
}

# Movement with Alt+Arrow key
bindkey "\e[1;3D" backward-word
bindkey "\e[1;3C" forward-word

pacs-widget() {
    cmd=$(pacs)
    if [ -n "$cmd" ]; then
        LBUFFER="$cmd"
        zle reset-prompt
        zle accept-line
    fi
}

zle -N pacs-widget

macro() {
    if [ "$LBUFFER" = pacs ]; then
        zle pacs-widget
    elif [[ "$LBUFFER" =~ '\<pod$' ]]; then
        pod=$(select_pod)
        LBUFFER="${LBUFFER%pod}$pod"
    else
        LBUFFER+="!"
    fi
}

zle -N macro
bindkey '!' macro

compinit
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
