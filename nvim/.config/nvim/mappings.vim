" Resize splits proportionally to the size of their buffer
function! ResizeVerticalProportional()
    " Don't show movements unless explicitly specified
    set lazyredraw

    let current_window = winnr()
    let num_windows = winnr('$')
    let buffer_sizes = []

    " Calculate the total number of lines in the buffers on the current tab page.
    let buffer_size_sum = 0
    for i in range(1, num_windows)
        let buffer_size = len(getbufline(winbufnr(i), 1, '$'))
        let buffer_sizes = add(buffer_sizes, [buffer_size, i])
        let buffer_size_sum += buffer_size
    endfor

    " Sort the buffer sizes from smallest to largest
    let buffer_sizes = sort(buffer_sizes)

    " Calculate the window sizes
    let window_sizes = []
    let min_window_size = 15

    if buffer_size_sum > &lines
        " If the total number of lines in all the buffers is greater than the
        " window height, resize each split proportionally.
        for i in range(1, num_windows)
            let window_size = floor(&lines) * (floor(buffer_sizes[i - 1][0]) / floor(buffer_size_sum))
            let window_size = max([float2nr(window_size), float2nr(min_window_size)])
            let window_sizes = add(window_sizes, [window_size, buffer_sizes[i - 1][1]])
        endfor
    else
        " Otherwise, resize each split to its length.
        for i in range(1, num_windows)
            let window_size = floor(buffer_sizes[i - 1][0])
            let window_size = max([float2nr(window_size), float2nr(min_window_size)])
            let window_sizes = add(window_sizes, [buffer_sizes[i - 1][1], window_size])
        endfor
    endif

    let window_sizes = sort(window_sizes)

    " Select topmost buffer
    for i in range(1, current_window)
        wincmd k
    endfor

    " Set window sizes
    let remaining_height = &lines

    for i in range(1, num_windows)
        " Go to the (next smallest) window
        let distance = winnr() - float2nr(window_sizes[i - 1][0])
        for j in range(0, abs(distance))
            if distance > 0
                wincmd k
            else
                wincmd j
            endif
        endfor
        let window_size = min([window_sizes[i - 1][1], remaining_height])
        " Resize the window
        exec 'resize' . ' ' . float2nr(window_size)
        let remaining_height -= window_size
    endfor

    " Select original active window
    for i in range(1, winnr() - current_window)
        wincmd k
    endfor

    " Always redraw on movements
    set nolazyredraw
endfunction

function! ResizeBufferLength()
    let last_first_visible = line('w0')

    exec "resize" . " " . line('$')

    let current_first_visible = line('w0')
    let distance = current_first_visible - last_first_visible

    if distance > 0
        exec "normal!" . " " . distance . "\<C-e>"
    elseif distance < 0
        exec "normal!" . " " . distance . "\<C-y>"
    endif
endfunction

" Open a terminal in a new split
function! TerminalSplitH()
    new | terminal
endfunction

function! TerminalSplitV()
    vnew | terminal
endfunction

" Open a terminal in a new tab
function! TerminalTabNew()
    tabnew | terminal
endfunction

function! MakeRun()
    nnoremap :terminal make -j8 && make run
    inoremap :terminal make -j8 && make run
endfunction

" Remove trailing whitespace in the current buffer
function! RemoveTrailingWhitespace()
    let pos = getcurpos()
    silent! % substitute /\s\+$//g
    call setpos('.', pos)
endfunction

" Commands for opening terminals
command! TerminalSplitH :call TerminalSplitH()
command! TerminalSplitV :call TerminalSplitV()
command! TerminalTabNew :call TerminalTabNew()

command! ResizeBufferLength :call ResizeBufferLength()

command! RTrailing :call RemoveTrailingWhitespace()

" LanguageClient commands
command! Format :call LanguageClient_textDocument_formatting()
command! GotoDef :sp | call LanguageClient_textDocument_definition()
command! Rename :call LanguageClient_textDocument_rename()
command! ShowDoc :call LanguageClient_textDocument_hover()

" Set <leader>
let mapleader = "\\"
" Set <localleader>
let maplocalleader = ","

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
" Move current window to new tab ([w]indow [T]ab) (note: <leader>wt conflicts with vimwiki)
nnoremap <leader>wT <C-w>T
" Close the current window ([w]indow [c]lose)
nnoremap <leader>wc :quit<CR>
" Resize the curren window to the buffer length
nnoremap <leader>wl :ResizeBufferLength<CR>

" Open a new terminal in a horizontal split ([t]erminal [s]plit [h]orizontal)
nnoremap <leader>tsh :TerminalSplitH<CR>
" Open a new terminal in a vertical split ([t]erminal [s]plit [v]ertical)
nnoremap <leader>tsv :TerminalSplitV<CR>
" Open a new terminal in a new tab ([t]erminal [t]ab [n]ew)
nnoremap <leader>ttn :TerminalTabNew<CR>

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
" nnoremap <F12> :Lexplore<CR>

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

" create a custom status line for supercollider buffers
function! s:set_sclang_statusline()
    call airline#parts#define_function('sclang_status', 'scnvim#statusline#server_status')
    let g:airline_section_y = airline#section#create_right(['', 'sclang_status'])
endfunction

" Set keybindings and statusline for SuperCollider files
augroup supercollider
    autocmd! supercollider

    autocmd FileType supercollider call <SID>set_sclang_statusline()

    autocmd FileType supercollider command! SCLive :Goyo | :SCNvimStart
    " TODO: intelligently toggle post window in case sclang is already running
    " TODO: toggle Live mode (i.e. make a Live! command, if possible)

    " [e]valuate and send (block)
    autocmd FileType supercollider,help.supercollider nmap <buffer> <leader>e       <Plug>(scnvim-send-block)
    " [e]valuate and send (line)
    autocmd FileType supercollider,help.supercollider nmap <buffer> <leader>le      <Plug>(scnvim-send-line)
    " [e]valuate and send (selection)
    autocmd FileType supercollider,help.supercollider vmap <buffer> <leader>e       <Plug>(scnvim-send-selection)
    " Stop [E]valuation
    autocmd FileType supercollider,help.supercollider nmap <buffer> <leader>E       <Plug>(scnvim-hard-stop)
    " [h]elp command shortcut
    autocmd FileType supercollider,help.supercollider nmap <buffer> <leader>h       :SCNvimHelp<space>

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
