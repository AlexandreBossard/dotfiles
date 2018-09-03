syntax on
filetype off
if $TERM == "xterm-screen-256color"
    set term=xterm-256color
endif

set statusline=%F%m%r%h%w\ [TYPE=%Y\ %{&ff}]\ [%l/%L\ %c/%v\ (%p%%)]\ %{fugitive#statusline()}
autocmd FileType c,cpp :set cindent
set number
set nocp
set laststatus=2
set bs=2
map <M-right> :bn<CR>
map <M-left> :bp<CR>
map <M-up> :buffers<CR>:buffer

"set t_Co=256	"256 Colors
set autowrite
"set tags+=~/.mytags/stdtags ",~/.mytags/qttags
set tabstop=2
set shiftwidth=2
set expandtab
set smarttab
set hlsearch
set incsearch
set cursorline
set showcmd
autocmd FileType qml,c,cpp,h,hpp,git,js,tex syn match Todo /\s\+$\| \+\ze\t/

set shell=/bin/sh

set wildignore+=*/node_modules/*,build(-default)?,.git/*,*/vendor/*,*/bin/*,*.o,*.so,*.a


set cino=g0,b1,N-s,)40

set rtp+=~/.vim/bundle/Vundle.vim

set backup
set undofile

set undodir=~/.vim/tmp/undo/
set backupdir=~/.vim/tmp/backup/

set mps+=<:>
imap jj <Esc>

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround.git'
Plugin 'tpope/vim-repeat.git'

Plugin 'sheerun/vim-polyglot'

Plugin 'w0rp/ale'

Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'Valloric/YouCompleteMe'
Plugin 'luochen1990/rainbow'
Plugin 'SirVer/ultisnips'
Plugin 'derekwyatt/vim-fswitch'
Plugin 'honza/vim-snippets'
Plugin 'qpkorr/vim-bufkill'

Plugin 'rking/ag.vim'
Plugin 'Chun-Yang/vim-action-ag'

Plugin 'octol/vim-cpp-enhanced-highlight'

Plugin 'fatih/vim-go'

Plugin 'flazz/vim-colorschemes'

Plugin 'nathanaelkane/vim-indent-guides'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
let g:ycm_autoclose_preview_window_after_completion = 0
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_error_symbol = '!>'
let g:ycm_warning_symbol = '~>'
let g:ycm_python_binary_path = 'python3'

nn <leader>gg :YcmCompleter GoToImprecise<CR>
nn <leader>gd :YcmCompleter GoToDefinition<CR>
nn <leader>gD :YcmCompleter GoToDeclaration<CR>
nn <leader>gt :YcmCompleter GetTypeImprecise<CR>
nn <leader>gG :YcmCompleter GoTo<CR>
nn <leader>gT :YcmCompleter GetType<CR>
nn <leader>gR :YcmCompleter RefactorRename 
nn <F4> :YcmCompleter GoToInclude<CR>

nn <C-_> <plug>NERDCommenterToggle


let g:UltiSnipsExpandTrigger="<c-j>"

" ale
let g:ale_linters = {
      \   'javascript': ['eslint', 'flow'],
      \   'jsx': ['eslint'],
      \   'cpp': [],
      \   'c': [],
      \}

let g:ale_javascript_eslint_use_global = 1

let g:ale_linter_aliases = {'jsx': 'css'}

let g:ale_fixers = {
      \ 'javascript': ['eslint'],
      \ 'cpp': ['clang-format']
      \ }

autocmd FileType c,cpp,javascript,jsx nmap <Leader>cf <Plug>(ale_fix)

autocmd FileType cpp,objc let g:ale_fix_on_save = 1


" rainbow
let g:rainbow_conf = {
      \ 'ctermfgs': ['197', 'lightblue', 'lightyellow', 'darkcyan', 'lightmagenta']
      \}
let g:rainbow_active=1

" cpp-highlight
let g:cpp_class_scope_highlight = 1
let g:cpp_class_decl_highlight = 1

" javascript
let g:javascript_plugin_flow = 1

" fs-switch
command! A :FSHere
command! AH :FSLeft
command! AL :FSRight
command! AJ :FSBelow
command! AK :FSAbove
command! IK :FSSplitAbove
command! IL :FSSplitRight
command! IJ :FSSplitBelow
command! IH :FSSplitLeft

augroup go
  autocmd!
  autocmd Filetype go
        \  command! -bang A call go#alternate#Switch(<bang>0, 'edit')
        \| command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
        \| command! -bang AS call go#alternate#Switch(<bang>0, 'split')
augroup END

let g:fsnonewfiles = 1
augroup my_fswitch_au_group
    au!
    au BufEnter *.h   let b:fswitchlocs = 'reg:|include/[^/]\+|src|,reg:/include/src/,ifrel:|/include/|../src|'
    au BufEnter *.hh  let b:fswitchlocs = 'reg:|include/[^/]\+|src|,reg:/include/src/,ifrel:|/include/|../src|'
    au BufEnter *.hpp let b:fswitchlocs = 'reg:|include/[^/]\+|src|,reg:/include/src/,ifrel:|/include/|../src|'
    au BufEnter *.hxx let b:fswitchlocs = 'reg:|include/[^/]\+|src|,reg:/include/src/,ifrel:|/include/|../src|'
    au BufEnter *.H   let b:fswitchlocs = 'reg:|include/[^/]\+|src|,reg:/include/src/,ifrel:|/include/|../src|'
    au BufEnter *.c   let b:fswitchlocs = 'reg:/src/include/,reg:|src|include/*|,ifrel:|/src/|../include|'
    au BufEnter *.cc  let b:fswitchlocs = 'reg:/src/include/,reg:|src|include/*|,ifrel:|/src/|../include|'
    au BufEnter *.cpp let b:fswitchlocs = 'reg:/src/include/,reg:|src|include/*|,ifrel:|/src/|../include|'
    au BufEnter *.cxx let b:fswitchlocs = 'reg:/src/include/,reg:|src|include/*|,ifrel:|/src/|../include|'
    au BufEnter *.C   let b:fswitchlocs = 'reg:/src/include/,reg:|src|include/*|,ifrel:|/src/|../include|'
    au BufEnter *.m   let b:fswitchlocs = 'reg:/src/include/,reg:|src|include/*|,ifrel:|/src/|../include|'
augroup END

" go                                               
let g:go_fmt_command="goimports"
let g:syntastic_go_checkers=['golint','govet','errcheck']
let g:go_highlight_functions=1
let g:go_highlight_methods=1
let g:go_highlight_fields=1
let g:go_highlight_types=1
let g:go_highlight_operators=1
let g:go_highlight_build_constraints=1

colorscheme Monokai

" To ignore plugin indent changes, instead use:
"filetype plugin on
"filetype plugin on
"filetype plugin indent on
