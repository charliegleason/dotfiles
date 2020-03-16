call plug#begin(stdpath('data') . '/plugged')
" Fancy (and informative) statusline
Plug 'vim-airline/vim-airline'
" Status line themes
Plug 'vim-airline/vim-airline-themes'
" (Neo)vim syntax themes
Plug 'chriskempson/base16-vim'
Plug 'sickill/vim-monokai'
" Git wrapper
Plug 'tpope/vim-fugitive'
" Make netrw behave sensibly
Plug 'tpope/vim-vinegar'
" Brace surround commands
Plug 'tpope/vim-surround'
" Show marks in symbols column
Plug 'kshenoy/vim-signature'
" Undo tree visualizer
Plug 'mbbill/undotree'

" Code completion engine
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Language server support
Plug 'autozimu/LanguageClient-neovim', {
            \ 'branch': 'next',
            \ 'do': 'bash install.sh',
            \ }

" ctags-based completion for deoplete
Plug 'deoplete-plugins/deoplete-tag'
" Fuzzy search
Plug 'junegunn/fzf'
" Universal-ctags based navigation
Plug 'majutsushi/tagbar'

" Plug 'supercollider/scvim'
Plug 'davidgranstrom/scnvim'
Plug 'tidalcycles/vim-tidal'

call plug#end()


" PLUGIN SETTINGS

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1

" see theme.vim for color settings

" Deoplete
let g:deoplete#enable_at_startup = 1

" LanguageClient-neovim
let g:LanguageClient_loadSettings = 1
let g:LanguageClient_settingsPath = "~/.config/nvim/settings.json"
let g:LanguageClient_loggingFile = $HOME . "/.LanguageClient.log"
let g:LanguageClient_serverCommands = {
            \ 'python': ['pyls'],
            \ 'sh': ['bash-language-server', 'start'],
            \ 'c': ['ccls', '--log-file=/tmp/cc.log'],
            \ 'cpp': ['ccls', '--log-file=/tmp/cc.log'],
            \ 'cuda': ['ccls', '--log-file=/tmp/cc.log'],
            \ }
let g:LanguageClient_diagnosticsDisplay = {
            \   1: {
            \         'name': 'Error',
            \         'texthl': 'NormalNC',
            \         'signText': '',
            \         'signTexthl': 'SignColumn',
            \         'virtualTexthl': 'ErrorMsg',
            \     },
            \     2: {
            \         'name': 'Warning',
            \         'texthl': 'NormalNC',
            \         'signText': '',
            \         'signTexthl': 'SignColumn',
            \         'virtualTexthl': 'PreProc',
            \     },
            \     3: {
            \         'name': 'Information',
            \         'texthl': 'NormalNC',
            \         'signText': '',
            \         'signTexthl': 'SignColumn',
            \         'virtualTexthl': 'Special',
            \     },
            \     4: {
            \         'name': 'Hint',
            \         'texthl': 'NormalNC',
            \         'signText': '',
            \         'signTexthl': 'SignColumn',
            \         'virtualTexthl': 'Special',
            \     }
            \ }

let g:tidal_target = "terminal"
