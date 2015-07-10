set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
let g:vundle_default_git_proto = 'git'
call vundle#begin()

Plugin 'airblade/vim-gitgutter'
Plugin 'bling/vim-airline'
Plugin 'craigemery/vim-autotag'
Plugin 'gmarik/Vundle.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'rking/ag.vim'
Plugin 'scrooloose/nerdtree.git'
Plugin 'tomasr/molokai'
Plugin 'reedes/vim-colors-pencil'
Plugin 'tpope/vim-cucumber'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'godlygeek/tabular'
Plugin 'kchmck/vim-coffee-script'
Plugin 'scrooloose/syntastic'
Plugin 'sjl/vitality.vim'
Plugin 'lchi/vim-toffee'
Plugin 'slim-template/vim-slim'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'scrooloose/nerdcommenter'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'

call vundle#end()

filetype plugin indent on
syntax on
let g:airline_theme='pencil'
" setting hidden allows undo to work after buffer was closed
:colorscheme pencil
set hidden
set noswapfile
set scrolloff=4
set nobackup
set mouse=a
set nocompatible
set tabstop=2 shiftwidth=2 expandtab
set number
set relativenumber
set nowrap
set backspace=indent,eol,start
set textwidth=0
set wrapmargin=0
set t_Co=256
set relativenumber
set background=light
map <C-n> :NERDTreeToggle<CR>
map ,n :NERDTreeFind<CR>
let g:airline_theme = 'pencil'
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = {
  \ 'dir': '\v[\/](\.git|tmp|node_modules)'
  \ }
set cursorline
set wildignore=*.keep,*~,*.swp
" To quit all files quickly - useful for quitting 'git d' by holding down on Q
map Q :qa<CR>
au FileType css setl ofu=csscomplete#CompleteCSS
au FocusLost * :wa

" Toggle between the last 2 files
nmap <Tab> :b#<CR>
" Add blank line above or below without entering insert mode
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>
" Airline settings
let g:airline_powerline_fonts = 1
set laststatus=2

" Function and key mapping for running cucumber test
" ,t - Run scenario under cursor
" ,T - Run whole feature file
let mapleader = ","
autocmd FileType cucumber nmap <leader>t :call RunCucumberTest(line('.'))<CR>
autocmd FileType cucumber nmap <leader>T :call RunCucumberTest()<CR>
function! RunCucumberTest(...)
        let cmd = 'bundle exec cucumber'
        let @t = ':!' . cmd . ' ' . expand('%') . (a:0 == 1 ? ':'.line('.') : '')
        if strlen(@t > 0)
                execute ':wa'
                execute @t
        elseif
                echoerr "No test command to run"
        endif
endfunction

set mouse+=a
if &term =~ '^screen'
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
endif

" Auto remove all trailing characters
autocmd BufWritePre * :%s/\s\+$//e

set timeout         " Do time out on mappings and others
set timeoutlen=2000 " Wait {num} ms before timing out a mapping

" When you’re pressing Escape to leave insert mode in the terminal, it will by
" default take a second or another keystroke to leave insert mode completely
" and update the statusline. This fixes that. I got this from:
" https://powerline.readthedocs.org/en/latest/tipstricks.html#vim
if !has('gui_running')
  set ttimeoutlen=10
  augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=1000
  augroup END
endif

" Format cucumber table
map \| :Tab /\|<CR>

" Remap VIM 0 to first non-blank character
map 0 ^

autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
