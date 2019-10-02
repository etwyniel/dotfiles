set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
" The default vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2016 Sep 02
"
" This is loaded if no vimrc file was found.
" Except when Vim is run with "-u NONE" or "-C".
" Individual settings can be reverted with ":set option&".
" Other commands can be reverted as mentioned below.

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Bail out if something that ran earlier, e.g. a system wide vimrc, does not
" want Vim to use these default values.
if exists('skip_defaults_vim')
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Allow backspacing over everything in insert mode.
set backspace=indent,eol,start

set history=200		" keep 200 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set wildmenu		" display completion matches in a status line

set ttimeout		" time out for key codes
set ttimeoutlen=100	" wait up to 100ms after Esc for special key

" Show @@@ in the last line if it is truncated.
set display=truncate

" Show a few lines of context around the cursor.  Note that this makes the
" text scroll if you mouse-click near the start or end of the window.
set scrolloff=5

" Hide buffers instead of closing them
" set hidden

" Do incremental searching when it's possible to timeout.
if has('reltime')
  set incsearch
endif

" Do not recognize octal numbers for Ctrl-A and Ctrl-X, most users find it
" confusing.
set nrformats-=octal

" Don't use Ex mode, use Q for formatting.
" Revert with ":unmap Q".
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
" Revert with ":iunmap <C-U>".
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine.  By enabling it you
" can position the cursor, Visually select and scroll with the mouse.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on when the terminal has colors or when using the
" GUI (which always has colors).
if &t_Co > 2 || has("gui_running")
  " Revert with ":syntax off".
  syntax on

  " I like highlighting strings inside C comments.
  " Revert with ":unlet c_comment_strings".
  let c_comment_strings=1
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  " Revert with ":filetype off".
  filetype plugin indent on

  " Put these in an autocmd group, so that you can revert them with:
  " ":augroup vimStartup | au! | augroup END"
  augroup vimStartup
    au!

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    autocmd BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif

  augroup END

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
" Revert with: ":delcommand DiffOrig".
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
         \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If set (default), this may break plugins (but it's backward
  " compatible).
  set nolangremap
endif

" VIMPLUG
call plug#begin()
        "Plug 'lervag/vimtex'
        Plug 'rust-lang/rust.vim'
        "Plug 'prabirshrestha/async.vim'
        "Plug 'prabirshrestha/vim-lsp'
        "Plug 'prabirshrestha/asyncomplete.vim'
        "Plug 'prabirshrestha/asyncomplete-lsp.vim'
        "Plug 'vim-syntastic/syntastic'
call plug#end()

" PATHOGEN
let g:pathogen_disabled = ['syntax', 'syntastic', 'nerdtree', 'YouCompleteMe']
execute pathogen#infect()

set ts=8
set sts=4
set sw=4
set et
set nohls
set smartcase
nmap <Space> <leader>

" Powerline
"set rtp+=/usr/lib/python3.6/site-packages/powerline/bindings/vim
let g:airline_theme='gruvbox'
let g:airline_powerline_fonts = 1
let g:airline_section_x = ''
"let g:airline_section_y = ''
"let g:airline_section_warning = ''
"let g:airline_section_z = '%3p%% %#__accent_bold#%4l%#__restore__#%#__accent_bold#/%L%#__restore__# :%3v'

" run folder script
"if filereadable(getcwd() + "/.myvimscript.vim")
"	echo "Loaded dir script."
"	source .myvimscript.vim
"else
"	echo "No dir script found."
"endif
"echo getcwd()
" colorscheme papaya_original
let g:gruvbox_constrast_dark = 'hard'
let g:gruvbox_italic = '1'
colorscheme gruvbox
hi PMenu gui=bold
hi PMenuSel gui=bold guifg=#DADABA
let g:vim_markdown_folding_disabled = 1

set exrc
"set cm=blowfish2
set guicursor=
set number
set noswapfile
set backspace=eol,indent,start
set wildmenu
set wrap
set textwidth=80
set incsearch
let g:load_doxygen_syntax=1
noremap ; :
let g:ycm_server_python_interpreter='python2'
set encoding=utf-8
set pumblend=40
set termguicolors
autocmd BufNewFile,BufRead *.mako setf html
autocmd BufNewFile,BufRead *.jsschema set syntax=json
autocmd BufNewFile,BufRead *.m4 set matchpairs+=«:»
autocmd BufNewFile,BufRead *.c.m4 set syntax=c ai
autocmd BufNewFile,BufRead *.c set cc=81
autocmd BufNewFile,BufRead *.go set ts=4 sts=4 sw=4 noet
autocmd BufNewFile,BufRead *.rs nnoremap <F5> :CocCommand rust-analyzer.run<CR>

" IAR option files for compiler/linker
if getline(1) =~ '-!'
  set ft=xcl
  " c/cpp in any file containing c/cpp comment in line 1 or 2
elseif ((getline(1) =~ '\/\*') || (getline(1)=~ '\/\/') || (getline(2) =~ '\/\*') || (getline(2)=~ '\/\/'))
  set ft=c
  " dosbatch in any file containing comment in line 1, 2 or 3
elseif ((getline(1) =~ '^rem') || (getline(2)=~ '^rem') || (getline(3)=~ '^rem'))
  set ft=dosbatch
endif

if executable('rls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'beta', 'rls']},
        \ 'whitelist': ['rust'],
        \ })
endif

nmap <F8> :TagbarToggle<CR>
map <C-n> :bn<CR>
map <C-p> :bp<CR>

" Use Control+Arrow keys to move between buffers
nnoremap <silent> <C-Right> <c-w>l
nnoremap <silent> <C-Left> <c-w>h
nnoremap <silent> <C-Up> <c-w>k
nnoremap <silent> <C-Down> <c-w>j

" Alt+Left to go back one word
map <A-Left> b
" Alt+Right to go forward one word
map <A-Right> w
" Same in insert mode
imap <A-Left> <Esc>bi
imap <A-Right> <Esc>ea

" Make the home key go to the first non-whitespace character of the line
" in insert mode
imap <Home> <Esc>^i

" Use escape to exit terminal mode
tnoremap <Esc> <C-\><C-n>

" Make Control+Arrow key to navigate between window work in terminal mode
tnoremap <C-Left> <C-\><C-N><C-w>h
tnoremap <C-Down> <C-\><C-N><C-w>j
tnoremap <C-Up> <C-\><C-N><C-w>k
tnoremap <C-Right> <C-\><C-N><C-w>l

nnoremap <C-S-PageUp> :-tabm<CR>
nnoremap <C-S-PageDown> :+tabm<CR>

nnoremap / /\v
vnoremap / /\v

nnoremap <C-U> :UndotreeToggle<CR>
nnoremap <C-G> :Gstatus<CR>

let g:ycm_server_python_interpreter="/usr/bin/python"
let g:ycm_rust_src_path="/home/aymeric/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src"
let g:rust_src_path="/home/aymeric/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src"
let g:UltiSnipsExpandTrigger="<A-a>"
let g:airline#extensions#coc#enabled = 1

nnoremap <C-P> :CocList commands<CR>
inoremap <C-P> <Esc>:CocList commands<CR>
nnoremap <C-L> :CocList files<CR>
nnoremap <C-F> :CocFix<CR>
nnoremap <C-D> :CocList diagnostics<CR>

"nnoremap <F7> :setlocal spell! spell? spelllang=en_us<CR>
"inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

let g:UltiSnipsJumpForwardTrigger = "<tab>"
