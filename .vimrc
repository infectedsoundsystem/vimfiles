" ==========================================================
" Basic Settings
" ==========================================================
set nocompatible        " Don't be compatible with vi
let mapleader=","       " change the leader to be a comma vs slash

syntax on               " syntax highlighing
filetype on             " try to detect filetypes
filetype plugin indent on   " enable loading indent file for filetype
set number              " Display line numbers
set numberwidth=1       " using only 1 column (and 1 space) while possible
set background=dark     " We are using dark background in vim
set title               " show title in console title bar
set wildmenu            " Menu completion in command mode on <Tab>
set wildmode=full       " <Tab> cycles between all matching choices.
set noerrorbells        " don't bell or blink
"set vb t_vb=

" Ignore these files when completing
set wildignore+=*.o,*.obj,.git,*.pyc
set wildignore+=eggs/**
set wildignore+=*.egg-info/**

" Moving Around/Editing
set cursorline          " have a line indicate the cursor location
set ruler               " show the cursor position all the time
set nostartofline       " Avoid moving cursor to BOL when jumping around
set virtualedit=block   " Let cursor move past the last char in <C-v> mode
set scrolloff=6         " Keep 3 context lines above and below the cursor
set backspace=2         " Allow backspacing over autoindent, EOL, and BOL
set showmatch           " Briefly jump to a paren once it's balanced
"set nowrap             " don't wrap text
set linebreak           " don't wrap textin the middle of a word
set autoindent          " always set autoindenting on
silent! set breakindent " indent wrapped text
set showbreak=-->       " better show of wrapped text
set tabstop=4           " <tab> inserts 4 spaces
set shiftwidth=4        " but an indent level is 2 spaces wide.
set softtabstop=4       " <BS> over an autoindent deletes both spaces.
set expandtab           " Use spaces, not tabs, for autoindent/tab key.
set shiftround          " rounds indent to a multiple of shiftwidth
set matchpairs+=<:>     " show matching <> (html mainly) as well
set foldmethod=indent   " allow us to fold on indents
set foldlevel=99        " don't fold by default
set colorcolumn=81      " highlight column 81

" Reading/Writing
set noautowrite         " Never write a file unless I request it.
set noautowriteall      " NEVER.
set noautoread          " Don't automatically re-read changed files.
"set modeline           " Allow vim options to be embedded in files;
"set modelines=5        " they must be within the first or last 5 lines.
set ffs=unix,dos,mac    " Try recognizing dos, unix, and mac line endings.
set ff=unix             " Default is unix

" Messages, Info, Status
set ls=2                " always show status line
set vb t_vb=            " Disable all bells. I hate ringing/flashing.
set confirm             " Y-N-C prompt if closing with unsaved changes.
set showcmd             " Show incomplete normal mode commands as I type.
set report=0            " : commands always print changed line count.
set shortmess+=a        " Use [+]/[RO]/[w] for modified/readonly/written.
set ruler               " Show some info, even without statuslines.
"set statusline=[%l,%v\ %P%M]\ %f\ %r%h%w\ (%{&ff})

" Searching and Patterns
set ignorecase          " Default to using case insensitive searches,
set smartcase           " unless uppercase letters are used in the regex.
set smarttab            " Handle tabs more intelligently
set hlsearch            " Highlight searches by default.
set incsearch           " Incrementally search while typing a /regex

" swp/swo/undo file locations
if has("win32")
    set backupdir=$HOME/vimfiles/temp//
    set directory=$HOME/vimfiles/temp//
    set undodir=$HOME/vimfiles/temp//
    " Also set vimrc location to this one
    let $MYVIMRC=$HOME/vimfiles/.vimrc
else
    set backupdir=$HOME/.vim/temp//
    set directory=$HOME/.vim/temp//
    set undodir=$HOME/.vim/temp//
endif

set undofile            " Turns on persistent undo

" GUI settings
if has("gui_running")
    set lines=65 columns=100
    set guioptions-=T       " remove toolbar
    if has("win32")
        set guifont=Droid_Sans_Mono_Slashed:h10
    else
        set guifont=Droid\ Sans\ Mono\ Slashed\ 10
    endif
endif

" ==========================================================
" Plugin Settings
" ==========================================================

""">>> NeoBundle
if has("win32")
    set runtimepath+=$HOME/vimfiles/bundle/neobundle.vim/
    call neobundle#begin(expand('$HOME/vimfiles/bundle/'))
    " Assume behind proxy if being forced to use Windows
    let g:neobundle#types#git#default_protocol = 'https'
else
    set runtimepath+=$HOME/.vim/bundle/neobundle.vim/
    call neobundle#begin(expand('~/.vim/bundle/'))
    let g:neobundle#types#git#default_protocol = 'git'
endif

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles
" Vimproc - async execution. Check build tools installed else ignore
if (has("win32") == 0 && (executable("make") || executable("gmake"))) || (has("win32") && (executable("mingw32-make") || executable("make")))
    NeoBundle 'Shougo/vimproc.vim', {
    \ 'build' : {
    \     'windows' : 'tools\\update-dll-mingw',
    \     'cygwin' : 'make -f make_cygwin.mak',
    \     'mac' : 'make -f make_mac.mak',
    \     'linux' : 'make',
    \     'unix' : 'gmake',
    \    },
    \ }
endif
NeoBundle 'github:jnurmine/Zenburn' " Zenburn color scheme
NeoBundle 'github:Raimondi/delimitMate' " delimiter closing
NeoBundle 'github:othree/html5.vim' " HTML5 syntax etc
NeoBundle 'github:Shougo/unite.vim' " file/buffer/etc navigation
NeoBundle 'github:Shougo/neocomplete' " completion
NeoBundle 'github:chrisbra/NrrwRgn' " opens selected in split window
NeoBundle 'github:hotchpotch/perldoc-vim' " interface to perldoc
NeoBundle 'github:c9s/perlomni.vim' " perl omni completion
NeoBundle 'github:vim-perl/vim-perl' " perl syntax etc
NeoBundle 'github:StanAngeloff/php.vim' " php syntax etc
NeoBundle 'github:Aluriak/nerdcommenter' " easy line commenting
"NeoBundle 'github:majutsushi/tagbar' " browse ctags-generated tags
NeoBundle 'github:etdev/vim-hexcolor' " css colour highlight
"NeoBundle 'github:tpope/vim-fugitive' " git wrapper
NeoBundle 'github:pangloss/vim-javascript' " js syntax/indenting
NeoBundle 'github:nathanaelkane/vim-indent-guides' " indentation guides
NeoBundle 'github:elzr/vim-json' " json highlighting etc
NeoBundle 'github:joshtch/matchit.zip' " % matches more
NeoBundle 'github:terryma/vim-multiple-cursors' " Sublime-like multiple cursors
NeoBundle 'github:hynek/vim-python-pep8-indent' " correct Python indentation
NeoBundle 'github:iynaix/django.vim' " django template syntax highlighting
NeoBundle 'github:tpope/vim-surround' " easily change surroundings
NeoBundle 'github:vim-scripts/XSLT-syntax' " XSLT syntax highlighting
NeoBundle 'github:fatih/vim-go' " Go (golang) support
" Syntax checking, requires external syntax checkers:
" https://github.com/scrooloose/syntastic/wiki/Syntax-Checkers
NeoBundle 'github:scrooloose/syntastic'
" better status/tabline
NeoBundle 'github:bling/vim-airline', {'depends' :
    \ ['github:majutsushi/tagbar', 'github:tpope/vim-fugitive']
    \ }

call neobundle#end()

" Disabled by NeoBundle, re-enable
syntax on
filetype on             " try to detect filetypes
filetype plugin indent on   " enable loading indent file for filetype

" Check for uninstalled bundles
NeoBundleCheck
"""<<< NeoBundle


""">>> Perl syntax
let perl_include_pod   = 1    "include pod.vim syntax file with perl.vim
let perl_extended_vars = 1    "highlight complex expressions such as @{[$x, $y]}
let perl_sync_dist     = 250  "use more context for highlighting
au BufRead,BufNewFile *.tpl set filetype=perl
au BufRead,BufNewFile *.ipl set filetype=perl
au BufRead,BufNewFile *.cgi set filetype=perl
"""<<< Perl syntax


""">>> XSLT Syntax
let b:xsl_include_html = 1
let b:xsl_include_css = 1
let b:xsl_include_javascript = 1
let b:xsl_include_perl = 1
"""<<< XSLT Syntax


""">>> Zenburn
if has("gui_running") == 0
    " 256-color terminal mode
    set t_Co=256
endif
let g:zenburn_high_Contrast=1
silent! colorscheme zenburn
"""<<< Zenburn


""">>> NeoComplete
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
    "return neocomplete#smart_close_popup() . "\<CR>"
    return neocomplete#close_popup() . "\<CR>"
    " For no inserting <CR> key.
    "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
" For perlomni.vim setting.
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
"""<<< NeoComplete


""">>> Multiple Cursors
" Multiple cursors neocomplete conflict resolution
" Called once right before you start selecting multiple cursors
function! Multiple_cursors_before()
  if exists(':NeoCompleteLock')==2
    exe 'NeoCompleteLock'
  endif
endfunction

" Called once only when the multiple selection is canceled (default <Esc>)
function! Multiple_cursors_after()
  if exists(':NeoCompleteUnlock')==2
    exe 'NeoCompleteUnlock'
  endif
endfunction
"""<<< Multiple Cursors


""">>> Airline
let g:airline#extensions#tabline#enabled = 1
"let g:airline_powerline_fonts = 1
"""<<< Airline


""">>> vim-go
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
"""<<< vim-go

""">>> Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_flake8_args='--ignore=E501'
"""<<< Syntastic


" ==========================================================
" Custom Mappings
" ==========================================================

" Scheme indentation
silent! autocmd filetype lisp,racket,scheme setlocal equalprg=scmindent

" Paste from clipboard
map <leader>p "+p
" Copy to clipboard
map <leader>y "+y
" Select all
map <leader>a ggVG

" Remove trailing whitespace on <leader>S
nnoremap <leader>S :%s/\s\+$//<cr>:let @/=''<CR>

" ctrl-jklm changes to that split
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h
" and lets make these all work in insert mode too ( <C-O> makes next cmd
" happen as if in command mode )
imap <C-W> <C-O><C-W>

" clear search
command C let @/=""

" don't outdent hashes
inoremap # #

" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>

" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm
