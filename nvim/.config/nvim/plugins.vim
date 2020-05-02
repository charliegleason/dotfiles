call plug#begin(stdpath('data') . '/plugged')
" Fancy (and informative) statusline
Plug 'vim-airline/vim-airline'
" Status line themes
Plug 'vim-airline/vim-airline-themes'
" (Neo)vim syntax themes
Plug 'chriskempson/base16-vim'
Plug 'neovimhaskell/haskell-vim'
Plug 'cseelus/vim-colors-lucid'
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

" Wiki
Plug 'vimwiki/vimwiki'

" SuperCollider
Plug 'davidgranstrom/scnvim'
" TidalCycles
Plug 'tidalcycles/vim-tidal'

" fetlang
" Plug 'kutsan/vim-fetlang'
call plug#end()


" PLUGIN SETTINGS
" see theme.vim for color settings

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1

" Deoplete
let g:deoplete#enable_at_startup = 1

" LanguageClient-neovim
let g:LanguageClient_loadSettings = 1
let g:LanguageClient_settingsPath = "~/.config/nvim/settings.json"
let g:LanguageClient_loggingFile = $HOME . "/.LanguageClient.log"
let g:LanguageClient_serverCommands = {
            \ 'python': ['pyls'],
            \ 'sh': ['bash-language-server', 'start'],
            \ 'c': ['clangd', '--header-insertion=never', '--limit-results=32'],
            \ 'cpp': ['clangd', '--header-insertion=never', '--limit-results=32'],
            \ 'cuda': ['clangd', '--header-insertion=never', '--limit-results=32'],
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

" vim-tidal
let g:tidal_target = "terminal"

" SCNvim
let g:scnvim_postwin_orientation = 'h'
" Disable all default key mappings (see ./mappings.vim)
let g:scnvim_no_mappings = 1
" Browse documentation within Neovim
let g:scnvim_scdoc = 1
" Set post window height
let g:scnvim_postwin_size = 25
