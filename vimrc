" add nerdtree plugin to the search path
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

let g:NERDTreeWinPos = "right" " open NERDTree on right side always
set splitright

" setting       abbr.           explanation
" tabstop=4     ts              A four-space tab indent width
" shiftwidth=4  sw              This allows you to use the < and > keys from VIM's visual (marking) mode to block indent/unindent regions
" smarttab      sta             Use the "shiftwidth" setting for inserting <TAB>s instead of the "tabstop" setting, when at the beginning of a line
" expandtab     et              Insert spaces instead of <TAB> character when the <TAB> key is pressed
" softtabstop=4 sts             VIM sees multiple space characters as tabstops, and so <BS> does the right thing and will delete four spaces
" autoindent    ai              When you press RETURN and a new line is created, the indent of the new line will match that of the previous line.

set ts=4 sts=4 sw=4 noexpandtab

" Enable file type detection
filetype plugin indent on
au FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
au FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
au FileType html setlocal ts=2 sts=2 sw=2 ai expandtab
au FileType css setlocal ts=2 sts=2 sw=2 expandtab
au FileType javascript setlocal ts=2 sts=2 sw=2 ai expandtab
au FileType python setlocal ts=4 sts=4 sw=4 ai expandtab
au BufRead,BufNewFile *.sls setlocal ts=4 sts=4 sw=4 ai expandtab

function TrimFile()
	let save_cursor = getpos(".")
	:silent! %s/\($\n\s*\)\+\%$// " Remove all trailing newlines
	:silent! %s/\s\+$//e " Remove trailing whitespaces
	call setpos('.', save_cursor)
endfunction

" Use the below highlight group when displaying bad whitespace is desired.
highlight BadWhitespace ctermbg=red guibg=red

" Python specifics
let g:flake8_max_line_length = 120
au BufRead,BufNewFile *.py match BadWhitespace /^\t\+/ " Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py match BadWhitespace /\s\+$/ " Make trailing whitespace be flagged as bad.
au BufWritePre *.py :Isort " sort all imports
au BufWritePre *.py call TrimFile() " trim the file before saving
au BufWritePost *.py call Flake8()
au BufWritePre *.js call TrimFile() " trim the file before saving

syntax on " For full syntax highlighting:

set t_Co=256 " number of colors for this terminal
set textwidth=120 " Wrap text after a certain number of characters
set encoding=utf-8 " Set the default file encoding to UTF-8:
set fileformat=unix " Use UNIX (\n) line endings.
set wildignore=*.o,*~,*.pyc " Ignore compiled files
set number " Turn on the line numbering
set showtabline=2 " Show the tabline
set hlsearch " Highlight search matches
set incsearch " Incremental searching
set ignorecase " Searches are case insensitive...
set smartcase " ... unless they containt at least one capital letter
set backspace=indent,eol,start  " backspace through everything in insert mode
set nobackup
set noswapfile
set nowritebackup
set autoread " automatically reread the file

" Folding based on indentation: ``set foldmethod=indent``

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
nnoremap <leader>w :w!<cr>

" Fast quiting
nnoremap <leader>q :q!<cr>

" Fast quitting all
nnoremap <leader>x :quitall!<cr>

" Fast write + quiting
" nmap <leader>wq :wq<cr>

" Configure Nerdcommenttoggle
map <leader>c<space> <plug>NERDCommenterComment
map <leader>cc <plug>NERDCommenterToggle

" Call NERDTree
nmap <leader><Space> :NERDTreeTabsToggle<cr>

" Calll vsplit
nmap <leader>s :vsplit<cr>

" Call split
nmap <leader>h :split<cr>

" line navigation
" 1 - beginning of line
" 0 - end of line
nnoremap 0 g_
nnoremap 1 ^
vnoremap 0 g_
vnoremap 1 ^

" tab navigation
" Shift + n - go to the left tab
" Shift + m - go to the right tab
nnoremap <S-n> gT
nnoremap <S-m> gt

" window navigation
" Shift + l - moves to window to the right
" Shift + h - moves to window to the left
nnoremap <S-l> :wincmd l<cr>
nnoremap <S-h> :wincmd h<cr>
nnoremap <S-j> :wincmd j<cr>
nnoremap <S-k> :wincmd k<cr>
