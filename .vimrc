set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'vim-airline/vim-airline'
Plugin 'preservim/nerdtree'
Plugin 'vim-syntastic/syntastic'
Plugin 'tpope/vim-commentary'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

if has("gui_running")
   let s:uname = system("uname")
   if s:uname == "Darwin\n"
      set guifont=Meslo\ LG\ S\ DZ\ for\ Powerline:h16
   endif
endif

function! ToggleLineNumbers()
  if &buftype == "quickfix"
    if empty(getloclist(0))
      :.cc
    else
      :.ll
    endif
  else
    if &number == 1
      set nonumber
    else
      set number
    endif
  endif
endfunction

" airline options
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#tabs_label = ''
let g:airline#extensions#tabline#buffers_label = ''
let g:airline#extensions#tabline#fnamemod = ':t' " disable file paths in the tab
let g:airline#extensions#tabline#show_tab_count = 0
let g:airline#extensions#tabline#tab_min_count = 2
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#show_tab_type = 0

" syntastic options
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" nerdtree options
map <silent> <f2> :NERDTreeToggle<CR>
let g:NERDTreeShowBookmarks=1
let g:NERDTreeQuitOnOpen=1
let g:NERDTreeWinSize=50
let g:NERDTreeGitStatusMapPrevHunk = '[h'
let g:NERDTreeGitStatusMapNextHunk = ']h'

" vim-gutter options
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)

" general options
let mapleader=","
set smarttab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set hlsearch
set number
nnoremap <silent> <CR> :call ToggleLineNumbers()<CR>

