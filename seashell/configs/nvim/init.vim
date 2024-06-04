" leader key
let mapleader = "\<Space>"
let maplocalleader = "\<Space>"
nnoremap <Space> <Nop>


" 4 spaces tabs and indentation
set smartindent
set expandtab
set cursorline
set tabstop=4
set softtabstop=4
set shiftwidth=4
set splitright
set splitbelow

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader><leader> <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fn <cmd>Telescope orgmode search_headings<cr>

nnoremap <leader>w <cmd>update <cr>

nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

xnoremap <leader>p "\"_dP

" Autoformat on save 
augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END

" Per language
augroup indentation
  autocmd!
  autocmd FileType vim setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd FileType nix setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd FileType scheme setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd FileType racket setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END

" line numbers
set number
set relativenumber

" spacing when scrolling
set scrolloff=4

" use system clipboard via xsel
" set clipboard+=unnamedplus
vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <C-r><C-o>+

" mouse support
set mouse=a

" Set the cursor to a line after leaving
au VimLeave * set guicursor=a:ver100

" Fuck Ex mode
:map Q <Nop>

let g:transparent_enabled = v:true
let g:highlightedyank_highlight_duration = 3

" Comes from modeline
set noshowmode

" modeline magic
set modeline
