.PHONY:all
all: submodules vim nvim zsh

.PHONY: submodules
submodules:
	git submodule update --init --recursive

${HOME}/.config:
	mkdir $@

.PHONY: vim
vim: submodules ${HOME}/.vim ${HOME}/.vimrc
${HOME}/.vim:
	ln -sT $(realpath vim) $@
${HOME}/.vimrc:
	ln -s $(realpath vimrc) $@

.PHONY: nvim
nvim: K := $(if $(shell which nvim),some string,$(error "No nvim in PATH"))
nvim: submodules vim ${HOME}/.config ${HOME}/.config/nvim
${HOME}/.config/nvim:
	ln -sT $(realpath vim) $@

.PHONY: zsh
zsh: K := $(if $(shell which zsh),some string,$(error "No zsh in PATH"))
zsh: ${HOME}/.zshenv ${HOME}/.zshrc
${HOME}/.zshenv:
	ln -s $(realpath zshenv) $@
${HOME}/.zshrc:
	ln -s $(realpath zshrc) $@
