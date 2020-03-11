" Load defaults from defaults.vim
unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

let mapleader = " "

set shiftwidth=4
set autoindent
set smartindent

set number relativenumber


" remap ` to § because ` is a bitch
onoremap § `
nnoremap § `
onoremap ` §
nnoremap ` §

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
vmap <C-S-x> "+x

" tab whole selection
vmap <Tab> :><enter>
" and untab on shift+tab
vmap <S-Tab> :<<enter>


" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

