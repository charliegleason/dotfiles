" Open a terminal in a new split
function! SplitTerminal()
    new | terminal
endfunction

" Open a terminal in a new tab
function! TabTerminal()
    tabnew | terminal
endfunction

" LanguageClient commands
command! Format :call LanguageClient_textDocument_formatting()
command! Gotodef :sp | call LanguageClient_textDocument_definition()
command! Rename :call LanguageClient_textDocument_rename()
command! Showdoc :call LanguageClient_textDocument_hover()

" Commands for opening terminals
command! Splitterminal :call SplitTerminal()
command! Tabterminal :call TabTerminal()

" Remove trailing whitespace in the current buffer
function! RemoveTrailingWhitespace()
    % substitute /\s\+$//g
endfunction

command! Rtrailing :call RemoveTrailingWhitespace()


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

" Use Alt-s and Alt-v to make horizontal and vertical splits, respectively
nnoremap <M-s> <C-w>s
nnoremap <M-v> <C-w>v
" Use Alt-n to open a new (empty) horizontal split
nnoremap <M-n> <C-w>n

" Make Esc behave the same in terminal mode as in other modes
tnoremap <Esc> <C-\><C-n>
tnoremap <M-[> <Esc>
tnoremap <C-v><Esc> <Esc>

" f for 'format', g for 'goto', r for 'replace', d for 'doc(umentation)'
" Conveniently, 'rdfg' also makes the same shape as 'wasd' on a QWERTY keyboard
nnoremap <leader>f :Format<CR>
nnoremap <leader>g :Gotodef<CR>
nnoremap <leader>r :Rename<CR>
nnoremap <leader>d :Showdoc<CR>

" Key commands for opening terminals
nnoremap <leader>st :Splitterminal<CR>
nnoremap <leader>tt :Tabterminal<CR>

" Remove trailing whitespace
nnoremap <leader>tw :Rtrailing<CR>

" Open a new tab
nmap <leader>tn :tabnew<CR>
" Close the current tab
nmap <leader>tc :tabclose<CR>
" Alt-. to move 1 tab to the right
nmap <M-.> gt
" Alt-, to move 1 tab to the left
nmap <M-,> gT

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
