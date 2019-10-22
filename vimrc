" Bail out if something that ran earlier, e.g. a system wide vimrc, does not
" want Vim to use these default values.
if exists('skip_defaults_vim')
  finish
endif

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
"let g:airline_section_x = ''
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
set incsearch
let g:load_doxygen_syntax=1
noremap ; :
set encoding=utf-8
set pumblend=40
set termguicolors
autocmd BufNewFile,BufRead *.mako setf html
autocmd BufNewFile,BufRead *.jsschema set syntax=json
autocmd BufNewFile,BufRead *.go set ts=4 sts=4 sw=4 noet
autocmd BufNewFile,BufRead *.rs nnoremap <F5> :CocCommand rust-analyzer.run<CR>
autocmd BufNewFile,BufRead *.tmpl set filetype=gohtmltmpl

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

nnoremap <C-S-PageUp> :-tabm<CR>
nnoremap <C-S-PageDown> :+tabm<CR>

nnoremap / /\v
vnoremap / /\v

nnoremap <C-U> :UndotreeToggle<CR>

nnoremap <C-G> :Gstatus<CR>

nnoremap <C-P> :CocList commands<CR>
inoremap <C-P> <Esc>:CocList commands<CR>
nnoremap <C-L> :CocList files<CR>
nnoremap <C-F> :CocFix<CR>
nnoremap <C-D> :CocList diagnostics<CR>

let g:rust_src_path="/home/aymeric/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src"
let g:UltiSnipsExpandTrigger="<A-a>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:airline#extensions#coc#enabled = 1

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
