" 256 color support is assumed (such as in gnome-terminal). As long as the
" terminal supports 256 colors, this ensures colors look the same
" regardless of the terminal color scheme.
"
" To disable (and use the terminal color scheme), uncomment this line and
" comment the next:
" set notermguicolors
set termguicolors

" Set color scheme
set background=dark
silent! colorscheme base16-monokai
" silent! colorscheme base16-materia

" Signature settings (show mark locations in symbol column)
" Show marks using the SignColumn highlight group
highlight! link SignatureMarkText SignColumn
highlight! link SignatureMarkerText SignColumn

" SCNvim settings
highlight! link SCNvimEval Visual

" Airline settings
" Enter :AirlineTheme and press <TAB> to see a list of all the themes
let g:airline_theme="base16_monokai"
" let g:airline_theme="base16"

" Set to 1 to use fancy Powerline symbols (requires a font supporting
" Powerline symbols)
let g:airline_powerline_fonts = 1
