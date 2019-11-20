.PHONY:all
all: vim nvim zsh

${HOME}/.config:
	mkdir $@

.PHONY: vim
vim: ${HOME}/.vim ${HOME}/.vimrc
${HOME}/.vim:
	ln -sT $(realpath vim) $@
${HOME}/.vimrc:
	ln -s $(realpath vimrc) $@

.PHONY: nvim
nvim: vim ${HOME}/.config ${HOME}/.config/nvim
${HOME}/.config/nvim:
	ln -sT $(realpath vim) $@

.PHONY: zsh
zsh: ${HOME}/.zshenv ${HOME}/.zshrc
${HOME}/.zshenv:
	ln -s $(realpath zshenv) $@
${HOME}/.zshrc:
	ln -s $(realpath zshrc) $@
