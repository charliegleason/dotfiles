" Open a terminal in a new split
function! HSplitTerminal()
    new | terminal
endfunction

function! VSplitTerminal()
    vnew | terminal
endfunction

" Open a terminal in a new tab
function! TabTerminal()
    tabnew | terminal
endfunction

" Remove trailing whitespace in the current buffer
function! RemoveTrailingWhitespace()
    silent! % substitute /\s\+$//g
endfunction

" Commands for opening terminals
command! HSplitTerminal :call HSplitTerminal()
command! VSplitTerminal :call VSplitTerminal()
command! TabTerminal :call TabTerminal()

command! RTrailing :call RemoveTrailingWhitespace()

" LanguageClient commands
command! Format :call LanguageClient_textDocument_formatting()
command! GotoDef :sp | call LanguageClient_textDocument_definition()
command! Rename :call LanguageClient_textDocument_rename()
command! ShowDoc :call LanguageClient_textDocument_hover()

" Set <leader>
let mapleader = ","
" Set <localleader>
let maplocalleader = "\\"

" Use Alt-{h,j,k,l} to navigate splits in normal and terminal modes
nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l
tnoremap <M-h> <C-\><C-n><C-w>h
tnoremap <M-j> <C-\><C-n><C-w>j
tnoremap <M-k> <C-\><C-n><C-w>k
tnoremap <M-l> <C-\><C-n><C-w>l

" Make Esc behave the same way in terminal mode as in other modes
tnoremap <Esc> <C-\><C-n>
tnoremap <M-[> <Esc>
tnoremap <leader>e <Esc>

" <leader> mappings (generally) use mnemonics following a noun, verb (optional), adjective pattern

" Split the current window vertically ([w]indow [v]ertical)
nnoremap <leader>wv <C-w>v
" Split the current window horizontally ([w]indow [h]orizontal)
nnoremap <leader>wh <C-w>s
" Maximize the current window ([w]indow [M]aximize)
nnoremap <leader>wM <C-w>_
" Minimize the current window ([w]indow [m]inimize)
nnoremap <leader>wm <C-w>1_
" Make all windows equal size ([w]indow [e]qual)
nnoremap <leader>we <C-w>=
" Move current window to new tab ([w]indow [t]ab)
" (note: <leader>wt conflicts with vimwiki)
nnoremap <leader>wT <C-w>T
" Close the current window ([w]indow [c]lose)
nnoremap <leader>wc :quit<CR>

" Open a new terminal in a horizontal split ([s]plit [t]erminal [h]orizontal)
nnoremap <leader>tsh :HSplitTerminal<CR>
" Open a new terminal in a vertical split ([s]plit [t]erminal [v]ertical)
nnoremap <leader>tsv :VSplitTerminal<CR>
" Open a new terminal in a new tab ([t]erminal [t]ab [n]ew)
nnoremap <leader>ttn :TabTerminal<CR>

" Open a new tab ([t]ab [n]ew)
nmap <leader>tn :tabnew<CR>
" Close the current tab ([t]ab [c]lose)
nmap <leader>tc :tabclose<CR>
" Alt-. to move 1 tab to the right
nmap <M-.> gt
" Alt-, to move 1 tab to the left
nmap <M-,> gT

" Yank selection to system clipboard
vnoremap <leader>y "+y
" Yank current line to system clipboard
nnoremap <leader>yy "+yy
" Yank entire buffer to system clipboard
nnoremap <leader>Y :%y+<CR>

" Remove trailing whitespace ([c]lear [w]hitespace)
nnoremap <leader>cw :RTrailing<CR>

" f for 'format', g for 'goto', r for 'replace', d for 'doc(umentation)'
" Conveniently, 'rdfg' also makes the same shape as 'wasd' on a QWERTY keyboard
nnoremap <leader>f :Format<CR>
nnoremap <leader>g :GotoDef<CR>
nnoremap <leader>r :Rename<CR>
nnoremap <leader>d :ShowDoc<CR>

" Use Tab to cycle through completion options
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" Use the spacebar to open a fold
nnoremap <space> zo
" Use Ctrl-space to close a fold
if has("unix")
    " Ctrl-space is sent as Ctrl-@ on unix-like systems
    nnoremap <C-@> zc
else
    nnoremap <C-space> zc
endif

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <F7> :UndotreeToggle<CR>
" F8 to open a Tagbar
nnoremap <F8> :TagbarToggle<CR>
" F12 to open netrw in a new vertical split on the left
nnoremap <F12> :Lexplore<CR>

" Automatically remove trailing whitespace on write/save
augroup remove_trailing_whitespace
    autocmd! remove_trailing_whitespace
    autocmd BufWritePre * :call RemoveTrailingWhitespace()
augroup END

" Workaround to prevent split borders and status line from showing after
" regaining focus in full screen mode
" https://github.com/junegunn/goyo.vim/issues/174
function! s:goyo_enter()
    " https://stackoverflow.com/questions/27870682/how-to-get-the-background-color-in-vim
    let bg = synIDattr(hlID('Normal'), 'bg')
    execute "hi VertSplit guifg=" . bg . " guibg=" . bg
    set laststatus=0
    Limelight
endfunction

function! s:goyo_leave()
    exec "colorscheme " . g:colors_name
    set laststatus=2
    Limelight!
endfunction

nmap <leader>/ :Goyo<CR>
nmap <leader>l :Limelight<CR>
xmap <leader>l :Limelight<CR>
nmap <leader>L :Limelight!<CR>
xmap <leader>L :Limelight!<CR>

augroup goyo_limelight_auto
    autocmd! goyo_limelight_auto
    autocmd User GoyoEnter nested call <SID>goyo_enter()
    autocmd User GoyoLeave nested call <SID>goyo_leave()
augroup END

" Set keybindings for SuperCollider files
augroup supercollider
    autocmd! supercollider

    autocmd FileType supercollider command! SCLive :Goyo | :SCNvimStart
    " TODO: intelligently toggle post window in case sclang is already running
    " TODO: toggle Live mode (i.e. make a Live! command, if possible)

    " [e]valuate and send (block)
    autocmd FileType supercollider,help.supercollider nmap <buffer> <leader>e           <Plug>(scnvim-send-block)
    " [e]valuate and send (line)
    autocmd FileType supercollider,help.supercollider nmap <buffer> <leader><C-e>       <Plug>(scnvim-send-line)
    " [e]valuate and send (selection)
    autocmd FileType supercollider,help.supercollider vmap <buffer> <leader>e           <Plug>(scnvim-send-selection)
    " Stop [E]valuation
    autocmd FileType supercollider,help.supercollider nmap <buffer> <leader>E           <Plug>(scnvim-hard-stop)
    " [h]elp command shortcut
    autocmd FileType supercollider,help.supercollider nmap <buffer> <leader>h           :SCNvimHelp<space>

    " Toggle [p]ost window
    autocmd FileType supercollider,help.supercollider nmap <buffer> <localleader>p      <Plug>(scnvim-postwindow-toggle)
    " [s]tart sclang
    autocmd FileType supercollider,help.supercollider nmap <buffer> <localleader>s      :SCNvimStart<CR>
    " [S]top sclang
    autocmd FileType supercollider,help.supercollider nmap <buffer> <localleader>S      :SCNvimStop<CR>
    " [r]estart sclang/[r]ecompile class library
    autocmd FileType supercollider,help.supercollider nmap <buffer> <localleader>r      :SCNvimRecompile<CR>

    " Disable line numbers in SCHelp files
    autocmd FileType help.supercollider setlocal nonumber norelativenumber
augroup END
