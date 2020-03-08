" Load defaults from defaults.vim
unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim


set shiftwidth=4
set autoindent
set smartindent

set number relativenumber

" ignore case when searching (set noic to disable)
set ic

" Highlight searches
set hls
" toggle highlights by Ctrl+C (clear)
map <C-c> <esc>:noh<enter>
" highlight while typing
set incsearch



" copy selection in visual mode
vmap <C-S-c> "+y
" cut selection in visual mode
vmap <C-S-x> "+x


" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

