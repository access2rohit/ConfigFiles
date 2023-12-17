filetype plugin indent on
syntax on
set autoindent
set tabstop=4
set nonu
colorscheme default
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<,space:·
" F3: Toggle list (display unprintable characters).
nnoremap <F3> :set list!<CR>
map <C-n> :NERDTreeToggle<CR>
nnoremap <C-g> :YcmCompleter GoToReferences<CR>
nnoremap <C-f> :YcmCompleter GoToDefinitionElseDeclaration<CR>
map <silent> <F2> :TagbarToggle<CR>
set tags+=tags;/
nmap <silent> <C-e> <Plug>(ale_next_wrap)
map <leader>] :bnext<CR>
map <leader>[ :bprevious<CR>

nnoremap <leader>f :ALENextWrap<CR>
nnoremap <leader>b :ALEPreviousWrap<CR>
nnoremap <leader>F :ALELast<CR>
nnoremap <leader>B :ALEFirst<CR>

" Vundle Vim
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" vim-python-pep8-indent
Plugin 'Vimjas/vim-python-pep8-indent'
" You Complete Me
Plugin 'Valloric/YouCompleteMe'
" NERDTree
Plugin 'preservim/nerdtree'
" ALE
Plugin 'dense-analysis/ale'
" VIM-Airline
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" Tagbar
Plugin 'preservim/tagbar'
" Cuda syntax highlight
Plugin 'bfrg/vim-cuda-syntax'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

let g:NERDTreeShowGitStatus=1
let NERDTreeShowHidden=1

let g:ale_linters = {'python': ['mypy', 'bandit', 'pydocstyle']}
let g:ale_fixers = {'*': [], 'python': ['black', 'isort']}
let g:ale_fix_on_save = 1
" let g:ale_sign_error = '●'
" let g:ale_sign_warning = '.'
let g:ale_sign_error = '💣'
let g:ale_sign_warning = '🚩'
let g:ale_statusline_format = ['💣 %d', '🚩 %d', '']
let g:ale_lint_on_save = 1
function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    return l:counts.total == 0 ? 'OK' : printf(
        \   '%d⨉ %d⚠ ',
        \   all_non_errors,
        \   all_errors
        \)
endfunction
set statusline+=%=
set statusline+=\ %{LinterStatus()}
let g:ale_set_highlights = 0
let g:ale_virtualtext_cursor = 'disabled'
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1

au BufRead,BufNewFile *.cu set filetype=cuda
au BufRead,BufNewFile *.cuh set filetype=cuda

" This will check the current folder for tags file and keep going one directory up all the way to the root folder.
set tags=tags;/
set hidden
