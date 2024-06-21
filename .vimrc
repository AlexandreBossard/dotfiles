" syntax on
" filetype off
if $TERM == "xterm-screen-256color"
    set term=xterm-256color
endif

set statusline=%F%m%r%h%w\ [TYPE=%Y\ %{&ff}]\ [%l/%L\ %c/%v\ (%p%%)]\ %{fugitive#statusline()}
autocmd FileType c,cpp :set cindent
set number
set nocp
" set laststatus=2
set bs=2
" map <M-right> :bn<CR>
" map <M-left> :bp<CR>
" map <M-up> :buffers<CR>:buffer

" set t_Co=256	"256 Colors
set autowrite
set tabstop=2
set shiftwidth=2
set expandtab
" set smarttab
set hlsearch
set incsearch
set cursorline
set showcmd
autocmd FileType qml,c,cpp,h,hpp,git,js,tex syn match Todo /\s\+$\| \+\ze\t/

set shell=/bin/sh

set wildignore+=*/node_modules/*,build,build-default/*,.git/*,*/vendor/*,*/bin/*,*.o,*.so,*.a
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

Plugin 'glts/vim-magnum.git'
Plugin 'glts/vim-radical.git'

Plugin 'tpope/vim-sensible.git'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround.git'
Plugin 'tpope/vim-repeat.git'
Plugin 'tpope/vim-commentary.git'
Plugin 'vim-scripts/argtextobj.vim'
Plugin 'prabirshrestha/asyncomplete.vim'

Plugin 'sheerun/vim-polyglot'

Plugin 'w0rp/ale'

Plugin 'kien/ctrlp.vim'
"Plugin 'scrooloose/nerdcommenter'
"Plugin 'Valloric/YouCompleteMe'
Plugin 'luochen1990/rainbow'
"Plugin 'SirVer/ultisnips'
Plugin 'derekwyatt/vim-fswitch'
"Plugin 'honza/vim-snippets'
Plugin 'qpkorr/vim-bufkill'
Plugin 'OmniSharp/omnisharp-vim'

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

Plugin 'octol/vim-cpp-enhanced-highlight'

Plugin 'flazz/vim-colorschemes'

Plugin 'nathanaelkane/vim-indent-guides'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" let g:ycm_autoclose_preview_window_after_completion = 0
" let g:ycm_autoclose_preview_window_after_insertion = 1
" let g:ycm_error_symbol = '!>'
" let g:ycm_warning_symbol = '~>'
" let g:ycm_python_binary_path = 'python3'

" nn <leader>gg :YcmCompleter GoToImprecise<CR>
" nn <leader>gd :YcmCompleter GoToDefinition<CR>
" nn <leader>gD :YcmCompleter GoToDeclaration<CR>
" nn <leader>gt :YcmCompleter GetTypeImprecise<CR>
" nn <leader>gG :YcmCompleter GoTo<CR>
" nn <leader>gT :YcmCompleter GetType<CR>
" nn <leader>gR :YcmCompleter RefactorRename 
" nn <F4> :YcmCompleter GoToInclude<CR>

" ctrlp

let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" airline

let g:airline_theme = 'molokai'

" ale
let g:ale_linters = {
      \   'javascript': ['eslint', 'flow'],
      \   'jsx': ['eslint'],
      \   'cpp': [],
      \   'c': [],
      \   'python': ['black', 'flake8'],
      \   'cs': ['OmniSharp']
      \}

let g:ale_javascript_eslint_use_global = 1

let g:ale_linter_aliases = {'jsx': 'css'}

let g:ale_fixers = {
      \ 'javascript': ['eslint'],
      \ 'python': ['black'],
      \ 'cpp': ['clang-format'],
      \ 'cs': ['OmniSharp']
      \ }

autocmd FileType c,cpp,javascript,jsx nmap <Leader>cf <Plug>(ale_fix)

let g:ale_python_black_executable = 'poetry'
let g:ale_python_black_options = 'run black'
let g:ale_python_flake8_executable = 'poetry'
let g:ale_python_flake8_options = 'run flake8'

autocmd FileType cpp,objc,python let g:ale_fix_on_save = 1


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

" augroup go
"   autocmd!
"   autocmd Filetype go
"         \  command! -bang A call go#alternate#Switch(<bang>0, 'edit')
"         \| command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
"         \| command! -bang AS call go#alternate#Switch(<bang>0, 'split')
" augroup END

let g:fsnonewfiles = 1
augroup my_fswitch_au_group
    au!
    au BufEnter *.h   let b:fswitchlocs = 'reg:/include/src/,reg:/Headers/Sources/,reg:|include/[^/]\+|src|,reg:|include\(/[^/]\+\)\{2\}|src|'
    au BufEnter *.hh  let b:fswitchlocs = 'reg:/include/src/,reg:|include/[^/]\+|src|,reg:|include\(/[^/]\+\)\{2\}|src|'
    au BufEnter *.hpp let b:fswitchlocs = 'reg:/include/src/,reg:|include/[^/]\+|src|,reg:|include\(/[^/]\+\)\{2\}|src|'
    au BufEnter *.hxx let b:fswitchlocs = 'reg:/include/src/,reg:|include/[^/]\+|src|,reg:|include\(/[^/]\+\)\{2\}|src|'
    au BufEnter *.H   let b:fswitchlocs = 'reg:/include/src/,reg:|include/[^/]\+|src|,reg:|include\(/[^/]\+\)\{2\}|src|'
    au BufEnter *.c   let b:fswitchlocs = 'reg:/src/include/,reg:|src|include/*|,reg:|src|include/*/*|'
    au BufEnter *.cc  let b:fswitchlocs = 'reg:/src/include/,reg:|src|include/*|,reg:|src|include/*/*|'
    au BufEnter *.cpp let b:fswitchlocs = 'reg:/src/include/,reg:|src|include/*|,reg:|src|include/*/*|'
    au BufEnter *.cxx let b:fswitchlocs = 'reg:/src/include/,reg:|src|include/*|,reg:|src|include/*/*|'
    au BufEnter *.C   let b:fswitchlocs = 'reg:/src/include/,reg:|src|include/*|,reg:|src|include/*/*|'
    au BufEnter *.m   let b:fswitchlocs = 'reg:/Sources/Headers/'
augroup END

let &t_ut=''

" Asyncomplete: {{{
let g:asyncomplete_auto_popup = 1
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"inoremap <expr> <cr> pumvisible() ? asyncomplete#close_popup() . "\<cr>" : "\<cr>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
let g:asyncomplete_auto_completeopt = 0
set completeopt=menuone,noinsert,noselect,preview
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
" }}}


let g:OmniSharp_server_use_net6 = 1
let g:OmniSharp_selector_ui = 'ctrlp'  " Use ctrlp.vim
" Timeout in seconds to wait for a response from the server
let g:OmniSharp_timeout = 5

" " Set the type lookup function to use the preview window instead of echoing it
let g:OmniSharp_typeLookupInPreview = 1

let g:OmniSharp_popup_position = 'peek'
let g:OmniSharp_popup_options = {
\ 'highlight': 'Normal',
\ 'padding': [0],
\ 'border': [1],
"\ 'borderchars': ['─', '│', '─', '│', '╭', '╮', '╯', '╰'],
\ 'borderhighlight': ['ModeMsg']
\}
let g:OmniSharp_popup_mappings = {
\ 'sigNext': '<C-n>',
\ 'sigPrev': '<C-p>',
\ 'pageDown': ['<C-f>', '<PageDown>'],
\ 'pageUp': ['<C-b>', '<PageUp>']
\}

" Fetch full documentation during omnicomplete requests.
" By default, only Type/Method signatures are fetched. Full documentation can
" still be fetched when you need it with the :OmniSharpDocumentation command.
let g:omnicomplete_fetch_full_documentation = 1

" Set desired preview window height for viewing documentation.
" You might also want to look at the echodoc plugin.
set previewheight=3

" Update semantic highlighting on BufEnter and InsertLeave
let g:OmniSharp_highlight_types = 2

augroup omnisharp_commands
  autocmd!

  " Show type information automatically when the cursor stops moving.
  " Note that the type is echoed to the Vim command line, and will overwrite
  " any other messages in this space including e.g. ALE linting messages.
  " autocmd CursorHold *.cs OmniSharpTypeLookup

  " The following commands are contextual, based on the cursor position.
  autocmd FileType cs nmap <silent> <buffer> gd <Plug>(omnisharp_go_to_definition)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfu <Plug>(omnisharp_find_usages)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfi <Plug>(omnisharp_find_implementations)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ospd <Plug>(omnisharp_preview_definition)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ospi <Plug>(omnisharp_preview_implementations)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ost <Plug>(omnisharp_type_lookup)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osd <Plug>(omnisharp_documentation)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfs <Plug>(omnisharp_find_symbol)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfx <Plug>(omnisharp_fix_usings)
  autocmd FileType cs nmap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)
  autocmd FileType cs imap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)

  " Navigate up and down by method/property/field
  autocmd FileType cs nmap <silent> <buffer> [[ <Plug>(omnisharp_navigate_up)
  autocmd FileType cs nmap <silent> <buffer> ]] <Plug>(omnisharp_navigate_down)
  " Find all code errors/warnings for the current solution and populate the quickfix window
  autocmd FileType cs nmap <silent> <buffer> <Leader>osgcc <Plug>(omnisharp_global_code_check)
  " Contextual code actions (uses fzf, vim-clap, CtrlP or unite.vim selector when available)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osca <Plug>(omnisharp_code_actions)
  autocmd FileType cs xmap <silent> <buffer> <Leader>osca <Plug>(omnisharp_code_actions)
  " Repeat the last code action performed (does not use a selector)
  autocmd FileType cs nmap <silent> <buffer> <Leader>os. <Plug>(omnisharp_code_action_repeat)
  autocmd FileType cs xmap <silent> <buffer> <Leader>os. <Plug>(omnisharp_code_action_repeat)

  autocmd FileType cs nmap <silent> <buffer> <Leader>os= <Plug>(omnisharp_code_format)

  autocmd FileType cs nmap <silent> <buffer> <Leader>osnm <Plug>(omnisharp_rename)

  autocmd FileType cs nmap <silent> <buffer> <Leader>osre <Plug>(omnisharp_restart_server)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osst <Plug>(omnisharp_start_server)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ossp <Plug>(omnisharp_stop_server)
augroup END

colorscheme Monokai

" To ignore plugin indent changes, instead use:
"filetype plugin on
"filetype plugin on
"filetype plugin indent on
