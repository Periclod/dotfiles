let g:loaded_python_provider = 0
let g:python3_host_porg = "/usr/bin/python"

set exrc
set secure

let mapleader = " "
set shiftwidth=4
set tabstop=4
set autoindent
set smartindent

" Open new split panes to right and bottom
set splitbelow 
set splitright

set number relativenumber

" set cursor options for VTE based terminals
" https://vim.fandom.com/wiki/Change_cursor_shape_in_different_modes
let &t_SI = "\<Esc>[5 q"
let &t_SR = "\<Esc>[3 q"
let &t_EI = "\<Esc>[1 q"

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
call plug#begin('~/.config/nvim/plugged')
" fuzzy search for a bunch of things
" Plug 'junegunn/fzf'
" Plug 'junegunn/fzf.vim'

" Finder popup
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary!' }

" autocomplete curtesy of VSCode
Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': { -> coc#util#install()} }

" clap + coc
Plug 'vn-ki/coc-clap'

" outline sidebar
Plug 'liuchengxu/vista.vim'
" " linting
" Plug 'dense-analysis/ale'
" show register before pasting
Plug 'junegunn/vim-peekaboo'
" file viewer
Plug 'preservim/nerdtree'
" show git icons in nerdtree
Plug 'Xuyuanp/nerdtree-git-plugin'
" surround stuff in parenthesis etc
Plug 'tpope/vim-surround'
" Easier navigation accross multiple 'f's
Plug 'easymotion/vim-easymotion'
" Delete buffers without breaking splits
Plug 'qpkorr/vim-bufkill'
" vcs aware sidebar
Plug 'mhinz/vim-signify'
" toggle-able autosave
Plug '907th/vim-auto-save'
" argument as text motion
Plug 'gaving/vim-textobj-argument'
" better git commands
Plug 'tpope/vim-fugitive'
" path, includexpr, include for some languages
Plug 'tpope/vim-apathy'
" dd does not save the deleted lines in a register anymore
Plug 'svermeulen/vim-cutlass'
" single shortcut to replace text from register
Plug 'https://github.com/svermeulen/vim-subversive'
" Yank timetravel cycling
Plug 'https://github.com/svermeulen/vim-yoink'
" comment stuff out
Plug 'tpope/vim-commentary'

" Themes
Plug 'rafalbromirski/vim-aurora'
Plug 'jcherven/jummidark.vim'
call plug#end()

" look and feel
set termguicolors
set background=dark
colorscheme jummidark



" coc.vim config
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=1

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)zz
nmap <silent> gy <Plug>(coc-type-definition)zz
nmap <silent> gi <Plug>(coc-implementation)zz
nmap <silent> gr <Plug>(coc-references)zz

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>rf <Plug>(coc-refactor)

" Formatting selected code.
xmap <leader>fmt  <Plug>(coc-format-selected)
nmap <leader>fmt  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" apply codeAction for current file
nmap <leader>ac  <Plug>(coc-codeaction-line)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P(%L)
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}\ 

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <leader>d  :Clap coc_diagnostics<cr>
" nnoremap <silent> <leader>d  :<C-u>CocList --normal diagnostics<cr>
" Show commands.
nnoremap <silent> <leader>c  :CocList -N commands<cr>
" nnoremap <silent> <leader>c  :<C-u>CocList -N commands<cr>
" Search workspace symbols.
nnoremap <silent> <leader>s  :Clap coc_symbols<cr>
" nnoremap <silent> <leader>s  :<C-u>CocList -I -N symbols<cr>
" Search current document (outline)
nnoremap <silent> <leader>o  :Clap tags<cr>
" nnoremap <silent> <leader>o  :<C-u>CocList outline<cr>
" Do default action for next item.
nnoremap <silent> <leader>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <leader>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <leader>p  :<C-u>CocListResume<CR>

nnoremap <C-j> gi


" NERDTree config

let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
nnoremap <Leader>T :NERDTreeToggle<Enter>
nnoremap <Leader>f :NERDTreeFind<Enter>

" vista config

nnoremap <leader>V :Vista!!<Enter>
let g:vista_default_executive = 'coc'
let g:vista_sidebar_width = 60

" clap config
let $FZF_DEFAULT_COMMAND = 'rg --hidden --files'
nnoremap ; :Clap buffers<Enter>
nnoremap <Leader>m :Clap marks<Enter>
nnoremap <leader>O :Clap files<Enter>
nnoremap <leader>g :Clap grep
nnoremap <silent><leader>w :execute 'Clap grep ++query='.substitute(expand('<cword>'), '\v([\^\.\+\$])', '\\\1', 'g')<CR>
" nnoremap <silent><leader>w :execute 'Rg '.substitute(expand('<cword>'), '\v([\^\.\+\$])', '\\\1', 'g')<CR>

let g:clap_theme = 'material_design_dark'
let g:clap_preview_siz = 10
let g:clap_open_action = { 'ctrl-t': 'tab split', 'ctrl-x': 'split', 'ctrl-v': 'vsplit', 'ctrl-i': 'split', 'ctrl-s': 'vsplit', 'ctrl-o': 'e' }
let g:clap_enable_yanks_provider = 0


" add current file to staging
nnoremap ga :G add %<Enter>

" peakaboo config

function! CreateCenteredFloatingWindow()
    let width = float2nr(&columns * 0.6)
    let height = float2nr(&lines * 0.6)
    let top = ((&lines - height) / 2) - 1
    let left = (&columns - width) / 2
    let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}

    let top = "╭" . repeat("─", width - 2) . "╮"
    let mid = "│" . repeat(" ", width - 2) . "│"
    let bot = "╰" . repeat("─", width - 2) . "╯"
    let lines = [top] + repeat([mid], height - 2) + [bot]
    let s:buf = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
    call nvim_open_win(s:buf, v:true, opts)
    set winhl=Normal:Floating
    let opts.row += 1
    let opts.height -= 2
    let opts.col += 2
    let opts.width -= 4
    call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
    au BufWipeout <buffer> exe 'bw '.s:buf
endfunction

let g:peekaboo_window="call CreateCenteredFloatingWindow()"

" cutlass (delete blackhole) remappings
nnoremap x d
xnoremap x d
nnoremap xx dd
nnoremap X D
" subversive remappings
nmap s <plug>(SubversiveSubstitute)
nmap ss <plug>(SubversiveSubstituteLine)
nmap S <plug>(SubversiveSubstituteToEndOfLine)
xmap s <plug>(SubversiveSubstitute)
xmap p <plug>(SubversiveSubstitute)
xmap P <plug>(SubversiveSubstitute)
" better yank config
nmap <c-n> <plug>(YoinkPostPasteSwapBack)
nmap <c-p> <plug>(YoinkPostPasteSwapForward)
nmap p <plug>(YoinkPaste_p)
nmap P <plug>(YoinkPaste_P)
nmap y <plug>(YoinkYankPreserveCursorPosition)
xmap y <plug>(YoinkYankPreserveCursorPosition)
nmap Y y$
let g:yoinkIncludeDeleteOperations = 1

