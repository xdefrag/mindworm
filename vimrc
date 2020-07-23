filetype plugin on
filetype indent on

set nobackup
set nowritebackup
set noswapfile
set autoread
set autowriteall
set history=9000
set undofile
set undodir=~/.vimundo
set mouse=
set ttymouse=sgr
set updatetime=500
set balloondelay=250
set signcolumn=yes
set clipboard=unnamed
set nocursorline
set showmatch
set noruler
set nolist
set noerrorbells
set novisualbell
set t_vb=
set lazyredraw
set incsearch
set hlsearch
set ignorecase
set path+=**
set wildmenu
set foldenable
set foldlevelstart=10
set foldnestmax=20
set foldmethod=syntax
set autoindent
set smartindent
set backspace=2
set laststatus=2
set statusline=
set statusline +=%4*\ %<%F%* "full path
set statusline +=%2*%m%*     "modified flag
set statusline +=%1*%=%5l%*  "current line
set statusline +=%2*/%L%*    "total lines
set statusline +=%1*%4v\ %*  "virtual column number

let g:netrw_banner = 0
let g:netrw_keepdir = 0
let g:netrw_liststyle = 1
let g:netrw_sort_options = 'i'

let mapleader = " "

set background=dark

" let g:beelzebub_bg="233"
" let g:beelzebub_fg="250"
" let g:beelzebub_mute="60"

colorscheme beelzebub

nnoremap <leader>b :Buffers<CR>
nnoremap <leader>f :Files<CR>
nnoremap <leader>r :Rg<CR>
nnoremap <leader>s :Snippets<CR>
nnoremap <leader>h :History<CR>
nnoremap <leader>c :History:<CR>

inoremap jk <Esc>
nnoremap j gj
nnoremap k gk
nnoremap ; :
vnoremap ; :
nnoremap L $
nnoremap H ^
nnoremap Q q
nnoremap q :close<CR>

nnoremap <silent> g= mzgg=G`zzz
xnoremap <  <gv
xnoremap >  >gv
nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz
nnoremap <C-f> <C-f>zz
nnoremap <C-b> <C-b>zz
nnoremap <silent> n :norm! nzz<CR>
nnoremap <silent> N :norm! Nzz<CR>
vnoremap <silent> n :norm! nzz<CR>
vnoremap <silent> N :norm! Nzz<CR>

noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>
inoremap <Up> <nop>
inoremap <Down> <nop>
inoremap <Left> <nop>
inoremap <Right> <nop>

func! GodotSettings() abort
    setlocal foldmethod=expr
    setlocal tabstop=4
    nnoremap <buffer> <F4> :GodotRunLast<CR>
    nnoremap <buffer> <F5> :GodotRun<CR>
    nnoremap <buffer> <F6> :GodotRunCurrent<CR>
    nnoremap <buffer> <F7> :GodotRunFZF<CR>
endfunc

augroup godot | au!
    au FileType gdscript call GodotSettings()
augroup end