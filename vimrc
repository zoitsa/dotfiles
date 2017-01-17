
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

" use zsh as shell
set shell=/bin/zsh


" Setup term color support
if $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
  set t_Co=256
endif

set history=100     " Default history is only 20
set undolevels=100  " Use more levels of undo

syntax on             " Enable syntax highlighting
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

" Ruler on
set ruler

" Edit another file in the same directory as the current file
" uses expression to extract path from current file's path
map <Leader>e :e <C-R>=expand("%:p:h") . '/'<CR>
map <Leader>s :split <C-R>=expand("%:p:h") . '/'<CR>
map <Leader>v :vsplit <C-R>=expand("%:p:h") . '/'<CR>
map <Leader>t :tabe <C-R>=expand("%:p:h") . '/'<CR>

" easier save
map <C-s>  <esc>:w<CR>
imap <C-s> <esc>:w<CR>
map <C-x>  <C-w>c

" sudo save
cmap w!! w !sudo tee % >/dev/null

" Rel Line numbers on
set relativenumber
" easy relative numbers toggle
function! NumberToggle()
  if(&relativenumber == 1)
    set nu
    "set relativenumber
  else
    set relativenumber
  endif
endfunc
nnoremap <C-n> :call NumberToggle()<cr>

" Minimal number of screen lines to keep above and below the cursor
set scrolloff=3

" make markdown work with .md as well as .markdown
au BufRead,BufNewFile *.md,*.markerb set filetype=markdown
autocmd FileType markdown setlocal spell
let g:markdown_github_languages = ['ruby', 'erb=eruby', 'javascript']


" reopen file at the same line
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" remove whitespace on save
fun! StripTrailingWhitespace()
    " Only strip if the b:noStripeWhitespace variable isn't set
    if exists('b:noStripWhitespace')
        return
    endif
    %s/\s\+$//e
endfun
autocmd BufWritePre * call StripTrailingWhitespace()
autocmd FileType markdown let b:noStripWhitespace=1

set background=dark
colorscheme Tomorrow-Night-Eighties
highlight NonText guibg=#060606
highlight Folded  guibg=#0A0A0A guifg=#9090D0
set cursorline

" Search Settings
set incsearch   " show search matches as you type
set ignorecase  " case insensitive search
set smartcase   " If a capital letter is included in search, make it case-sensitive
set nohlsearch  " dont highlight search results
" toggle search highlighting mapped to \h
" http://stackoverflow.com/a/26504944/209064
:nnoremap <silent><expr> <Leader>h (&hls && v:hlsearch ? ':nohls' : ':set hls')."\n"

" make regexp search not suck by default -
nnoremap / /\v
vnoremap / /\v

" make capital w/q actually write/quit
cnoreabbrev W w
cnoreabbrev Q q

" remap split navigation keys
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" easier tab navigation
map <leader>[ gT
map <leader>] gt

" open new tab
map <leader>T :tabe<CR>

" Softtabs, 2 spaces
set smartindent
set tabstop=2
set expandtab
set shiftwidth=2

" Automatically :write before running commands
set autowrite

" Wrapping
set nowrap
set linebreak
" :Wrap command to turn on wrapping mapped to \w
command! -nargs=* Wrap set wrap! nolist! wrap?
nnoremap <Leader>w :Wrap<CR>
" Make wrapped lines easier to read
let &showbreak=repeat(' ', 14)

" Display extra whitespace
set list listchars=tab:»·,trail:·

" more normal splits
set splitbelow
set splitright

" Always show status line.
set laststatus=2


" wrap git messages at 72
autocmd Filetype gitcommit setlocal spell textwidth=72


" Use The Silver Searcher instead of grep
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0

endif
" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" bind \ (backward slash) to grep shortcut
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

nnoremap \ :Ag<SPACE>

" draw a line at column 80
" set textwidth=80
" let &colorcolumn=join(range(80,80),",")
" highlight ColorColumn ctermbg=235 guibg=#2c2d27

" set custom cursor -- vertical bar in insert mode (iTerm2)
" from http://www.iterm2.com/#/section/documentation/escape_codes
if !has("gui")
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" if using iterm and my light profile, lighten things up
if $ITERM_PROFILE =~ 'Light'
  colorscheme cobalt2
  set background=light
  highlight ColorColumn ctermbg=000 guibg=#121212
  highlight Normal ctermbg=NONE
  highlight nonText ctermbg=NONE
  " copied this line from above
  " hi CursorLine cterm=none
endif
if $ITERM_PROFILE =~ 'Solarized.*'
  colorscheme solarized
endif
if $ITERM_PROFILE == 'Solarized Dark'
  set background=dark
endif



" Leader Ctrl-] to open ctag in vsplit
map <leader><C-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" Surround.vim
" leader-a then a thing will surround the current word with that thing
map <Leader>a ysiw

" NERDtree
" close if last buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" CtrlP + ctags
nnoremap <leader>p :CtrlPTag<CR>
" search in current, ancestor, root
let g:ctrlp_working_path_mode = 'car'


" Airline
let g:airline_powerline_fonts = 1


"Writing
autocmd User GoyoEnter Limelight
autocmd User GoyoLeave Limelight!

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif

" ------------------------------------------------------------------------------
" Code Folding
" ------------------------------------------------------------------------------
set foldmethod=indent
set foldlevel=1
set nofoldenable
set foldnestmax=10

" fold code on space
nnoremap <space> za
vnoremap <space> zf

" don't ignore stuff in folds
set foldignore=

" save and restore folds when a file is closed and re-opened
autocmd BufWinLeave ?* mkview
autocmd BufWinEnter ?* silent loadview

" Erasing previously entered characters in insert mode
set backspace=indent,eol,start

" Syntastic Recommended Settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
