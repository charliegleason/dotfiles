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
nnoremap <leader>wv <C-w>s
" Split the current window horizontally ([w]indow [h]orizontal)
nnoremap <leader>wh <C-w>v
" Maximize the current window ([w]indow [M]aximize)
nnoremap <leader>wM <C-w>_
" Minimize the current window ([w]indow [m]inimize)
nnoremap <leader>wm <C-w>1_
" Make all windows equal size ([w]indow [e]qual)
nnoremap <leader>we <C-w>=
" Move current window to new tab ([w]indow [t]ab)
nnoremap <leader>wt <C-w>T
" Close the current window ([w]indow [c]lose)
nnoremap <leader>wc :quit<CR>

" Open a new terminal in a horizontal split ([t]erminal [h]orizontal)
nnoremap <leader>th :HSplitTerminal<CR>
" Open a new terminal in a vertical split ([t]erminal [v]ertical)
nnoremap <leader>tv :VSplitTerminal<CR>
" Open a new terminal in a new tab ([t]erminal [t]ab)
nnoremap <leader>tt :TabTerminal<CR>

" Open a new tab ([t]ab [n]ew)
nmap <leader>tn :tabnew<CR>
" Close the current tab ([t]ab [c]lose)
nmap <leader>tc :tabclose<CR>
" Alt-. to move 1 tab to the right
nmap <M-.> gt
" Alt-, to move 1 tab to the left
nmap <M-,> gT

" Yank to system clipboard
nnoremap <leader>y "+y
" Yank current line to system clipboard
nnoremap <leader>yy "+yy
" Yank entire buffer to system clipboard
nnoremap <leader>Y :%y+<CR>

" Remove trailing whitespace ([c]lear [w]hitespace)
nnoremap <leader>cw :Rtrailing<CR>

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

" Set keybindings for SuperCollider files
augroup supercollider
    autocmd! supercollider
    let maplocalleader = "\\"
    " Evaluate and [s]end (block)
    autocmd FileType supercollider,help.supercollider nmap <buffer> <leader>s           <Plug>(scnvim-send-block)
    " Evaluate and [s]end (line)
    autocmd FileType supercollider,help.supercollider  nmap <buffer> <leader><C-s>      <Plug>(scnvim-send-line)
    " Evaluate and [s]end (selection)
    autocmd FileType supercollider,help.supercollider vmap <buffer> <leader>s           <Plug>(scnvim-send-selection)
    " [S]top evaluation
    autocmd FileType supercollider,help.supercollider nmap <buffer> <leader>S           <Plug>(scnvim-hard-stop)

    " Toggle post [w]indow
    autocmd FileType supercollider,help.supercollider nmap <buffer> <localleader>w      <Plug>(scnvim-postwindow-toggle)
    " [s]tart sclang
    autocmd FileType supercollider,help.supercollider nmap <buffer> <localleader>s      :SCNvimStart<CR>
    " [S]top sclang
    autocmd FileType supercollider,help.supercollider nmap <buffer> <localleader>S      :SCNvimStop<CR>
augroup END
