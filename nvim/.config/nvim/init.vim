if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Read plugins config file
exec 'source ' . stdpath('config') . '/plugins.vim'

" Automatically reload open files when external changes are detected
set autoread

" Use UTF-8
set encoding=utf-8
" 1 tab = 4 spaces
set tabstop=4
set shiftwidth=4
set expandtab


" UI SETTINGS

" Use syntax highlighting
syntax on
filetype plugin indent on
" Show line numbers
" Use hybrid line numbering - current line is absolute, all others are relative
set number relativenumber
" Don't show line numbers in terminal windows
augroup termnumber
    autocmd!
    autocmd TermOpen,TermEnter * setlocal nonumber norelativenumber signcolumn=auto
augroup END
" Always show the sign column
set signcolumn=auto
" Hide the default mode text (e.g. -- INSERT -- below the statusline)
set noshowmode
" Show (partial) command in status line.
set showcmd
" Always display the statusline in all windows
set laststatus=2
" Always display the tabline, even if there is only one tab
set showtabline=2
" Required for operations modifying multiple buffers like rename
set hidden
" Fold based on code indentation
set foldmethod=indent
" Fold no more than 2 levels/indents deep (such as class methods in Python)
set foldnestmax=2
" Highlight matching brackets
set showmatch
" Open new windows below and/or to the right of the active window
set splitbelow
set splitright
" Enable mouse usage in all modes
set mouse=a
" Don't make all windows the same size after splitting or closing a window
set noequalalways
" Hide certain characters unless cursor is on top (mainly applies to Markdown)
set conceallevel=2

" Jump to the last position when reopening a file
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Save undo history
if has("persistent_undo")
    set undofile
endif

" If editing a commit message, etc., open a new split rather than a nested nvim
let $GIT_EDITOR = "nvr -cc split --remote-wait"
autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete

let $EDITOR = "nvr -cc split --remote-wait"

" ccls
function! C_init()
  setl formatexpr=LanguageClient#textDocument_rangeFormatting()
endf
" Call C_init() when editing C-family source code
au FileType c,cpp,cuda,objc :call C_init()

autocmd FileType supercollider setlocal autoindent noexpandtab tabstop=4 shiftwidth=4

" Don't indicate curly brackets within parentheses as an error
" (e.g. when providing a lambda as an argument)
let c_no_curly_error = 1

" Read additional configuration files
exec 'source ' . stdpath('config') . '/mappings.vim'
exec 'source ' . stdpath('config') . '/netrw.vim'
exec 'source ' . stdpath('config') . '/theme.vim'
