" Load defaults from defaults.vim
unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

let mapleader = " "

set shiftwidth=4
set tabstop=4
set autoindent
set smartindent

" Open new split panes to right and bottom
set splitbelow
set splitright


" Any buffer can be hidden without saving first
set hidden
set autowrite

set number relativenumber

" set cursor options for VTE based terminals
" https://vim.fandom.com/wiki/Change_cursor_shape_in_different_modes
let &t_SI = "\<Esc>[5 q"
let &t_SR = "\<Esc>[3 q"
let &t_EI = "\<Esc>[1 q"

" bind Ctrl+J to jump to tags (Ctrl+J is just like j per default?)
nnoremap <C-j> <C-]>

" ignore case when searching (set noic to disable)
" set ic
" ignore case unless uppercase is used
set smartcase

" Highlight searches
set hls
" toggle highlights by Ctrl+C (clear)
map <C-c> <esc>:noh<enter>
" highlight while typing
set incsearch

" file search be fuzzy
" search files recursevly in folders
set path+=**
" tab completion
set wildmenu


" copy selection in visual mode
vmap <C-S-c> "+y
" cut selection in visual mode
vmap <C-S-d> "+d

" tab whole selection
vmap <Tab> :><cr>
" and untab on shift+tab
vmap <S-Tab> :<<cr>


" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

" Plugins
call plug#begin()

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

Plug 'junegunn/vim-peekaboo'

Plug 'tpope/vim-surround'

Plug 'easymotion/vim-easymotion'

Plug 'qpkorr/vim-bufkill'

Plug 'mhinz/vim-signify'

Plug 'gaving/vim-textobj-argument'

Plug 'tpope/vim-fugitive'

call plug#end()


" fzf config
let $FZF_DEFAULT_COMMAND = 'rg --hidden --files'
nnoremap <Leader>ls :Buffers<Enter>
nnoremap <Leader>m :Marks<Enter>
nnoremap <C-f> :Files<Enter>

" add current file to staging
nnoremap ga :G add %<Enter>

" add numbered J and K to jumplist
nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'


