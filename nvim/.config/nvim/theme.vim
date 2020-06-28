" Source base16 shell file (this needs to be done before setting a syntax
" color scheme in order to set a vim theme different than the shell theme)
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

" Set color scheme
" set background=light
" silent! colorscheme pencil
" set termguicolors
" set background=dark
"
" silent! colorscheme base16-monokai
" silent! colorscheme base16-materia
" silent! colorscheme monokai

" Signature settings (show mark locations in symbol column)
" Show marks using the SignColumn highlight group
highlight! link SignatureMarkText SignColumn
highlight! link SignatureMarkerText SignColumn

" SCNvim settings
highlight! link SCNvimEval Visual

" Airline settings
" Enter :AirlineTheme and press <TAB> to see a list of all the themes
let g:airline_theme="base16_monokai"
" let g:airline_theme="monochrome"
let g:airline_theme="base16_vim"

" Set to 1 to use fancy Powerline symbols (requires a font supporting
" Powerline symbols)
let g:airline_powerline_fonts = 1
